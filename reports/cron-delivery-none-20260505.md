# Cron `delivery.mode` 整理 (2026-05-05)

## 背景

ユーザ報告: 「podcast 生成時に WhatsApp に作成途中の報告なども投稿されている」。
ログ調査で `2026-05-05 05:12:26` に同一 sha256 のメッセージが 8 回連投されており、
これが「不要な投稿」の正体と特定。

## 根本原因

`~/.openclaw/cron/jobs.json` の各 job には `delivery.mode` フィールドがあり、`announce` は cron runner が prompt 外で開始/完了/エラーを自動 WhatsApp 投稿する。prompt 内で
WhatsApp 送信ロジックを持つ job では **二重配信** + **runner retry の連投** が発生する。

## 監査結果 (2026-05-05 朝)

| Job                         | 旧 mode    | prompt 内 WhatsApp 送信    | 判定                  | 新 mode           |
| --------------------------- | ---------- | -------------------------- | --------------------- | ----------------- |
| ai-english-daily (personal) | `announce` | ✅ Step 7 + 失敗 fallback  | 二重配信源 → 修正対象 | `none`            |
| weekly-repo-health          | `announce` | ✅ prompt 末尾の配信ルール | 二重配信源 → 修正対象 | `none`            |
| private-repo-check          | `announce` | ✅ Issue 作成完了通知      | 二重配信源 → 修正対象 | `none`            |
| monthly-portfolio-review    | `announce` | ❌ なし                    | 唯一の通知経路 → 残す | `announce` (維持) |
| focus-task                  | `none`     | ✅ Step 16 で WhatsApp     | 既に正常              | `none` (維持)     |
| weekly-knowledge-extract    | `none`     | (commit のみ)              | 既に正常              | `none` (維持)     |

## 実施した変更

```bash
# backup
cp ~/.openclaw/cron/jobs.json ~/.openclaw/cron/jobs.json.bak.pre-delivery-none-20260505

# 3 job の delivery.mode を "announce" → "none" に変更
jq '
  (.jobs[] | select(.name=="ai-english-daily") | .delivery.mode) |= "none" |
  (.jobs[] | select(.name=="weekly-repo-health") | .delivery.mode) |= "none" |
  (.jobs[] | select(.name=="private-repo-check") | .delivery.mode) |= "none"
' ~/.openclaw/cron/jobs.json > /tmp/jobs.json.new && mv /tmp/jobs.json.new ~/.openclaw/cron/jobs.json
```

## 期待される副次効果

- **weekly-repo-health の `lastRunStatus: error` も解消される見込み**: 5/3 の `lastError: "⚠️ ✉️ Message failed"` は `announce` 経路の delivery 失敗が原因。`none` で runner の自動配信が止まれば、prompt 内の `message` ツール呼び出しのみが配信経路となり、その失敗は `bestEffort: true` で job 全体は `ok` を返す
- `docs/environment.md` "既知の運用障害" 節の WhatsApp 失敗エントリも次回 weekly-repo-health (Sun 2026-05-10) で **再発しなければ削除**できる

## 検証ゲート

- 次回 ai-english-daily (毎日 05:00 KL = 21:00 UTC) で 1 通 (Step 7 の正規配信) のみが届くか観察
- 次回 weekly-repo-health (Sun 2026-05-10 20:00 KL) で `lastRunStatus: ok` になり、prompt 内の WhatsApp 通知 (1 通) のみが届くか観察
- 次回 private-repo-check (隔週水曜 20:00 KL = 12:00 UTC) で同上

## ロールバック手順

```bash
cp ~/.openclaw/cron/jobs.json.bak.pre-delivery-none-20260505 ~/.openclaw/cron/jobs.json
```

## 関連

- 前 PR (#32, 2026-05-05): `docs/environment.md` "既知の運用障害" 節新設 — WhatsApp 失敗の症状記録 (本変更で解消見込み)
