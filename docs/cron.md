<!-- version: 2026-05-21 (Issue #37, #36) -->

# Cron Job Management

> knishioka-pm の cron ジョブ定義を **git 管理の宣言的ソース** にするための
> 正本。手で `~/.openclaw/cron/jobs.json` を編集する運用（差分レビュー・履
> 歴・ロールバック不能、`jobs.json.bak.*` の散乱）をやめ、`config/cron/jobs.yaml`
> を編集 → 生成 → 検証 → commit のフローに統一する。ds-pm ワークスペースの
> 同等の仕組みを移植・調整したもの。

## なぜこうするか

- `~/.openclaw/cron/jobs.json` は OpenClaw ランタイムの状態ファイルで、git
  管理されていない。手編集は履歴も差分レビューもなく壊れやすい（公式ドキュメ
  ントも「`jobs.json` は git、`jobs-state.json` は gitignore」を推奨）。
- このリポでは **`config/cron/jobs.yaml` が唯一の source-of-truth**。ここを
  PR で変更すればレビュー可能になり、ライブ登録内容との差分（drift）も検出で
  きる。

## ファイル構成

| パス                               | 役割                                                               | git  |
| ---------------------------------- | ------------------------------------------------------------------ | ---- |
| `config/cron/jobs.yaml`            | 宣言的ソース（5 ジョブ）。**編集するのはここだけ**                 | 追跡 |
| `scripts/build-cron-jobs.py`       | jobs.yaml → `build/cron/manifest.json` を生成（message_hash 付き） | 追跡 |
| `scripts/verify-cron-playbooks.sh` | manifest とライブ登録内容を比較し drift を検出（読み取り専用）     | 追跡 |
| `scripts/register-cron-jobs.sh`    | manifest をライブに適用。**既存ジョブは id を保ったまま edit**     | 追跡 |
| `build/cron/manifest.json`         | 生成物（gitignore 済み）                                           | 無視 |
| `~/.openclaw/cron/jobs.json`       | OpenClaw ランタイムのライブ登録（リポ外）                          | 無視 |
| `~/.openclaw/cron/jobs-state.json` | nextRun/lastRun 等のランタイム状態（リポ外）                       | 無視 |

## 環境変数（secret / PII）

このリポは **public** なので、電話番号などの機微情報は `jobs.yaml` に直書きせ
ず `${ENV_VAR}` 参照で持つ。`build-cron-jobs.py` がビルド時に環境変数から解決
してマニフェストに埋め込むため、git 追跡されるソースは scrub された状態を保つ。
解決された実値はライブ登録（register 時）に焼き込まれるので、**cron ランタイ
ム自体に env を設定する必要はない**（build / register / `verify --live` の実行時
にだけ必要）。

| 変数                 | 用途                               | 例              |
| -------------------- | ---------------------------------- | --------------- |
| `KNISHIOKA_ALERT_TO` | WhatsApp 通知 / failure_alert 宛先 | `+81xxxxxxxxxx` |

```bash
export KNISHIOKA_ALERT_TO='+81...'   # build / register / verify --live の前に
```

未設定のまま `build` / `register` / `verify --live` を実行すると、`${...}` が未解
決である旨のエラーで停止する（literal なプレースホルダーを誤登録しない安全装
置）。`verify --offline` と `build --check` は構造検証のみなので env なしで通る。

## 変更手順（編集 → 生成 → 検証 → commit）

```bash
# 0. secret/PII の env を設定（docs の「環境変数」参照）
export KNISHIOKA_ALERT_TO='+81...'

# 1. ソースを編集
$EDITOR config/cron/jobs.yaml

# 2. マニフェストを再生成
scripts/build-cron-jobs.py            # → build/cron/manifest.json

# 3. ライブ登録との差分を確認（何も変更しない）
scripts/verify-cron-playbooks.sh --live

# 4. ライブに適用（既存ジョブは id・state を保持したまま更新）
scripts/register-cron-jobs.sh --dry-run   # まず計画を確認
scripts/register-cron-jobs.sh             # 適用

# 5. 適用後、再度 drift ゼロを確認してから commit
scripts/verify-cron-playbooks.sh --live
git add config/cron/jobs.yaml && git commit
```

> **AGENTS.md 準拠:** `scripts/*` と本ワークスペースの構成ファイルの追加・変
> 更は cron / 自動セッションからは不可。Ken との対話 or 明示承認下でのみ行う。

## state を壊さない設計（schedule-identity）

`scripts/register-cron-jobs.sh` は ds-pm 版の「rm して add し直す」方式を採
らない。rm+add は新しい job id を発番し、`nextRun` / `lastRun` /
`consecutiveErrors` がリセットされてしまうため。代わりに **ライブジョブを名
前で突き合わせ、`openclaw cron edit <id>` で in-place 更新**する。新規ジョブ
だけが `openclaw cron add` で作られ、既存ジョブが削除されることはない。これ
により Issue #37 の制約「既存ジョブの state を破壊しない / schedule-identity
を変えない」を満たす。

## jobs.yaml スキーマ

```yaml
schema_version: 1
defaults: # 全ジョブ共通。各ジョブのキーで個別に上書き可
  agent_id: knishioka-pm
  tz: Asia/Kuala_Lumpur
  enabled: true
  session_target: isolated
  wake_mode: now
  thinking: medium
  failure_alert:
    { after, channel, to, cooldown_ms, mode, account_id, best_effort }
jobs:
  - name: weekly-repo-health
    description: ...
    schedule: { kind: cron, expr: "0 20 * * 0" } # tz は defaults から
    timeout_seconds: 900 # ジョブ固有
    delivery: { mode: none, channel: whatsapp, to: "+81...", best_effort: true }
    message: | # 完全なエージェントプロンプト（drift checker がハッシュ照合）
      ...
```

- `message` は knishioka ジョブの全プロンプト（別ファイルの playbook は持た
  ない）。一字一句が `message_hash` に効くので、改行・空白も含めてそのまま保
  持する。
- `delivery.mode: none` はジョブ完了テキストを fallback 配信しない。`announce`
  は `channel` / `to` へ転送する。
- `model` は省略時エージェント既定。`thinking` は省略時 `defaults.thinking`。

## ドリフト検出のモード

| コマンド                                     | 用途                                                          |
| -------------------------------------------- | ------------------------------------------------------------- |
| `verify-cron-playbooks.sh --live`            | ライブ登録（`openclaw cron list`）と manifest を比較。既定    |
| `verify-cron-playbooks.sh --offline`         | openclaw を呼ばず jobs.yaml がビルドできるかだけ確認（CI 用） |
| `verify-cron-playbooks.sh --snapshot <path>` | 記録済み JSON スナップショットと比較                          |

CI（`.github/workflows/check.yml`）は `--offline`（+ PyYAML）で
`config/cron/jobs.yaml` が常にビルド可能であることを保証する。

## グローバル scheduler 設定（`~/.openclaw/openclaw.json` の `cron`）

`jobs.yaml` は **per-job** 定義のソース。一方、スケジューラ**全体**に効く設定
（同時実行制限・失敗通知の fallback 等）は OpenClaw ランタイム config
`~/.openclaw/openclaw.json` の `cron` キーに置く。**このファイルは git 追跡外**
（リポ外の runtime 状態）なので、変更内容は本ドキュメントと `reports/` の監査
記録でレビュー可能にする。Issue #36 で以下を整備した。

| キー                     | 値  | 意図                                                                  |
| ------------------------ | --- | --------------------------------------------------------------------- |
| `cron.maxConcurrentRuns` | `3` | 同時 LLM 実行を 3 本に制限。週次ジョブ集中時の CPU/メモリ多重起動保険 |

`~/.openclaw/openclaw.json` に追記:

```json
{ "cron": { "maxConcurrentRuns": 3 } }
```

- **グローバル設定**のため全ワークスペース（ds-pm / personal / ds-tm / family /
  knishioka-pm、合計約 50 ジョブ）に作用する。
- gateway は config を**起動時に読む**。変更後は `openclaw gateway restart` で反映。
- 編集前に `~/.openclaw/openclaw.json.bak.<日付>` を取得すること。

### `cron.failureDestination` を設定しない理由

OpenClaw には失敗通知が 2 経路ある: per-job/global の `failureAlert`
（連続 N 回失敗で 1 本に解決）と `failureDestination`（**毎回のエラー**で発火、
`delivery.bestEffort: true` のジョブのみ抑止）。グローバル `failureDestination`
を足すと、`bestEffort` 未設定の `focus-task` / `weekly-knowledge-extract` が
失敗のたびに通知し、既存 `failureAlert` と**二重通知**になる。knishioka-pm の
全ジョブは既に per-job `failureAlert` を持つ（`defaults.failure_alert`）ため、
**`failureDestination` は設定しない**。詳細・監査結果は
`reports/cron-failsafe-audit-20260521.md` を参照。
