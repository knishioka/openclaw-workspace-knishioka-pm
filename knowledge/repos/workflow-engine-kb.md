# workflow-engine Knowledge Base

## Overview

- Repo: knishioka/workflow-engine
- Description: Convert Zapier workflows to Claude Code, Agent SDK, or API implementations
- Primary language (GitHub): Python
- Category / Priority: tool / medium
- Status: active
- License: MIT
- Default branch: master
- Created: 2025-10-19
- Updated: 2026-05-02
- Collected: 2026-05-08

## Tech Stack

- package.json: not found (or not accessible via GitHub contents API)
- Dependencies (sample): not found
- Dev dependencies (sample): not found
- npm scripts (keys): not found
- pyproject.toml: present
- requirements.txt: present
- README signal: # workflow-engine [![Codecov](https://codecov.io/gh/knishioka/workflow-engine/branch/master/graph/badge.svg)](https://codecov.io/gh/knishioka/workflow-engine) **Workflow Engine - Run your automations with full control** ZapierワークフローをCloud Functions + Cloud Schedulerで自動実行するワークフローエ

## Architecture / Patterns

- Python-based application with repo-specific service boundaries
- Incremental feature delivery through PR-sized vertical slices
- Automation and deployment concerns handled alongside product logic

## Competitive Landscape (notes)

No fresh competitive research in this run.

Potential feature candidates for this repo:
- No candidates captured yet.

## Tech Decisions (from PRs/commits)

- [2026-05-02] feat(notion): auto-close Notion tasks when their GitHub PR is merged -- Adds new trigger notion_pr_tasks and action notion_close_task_if_pr_merged that periodically scan the Notion tasks DB for incomplete tasks with GitHub PR URLs and mark them Done once the PR is merged/closed. (source: PR #151)
- [2026-04-28] chore: upgrade default LLM from Sonnet 4.5 to Sonnet 4.6 -- t tests/test_anthropic_summarize_action.py tests/test_school_message_analyze.py tests/test_github_pr_to_notion_action.py (40 passed) [ ] デプロイ後、Cloud Logging で実際に claude-sonnet-4-6 がリクエストされていることを確認 🤖 Generated with [Claude Code](https://claude.com/claude-code... (source: PR #150)
- [2026-04-28] fix(github_pr_to_notion): skip Notion task creation for merged/closed PRs -- PR #147 で trigger 側の pr_state == "open" フィルタは入っており、cron 発火時点で既に merged/closed の PR は除外されていた。ただし以下のレースは残っていた: ``` T0: ... (source: PR #149)
- [2026-04-20] fix(github_pr_events): prevent duplicate Notion tasks and skip merged PRs -- ory_prs は per-key の state file (__search_knishioka__ や owner_repo) から dedup 情報を読む しかし継承元 BaseTriggerAdapter.mark_item_processed は self.state_manager (default: github_pr_events_{account}_default_state.json) に書く 読み書きで別ファイルを指していたため dedup が常に空扱いになり、60分の検索窓に残る PR... (source: PR #147)
- [2026-04-16] fix(scripts): migrate sync_and_deploy.py from Secret Manager to GCS tokens.json -- Closes #143 After the Secret Manager → GCS migration (89f7552, 630be37), scripts/sync_and_deploy.py was left pointing at the obsolete Secret Manager API. (source: PR #144)
- [2026-03-18] perf(state): add in-memory TTL cache for GCS state reads -- t mutation of cached data Cache updated on both load and save; optimistic locking still protects writes Expected: ~$20/month → ~$8/month (GCS operations) Closes #141 [x] All 1261 tests pass [x] Coverage 81.93% (above 80% threshold) [x] ruff + mypy pass [x] C... (source: PR #142)
- [2026-03-17] perf(state): reduce GCS API calls for state management -- completed() in memory, flush once at mark_item_processed() Remove redundant get_completed_actions() GCS read before mark_item_processed() Expected reduction: ~17,000 GCS calls/day → ~8,000 (~$78/month → ~$35/month) Closes #139 [x] All 1261 existing tests pas... (source: PR #140)
- [2026-03-09] feat: add sync_and_deploy.py to ensure Secret Manager + Cloud Run sync -- Secret Manager のトークン更新後に Cloud Run リデプロイを忘れると、古いトークンが使われ続ける問題を解決 scripts/sync_and_deploy.py を追加: トークンアップロード + Cloud Run リデプロイを1コマンドで実行 .claude/rules/authentication.md を更新: リデプロイ必須を CRITICAL として明記、パイプラインとチェックリストを改訂 Google Forms の 403 エラーが継続していた原因: 1. (source: PR #138)
