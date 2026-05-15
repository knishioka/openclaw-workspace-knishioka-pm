# workflow-engine Design Decisions

Updated: 2026-05-15

## 2026-05-12: fix(notion): bump HTTPClient timeout to 30s to avoid ReadTimeoutError

- **What**: ## Summary - Increase the Notion HTTPClient timeout from 10s → 30s in `service_manager.get_notion_client()` - The Notion query API exceeds 10s when scanning the Tasks DB with a...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #153

## 2026-05-11: feat(actions): bundle multi-item LINE notifications via batch mode

- **What**: ## Background ファミリーカレンダーで一度に多数の予定変更が起きた際、現状はイベントごとに個別の LINE push が走り、`max_per_execution=10` の rate limiter で10件目以降が失敗する（2026-05-11 06:00 UTC で実際に発生）。 ## Summary - ワークフロー設定に...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #152

## 2026-05-02: feat(notion): auto-close Notion tasks when their GitHub PR is merged

- **What**: ## Summary - Adds new trigger `notion_pr_tasks` and action `notion_close_task_if_pr_merged` that periodically scan the Notion `tasks` DB for incomplete tasks with GitHub PR URLs...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #151

## 2026-04-28: chore: upgrade default LLM from Sonnet 4.5 to Sonnet 4.6

- **What**: ## Summary - `claude-sonnet-4-5-20250929` → `claude-sonnet-4-6` - 同価格帯で品質向上、API 互換性あり - 影響箇所: workflows.yaml の 2 ワークフロー (`github_pr_to_notion`, `school_message_analyze`)、3...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #150

## 2026-04-28: fix(github_pr_to_notion): skip Notion task creation for merged/closed PRs

- **What**: ## Summary - Trigger fetch から action 実行までの間に PR が merge/close されると、古い `open` スナップショットで Notion task が作られてしまう問題を修正 - `GitHubPRToNotionAction` に optional config `github_account`...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #149

## 2026-04-20: fix(github_pr_events): prevent duplicate Notion tasks and skip merged PRs

- **What**: ## Summary - `GitHub PR → Notion` ワークフローで同じ PR から Notion タスクが2個作られる問題と、cron 起動時に既に merged/closed の PR でもタスクが作られる問題を修正 - 新規テスト4件追加 (全1265件 pass) ## Bug 1: 重複タスク（state file...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #147

## 2026-04-16: fix(scripts): migrate sync_and_deploy.py from Secret Manager to GCS tokens.json

- **What**: Closes #143 ## Summary After the Secret Manager → GCS migration (89f7552, 630be37), `scripts/sync_and_deploy.py` was left pointing at the obsolete Secret Manager API. Re-running...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #144

## 2026-03-18: perf(state): add in-memory TTL cache for GCS state reads

- **What**: ## Summary - Add module-level state cache with 45s TTL to eliminate redundant GCS reads on warm Cloud Run instances - 90%+ of executions (no new items) now hit cache instead of...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #142

## 2026-03-17: perf(state): reduce GCS API calls for state management

- **What**: ## Summary - Remove redundant `blob.exists()` calls in GCS load/save operations (3→2 and 2→1 API calls) - Cache migration status on warm Cloud Run instances to skip repeated GCS...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #140

## 2026-03-09: feat: add sync_and_deploy.py to ensure Secret Manager + Cloud Run sync

- **What**: ## Summary - Secret Manager のトークン更新後に Cloud Run リデプロイを忘れると、古いトークンが使われ続ける問題を解決 - `scripts/sync_and_deploy.py` を追加: トークンアップロード + Cloud Run リデプロイを1コマンドで実行 -...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #138
