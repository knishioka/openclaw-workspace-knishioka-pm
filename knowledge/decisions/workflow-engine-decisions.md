# workflow-engine Design Decisions

## 2026-04-20: fix(github_pr_events): prevent duplicate Notion tasks and skip merged PRs

- **What**: fix(github_pr_events): prevent duplicate Notion tasks and skip merged PRs
- **Why**: - `GitHub PR → Notion` ワークフローで同じ PR から Notion タスクが2個作られる問題と、cron 起動時に既に merged/closed の PR でもタスクが作られる問題を修正 - 新規テスト4件追加 (全1265件 pass)
- **Source**: PR #147

## 2026-04-16: fix(scripts): migrate sync_and_deploy.py from Secret Manager to GCS tokens.json

- **What**: fix(scripts): migrate sync_and_deploy.py from Secret Manager to GCS tokens.json
- **Why**: Closes #143
- **Source**: PR #144

## 2026-03-18: perf(state): add in-memory TTL cache for GCS state reads

- **What**: perf(state): add in-memory TTL cache for GCS state reads
- **Why**: No summary captured.
- **Source**: PR #142

## 2026-03-17: perf(state): reduce GCS API calls for state management

- **What**: perf(state): reduce GCS API calls for state management
- **Why**: No summary captured.
- **Source**: PR #140

## 2026-03-09: feat: add sync_and_deploy.py to ensure Secret Manager + Cloud Run sync

- **What**: feat: add sync_and_deploy.py to ensure Secret Manager + Cloud Run sync
- **Why**: No summary captured.
- **Source**: PR #138

## 2026-03-08: feat(github_pr): add Search API mode for cross-org PR monitoring

- **What**: feat(github_pr): add Search API mode for cross-org PR monitoring
- **Why**: - GitHub PR→Notion タスク作成ワークフローを、リポジトリ個別ポーリングから **GraphQL Search API** に変更 - `author` パラメータ指定で全アクセス可能リポジトリのPRを **1回のAPIコール** で取得 - 3つのワークフロー（personal/D-stats/datainformed-jp）を1つに統合可能に - リポジトリリストのメンテナンス不要、新しいリポジトリは自動的に監視対象
- **Source**: PR #137

## 2026-03-05: fix(auth): detect missing OAuth scopes and force full re-authentication

- **What**: fix(auth): detect missing OAuth scopes and force full re-authentication
- **Why**: 背景
- **Source**: PR #136

## 2026-01-17: fix(memory): prevent GCS/Firestore client memory leak in Cloud Run (#133)

- **What**: fix(memory): prevent GCS/Firestore client memory leak in Cloud Run (#133)
- **Why**: No summary captured.
- **Source**: PR #134
