# Cron フェイルセーフ整備（同時実行制限・failureAlert 被覆監査） (2026-05-21)

> Issue #36。cron 全体のフェイルセーフ設定（同時実行制限・失敗通知の被覆）を
> 公式ベストプラクティスに寄せる。timeout 調整・スケジュール変更は対象外。

## 1. グローバル同時実行制限 (`cron.maxConcurrentRuns`)

`~/.openclaw/openclaw.json` に `cron` キー自体が存在せず（実質 `{}`）、同時実行の
保険がなかった。ライブ登録は **全ワークスペース合算で 50 ジョブ**（ds-pm 29 /
personal 10 / knishioka-pm 5 / ds-tm 5 / family 1）あり、週次ジョブが
19:00–20:00 帯に集中するため多重起動時の CPU/メモリ保護がない。

**実施:** `cron.maxConcurrentRuns: 3` を追加（公式スキーマ
`Cron Max Concurrent Runs` 準拠。同時 LLM 実行を 3 本に制限）。

```bash
# backup（Constraint 準拠）
cp -p ~/.openclaw/openclaw.json ~/.openclaw/openclaw.json.bak.2026-05-21
```

```jsonc
// ~/.openclaw/openclaw.json （追加分のみ。他キーは無変更）
{
  "cron": {
    "maxConcurrentRuns": 3
  },
  ...
}
```

> **注意:** `maxConcurrentRuns` は **全ワークスペース共通のグローバル設定**で、
> knishioka-pm 以外のジョブのスケジューリングにも作用する（Ken 承認済み）。
> **gateway が config を読むのは起動時**のため、ライブ反映には
> `openclaw gateway restart` が必要。本作業では実行中ジョブ／セッションへの
> 影響を避けるため再起動はしていない。**次回の自然な gateway 再起動で適用**される。

## 2. failureAlert 被覆監査（knishioka-pm enabled ジョブ）

ライブ登録 (`openclaw cron list --json`) を直接監査。**全 5 ジョブが per-job
`failureAlert` を保有**（`config/cron/jobs.yaml` の `defaults.failure_alert`
から継承）。AC#2 の「全ジョブが個別 failureAlert を持つ」OR 分岐を満たす。

| Job (knishioka-pm)       | enabled | failureAlert         | delivery.bestEffort |
| ------------------------ | ------- | -------------------- | ------------------- |
| weekly-repo-health       | ✅      | after:2 / WA / 6h cd | true                |
| focus-task               | ✅      | after:2 / WA / 6h cd | （なし）            |
| weekly-knowledge-extract | ✅      | after:2 / WA / 6h cd | （なし）            |
| monthly-portfolio-review | ✅      | after:2 / WA / 6h cd | true                |
| private-repo-check       | ✅      | after:2 / WA / 6h cd | true                |

- `failureAlert`: 連続 2 回失敗で WhatsApp (`${KNISHIOKA_ALERT_TO}`)、cooldown 6h、`mode: announce`。
- 被覆率 **5/5 = 100%**（silent failure を全ジョブで検知可能）。

## 3. `cron.failureDestination` を設定しない判断（根拠付き）

OpenClaw 2026.5.7 のランタイム実装 (`dist/server-cron-*.js`) を読解した結果、
失敗通知には **独立した 2 経路** がある:

| 経路                 | 発火条件                                                                                                                         | 宛先解決                     |
| -------------------- | -------------------------------------------------------------------------------------------------------------------------------- | ---------------------------- |
| `failureAlert`       | 連続 N 回失敗（cooldown あり）。per-job が global を上書きし **ジョブ毎に 1 本**に解決 (`resolveFailureAlert`)                   | per-job `to` → `delivery.to` |
| `failureDestination` | **毎回のエラーで発火**。`delivery.bestEffort === true` のジョブのみ抑止 (`dispatchCronFailureDestinationNotifications` のガード) | per-job → global fallback    |

グローバル `failureDestination` を設定すると、`bestEffort` 未設定の
**focus-task / weekly-knowledge-extract** が**失敗のたびに**通知を発火し、
既存の per-job `failureAlert`（連続 2 回）と**二重通知 (スパム)** になる。
これは Issue の Constraint「グローバルと個別の二重通知でスパムにならない配分」
に反する。

**判断: `failureDestination` は設定しない。** per-job `failureAlert` が全
knishioka-pm ジョブを既に被覆しており（§2）、AC#2 は OR 分岐で充足済み。
グローバル `cron.failureAlert`（catch-all ポリシー）も、宛先が
per-job/`delivery.to` 依存で knishioka-pm では追加効果がないため設定しない。

## 4. 失敗通知経路の検証手順

故意失敗のダミー実行は (a) 実際に WhatsApp を送信し、(b) ライブ registry/state
を汚す恐れがあるため**ドキュメント手順で代替**（Issue AC が許容）。

経路が正しく構成されていることは、ライブ登録の `failureAlert` が §2 のとおり
全ジョブに焼き込まれていることで確認済み。実配信を手元で確認したい場合の手順:

```bash
# 1. 検証専用の使い捨てジョブを作り、必ず失敗するコマンドを after:1 で alert
#    （本番ジョブには触れない）。例（疑似）:
openclaw cron add --name _fa-smoke-test --schedule '@once' \
  --message 'exit 1 で失敗させる検証用' \
  --failure-after 1 --failure-channel whatsapp --failure-to "${KNISHIOKA_ALERT_TO}"
openclaw cron run _fa-smoke-test          # 即時実行
# 2. WhatsApp に "Cron job _fa-smoke-test failed: ..." が 1 通届くことを確認
# 3. 後始末（必須）
openclaw cron rm _fa-smoke-test
```

> 既存ジョブの自然失敗時は `consecutiveErrors >= 2` で通知が届く設計のため、
> 通常運用では追加の検証ジョブは不要。

## 5. スコープ外メモ（org 全体の被覆ギャップ → 別 Issue 候補）

org 全体 50 ジョブ中、**6 ジョブが failureAlert 未設定**だが、いずれも
**他ワークスペース**で Issue の Non-goals に該当（本 Issue 対象外）:

- `personal`: obsidian-heartbeat-001 / ai-english-watchdog / weekday-morning-todo / weekly-okr-review
- `ds-tm`: invoice-reminder / monthly-contractor-report

→ 必要なら別 Issue で各ワークスペース個別に対応。

## 6. ロールバック手順

```bash
cp -p ~/.openclaw/openclaw.json.bak.2026-05-21 ~/.openclaw/openclaw.json
# gateway 再起動済みなら再度 restart で反映
```

## 関連

- Issue #37 / PR #38: cron ジョブ定義の git 管理化（`config/cron/jobs.yaml`）。
  per-job `failureAlert` は同 PR の `defaults.failure_alert` で全ジョブに継承。
- `reports/cron-delivery-none-20260505.md`: delivery.mode 二重配信の整理（前提知識）。
- 公式: https://docs.openclaw.ai/automation/cron-jobs （Failure Alerts & Retries / Staggering & Load Management）
