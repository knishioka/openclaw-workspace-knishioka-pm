<!-- version: 2026-05-21 (Issue #37) -->

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

## 変更手順（編集 → 生成 → 検証 → commit）

```bash
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
