# workflow-engine Design Decisions

## 2026-05-02: auto-close Notion tasks when their GitHub PR is merged

- **What**: auto-close Notion tasks when their GitHub PR is merged
- **Why**: Adds new trigger notion_pr_tasks and action notion_close_task_if_pr_merged that periodically scan the Notion tasks DB for incomplete tasks with GitHub PR URLs and mark them Done once the PR is merged/closed.
- **Source**: PR #151

## 2026-04-28: upgrade default LLM from Sonnet 4.5 to Sonnet 4.6

- **What**: upgrade default LLM from Sonnet 4.5 to Sonnet 4.6
- **Why**: t tests/test_anthropic_summarize_action.py tests/test_school_message_analyze.py tests/test_github_pr_to_notion_action.py (40 passed) [ ] デプロイ後、Cloud Logging で実際に claude-sonnet-4-6 がリクエストされていることを確認 🤖 Generated with [Claude Code](https://claude.com/claude-code...
- **Source**: PR #150

## 2026-04-28: skip Notion task creation for merged/closed PRs

- **What**: skip Notion task creation for merged/closed PRs
- **Why**: PR #147 で trigger 側の pr_state == "open" フィルタは入っており、cron 発火時点で既に merged/closed の PR は除外されていた。ただし以下のレースは残っていた: ``` T0: ...
- **Source**: PR #149

## 2026-04-20: prevent duplicate Notion tasks and skip merged PRs

- **What**: prevent duplicate Notion tasks and skip merged PRs
- **Why**: ory_prs は per-key の state file (__search_knishioka__ や owner_repo) から dedup 情報を読む しかし継承元 BaseTriggerAdapter.mark_item_processed は self.state_manager (default: github_pr_events_{account}_default_state.json) に書く 読み書きで別ファイルを指していたため dedup が常に空扱いになり、60分の検索窓に残る PR...
- **Source**: PR #147

## 2026-04-16: migrate sync_and_deploy.py from Secret Manager to GCS tokens.json

- **What**: migrate sync_and_deploy.py from Secret Manager to GCS tokens.json
- **Why**: Closes #143 After the Secret Manager → GCS migration (89f7552, 630be37), scripts/sync_and_deploy.py was left pointing at the obsolete Secret Manager API.
- **Source**: PR #144

## 2026-03-18: perf(state): add in-memory TTL cache for GCS state reads

- **What**: perf(state): add in-memory TTL cache for GCS state reads
- **Why**: t mutation of cached data Cache updated on both load and save; optimistic locking still protects writes Expected: ~$20/month → ~$8/month (GCS operations) Closes #141 [x] All 1261 tests pass [x] Coverage 81.93% (above 80% threshold) [x] ruff + mypy pass [x] C...
- **Source**: PR #142

## 2026-03-17: perf(state): reduce GCS API calls for state management

- **What**: perf(state): reduce GCS API calls for state management
- **Why**: completed() in memory, flush once at mark_item_processed() Remove redundant get_completed_actions() GCS read before mark_item_processed() Expected reduction: ~17,000 GCS calls/day → ~8,000 (~$78/month → ~$35/month) Closes #139 [x] All 1261 existing tests pas...
- **Source**: PR #140

## 2026-03-09: add sync_and_deploy.py to ensure Secret Manager + Cloud Run sync

- **What**: add sync_and_deploy.py to ensure Secret Manager + Cloud Run sync
- **Why**: Secret Manager のトークン更新後に Cloud Run リデプロイを忘れると、古いトークンが使われ続ける問題を解決 scripts/sync_and_deploy.py を追加: トークンアップロード + Cloud Run リデプロイを1コマンドで実行 .claude/rules/authentication.md を更新: リデプロイ必須を CRITICAL として明記、パイプラインとチェックリストを改訂 Google Forms の 403 エラーが継続していた原因: 1.
- **Source**: PR #138

## 2026-03-08: add Search API mode for cross-org PR monitoring

- **What**: add Search API mode for cross-org PR monitoring
- **Why**: リリストのメンテナンス不要、新しいリポジトリは自動的に監視対象 _fetch_via_search(): GraphQL search(query: "is:pr author:X updated:>=...") で横断検索 author config を repositories の代替として追加（後方互換性維持） 重複防止: イベントID opened_{pr_id} による状態管理、skip_historical で初回スキップ | モード | API calls/実行 | calls/時間 | |---...
- **Source**: PR #137

## 2026-03-05: detect missing OAuth scopes and force full re-authentication

- **What**: detect missing OAuth scopes and force full re-authentication
- **Why**: gmail_poolsalon_info アカウントで HTTP 403 エラーが24件発生。原因はトークンに spreadsheets.readonly スコープが不足していたこと。
- **Source**: PR #136
