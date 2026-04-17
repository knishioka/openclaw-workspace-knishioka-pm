# workflow-engine Design Decisions

## 2026-04-16: fix(scripts): migrate sync_and_deploy.py from Secret Manager to GCS tokens.json

- **What**: fix(scripts): migrate sync_and_deploy.py from Secret Manager to GCS tokens.json
- **Why**: Closes #143 ## Summary After the Secret Manager → GCS migration (89f7552, 630be37), `scripts/sync_and_deploy.py` was left pointing at the obsolete Secret Manager API. Re-running it would update Secret Manager versions while Cloud Run kept reading the unchanged GCS `tokens.json` — token updates silently never reached production. This PR rewires the script to operate on `gs://${STATE_BUCKET}/config/tokens.json` direct…
- **Source**: PR #144

## 2026-03-18: perf(state): add in-memory TTL cache for GCS state reads

- **What**: perf(state): add in-memory TTL cache for GCS state reads
- **Why**: ## Summary - Add module-level state cache with 45s TTL to eliminate redundant GCS reads on warm Cloud Run instances - 90%+ of executions (no new items) now hit cache instead of GCS - Returns deep copies to prevent mutation of cached data - Cache updated on both load and save; optimistic locking still protects writes Expected: ~$20/month → ~$8/month (GCS operations) Closes #141 ## Test plan - [x] All 1261 tests pass …
- **Source**: PR #142

## 2026-03-17: perf(state): reduce GCS API calls for state management

- **What**: perf(state): reduce GCS API calls for state management
- **Why**: ## Summary - Remove redundant `blob.exists()` calls in GCS load/save operations (3→2 and 2→1 API calls) - Cache migration status on warm Cloud Run instances to skip repeated GCS reads on init - Batch `mark_action_completed()` in memory, flush once at `mark_item_processed()` - Remove redundant `get_completed_actions()` GCS read before `mark_item_processed()` Expected reduction: ~17,000 GCS calls/day → ~8,000 (~$78/mo…
- **Source**: PR #140

## 2026-03-09: feat: add sync_and_deploy.py to ensure Secret Manager + Cloud Run sync

- **What**: feat: add sync_and_deploy.py to ensure Secret Manager + Cloud Run sync
- **Why**: ## Summary - Secret Manager のトークン更新後に Cloud Run リデプロイを忘れると、古いトークンが使われ続ける問題を解決 - `scripts/sync_and_deploy.py` を追加: トークンアップロード + Cloud Run リデプロイを1コマンドで実行 - `.claude/rules/authentication.md` を更新: リデプロイ必須を CRITICAL として明記、パイプラインとチェックリストを改訂 ## Background Google Forms の 403 エラーが継続していた原因: 1. ローカルトークンは再認証済み（9スコープ、`spreadsheets.readonly` 含む） 2. Secret Manager には古いトークン（3スコープのみ）が残っていた 3. Secret Manager を更新しても Cloud Run は cold s…
- **Source**: PR #138

## 2026-03-08: feat(github_pr): add Search API mode for cross-org PR monitoring

- **What**: feat(github_pr): add Search API mode for cross-org PR monitoring
- **Why**: ## Summary - GitHub PR→Notion タスク作成ワークフローを、リポジトリ個別ポーリングから **GraphQL Search API** に変更 - `author` パラメータ指定で全アクセス可能リポジトリのPRを **1回のAPIコール** で取得 - 3つのワークフロー（personal/D-stats/datainformed-jp）を1つに統合可能に - リポジトリリストのメンテナンス不要、新しいリポジトリは自動的に監視対象 ### 変更点 - `_fetch_via_search()`: GraphQL `search(query: "is:pr author:X updated:>=...")` で横断検索 - `author` config を `repositories` の代替として追加（後方互換性維持） - 重複防止: イベントID `opened_{pr_id}` による状態管理…
- **Source**: PR #137

## 2026-03-05: fix(auth): detect missing OAuth scopes and force full re-authentication

- **What**: fix(auth): detect missing OAuth scopes and force full re-authentication
- **Why**: ## 背景 `gmail_poolsalon_info` アカウントで HTTP 403 エラーが24件発生。原因はトークンに `spreadsheets.readonly` スコープが不足していたこと。 ## 問題の根本原因 `authenticate_gmail_multi.py` は既存トークンが期限切れの場合に `creds.refresh()` でリフレッシュするが、**refresh_token は元の OAuth フローで付与されたスコープ内でしか更新できない**。新しいスコープが `SCOPES` に追加されても、既存トークンをリフレッシュするだけでは新スコープは付与されない。 ``` 旧フロー（問題あり）: トークン読み込み → 期限切れ → refresh() → 成功 ✅ (でもスコープ不足のまま) → Cloud Run で 403 エラー 新フロー（修正後）: トークン読み込み → スコープチェック …
- **Source**: PR #136

## 2026-01-17: fix(memory): prevent GCS/Firestore client memory leak in Cloud Run (#133)

- **What**: fix(memory): prevent GCS/Firestore client memory leak in Cloud Run (#133)
- **Why**: ## Summary Fixes critical memory leak in Cloud Run causing OOM crashes after ~12 hours of operation. **Root Cause:** Each `StateManager` and `FirestoreLock` instance created new GCS/Firestore clients, causing unbounded memory growth over time. **Solution:** Implement global singleton pattern for GCS and Firestore clients, ensuring only one client instance per container lifetime. Closes #133 ## Changes ### Memory Lea…
- **Source**: PR #134

## 2026-01-09: fix(error_tracker): add file locking to prevent JSON corruption

- **What**: fix(error_tracker): add file locking to prevent JSON corruption
- **Why**: ## Summary - Add two-level locking (thread lock + file lock) to ErrorTracker to prevent JSON corruption during concurrent access - Add `fcntl` file locking (`LOCK_EX` for writes, `LOCK_SH` for reads) following StateManager pattern - Add `threading.Lock` for thread-level synchronization within the same process - Use `a+` mode for atomic file creation ## Test plan - [x] Added `TestErrorTrackerFileLocking` class with 3…
- **Source**: PR #132
