# workflow-engine Design Decisions

## 2026-03-08: feat(github_pr): add Search API mode for cross-org PR monitoring

- **What**: feat(github_pr): add Search API mode for cross-org PR monitoring
- **Why**: ## Summary - GitHub PR→Notion タスク作成ワークフローを、リポジトリ個別ポーリングから **GraphQL Search API** に変更 - `author` パラメータ指定で全アクセス可能リポジトリのPRを **1回のAPIコール** で取得 - 3つのワークフロー（personal/D-stats/datainformed-jp）を1つに統合可能に - リポジトリリストのメンテナンス不要、新しいリポジトリは自動的に監視対象
- **Source**: PR #137

## 2026-03-05: fix(auth): detect missing OAuth scopes and force full re-authentication

- **What**: fix(auth): detect missing OAuth scopes and force full re-authentication
- **Why**: `gmail_poolsalon_info` アカウントで HTTP 403 エラーが24件発生。原因はトークンに `spreadsheets.readonly` スコープが不足していたこと。
- **Source**: PR #136

## 2026-01-17: fix(memory): prevent GCS/Firestore client memory leak in Cloud Run (#133)

- **What**: fix(memory): prevent GCS/Firestore client memory leak in Cloud Run (#133)
- **Why**: Fixes critical memory leak in Cloud Run causing OOM crashes after ~12 hours of operation.
- **Source**: PR #134

## 2026-01-09: fix(error_tracker): add file locking to prevent JSON corruption

- **What**: fix(error_tracker): add file locking to prevent JSON corruption
- **Why**: ## Summary - Add two-level locking (thread lock + file lock) to ErrorTracker to prevent JSON corruption during concurrent access - Add `fcntl` file locking (`LOCK_EX` for writes, `LOCK_SH` for reads) following StateManager pattern - Add `th
- **Source**: PR #132

## 2026-01-09: perf(state-manager): add item count limit to prevent unbounded growth

- **What**: perf(state-manager): add item count limit to prevent unbounded growth
- **Why**: Add `max_items` parameter to `cleanup_old_state()` to prevent unbounded growth of `processed_items` in long-running, high-frequency workflows.
- **Source**: PR #131

## 2026-01-09: perf(error-tracker): optimize retention policy to reduce memory usage

- **What**: perf(error-tracker): optimize retention policy to reduce memory usage
- **Why**: Optimizes ErrorTracker retention policy to address Cloud Run memory limit exceeded errors (1024 MiB → 1040 MiB used).
- **Source**: PR #130
