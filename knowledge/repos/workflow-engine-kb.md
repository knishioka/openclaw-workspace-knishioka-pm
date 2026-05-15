# workflow-engine Knowledge Base

## Overview

- Repo: knishioka/workflow-engine
- Description: Convert Zapier workflows to Claude Code/Agent SDK/API
- Primary language (GitHub): Python
- Category / Priority: tool / medium
- Status: active
- License: MIT
- Default branch: master
- Created: 2025-10-19
- Updated: 2026-05-12
- Collected: 2026-05-15

## Tech Stack

- Runtime dependencies: none detected
- pyproject.toml: present
- requirements.txt: present
- README signal: # workflow-engine [![Codecov](https://codecov.io/gh/knishioka/workflow-engine/branch/master/graph/badge.svg)](https://codecov.io/gh/knishioka/workflow-engine) **Workflow Engine - Run your automations with full...

## Architecture / Patterns

- Product value depends on stable ingestion/workflow orchestration and clear operator feedback.

## Competitive Landscape (notes)

No competitive research captured in this weekly rotation.

## Tech Decisions (from recent PRs/commits)

- [2026-05-12] fix(notion): bump HTTPClient timeout to 30s to avoid ReadTimeoutError -- ## Summary - Increase the Notion HTTPClient timeout from 10s → 30s in `service_manager.get_notion_client()` - The Notion query API exceeds 10s when scanning the Tasks DB with a... (source: PR #153)
- [2026-05-11] feat(actions): bundle multi-item LINE notifications via batch mode -- ## Background ファミリーカレンダーで一度に多数の予定変更が起きた際、現状はイベントごとに個別の LINE push が走り、`max_per_execution=10` の rate limiter で10件目以降が失敗する（2026-05-11 06:00 UTC で実際に発生）。 ## Summary - ワークフロー設定に... (source: PR #152)
- [2026-05-02] feat(notion): auto-close Notion tasks when their GitHub PR is merged -- ## Summary - Adds new trigger `notion_pr_tasks` and action `notion_close_task_if_pr_merged` that periodically scan the Notion `tasks` DB for incomplete tasks with GitHub PR URLs... (source: PR #151)
- [2026-04-28] chore: upgrade default LLM from Sonnet 4.5 to Sonnet 4.6 -- ## Summary - `claude-sonnet-4-5-20250929` → `claude-sonnet-4-6` - 同価格帯で品質向上、API 互換性あり - 影響箇所: workflows.yaml の 2 ワークフロー (`github_pr_to_notion`, `school_message_analyze`)、3... (source: PR #150)
- [2026-04-28] fix(github_pr_to_notion): skip Notion task creation for merged/closed PRs -- ## Summary - Trigger fetch から action 実行までの間に PR が merge/close されると、古い `open` スナップショットで Notion task が作られてしまう問題を修正 - `GitHubPRToNotionAction` に optional config `github_account`... (source: PR #149)
- [2026-04-20] fix(github_pr_events): prevent duplicate Notion tasks and skip merged PRs -- ## Summary - `GitHub PR → Notion` ワークフローで同じ PR から Notion タスクが2個作られる問題と、cron 起動時に既に merged/closed の PR でもタスクが作られる問題を修正 - 新規テスト4件追加 (全1265件 pass) ## Bug 1: 重複タスク（state file... (source: PR #147)
- [2026-04-16] fix(scripts): migrate sync_and_deploy.py from Secret Manager to GCS tokens.json -- Closes #143 ## Summary After the Secret Manager → GCS migration (89f7552, 630be37), `scripts/sync_and_deploy.py` was left pointing at the obsolete Secret Manager API. Re-running... (source: PR #144)
- [2026-03-18] perf(state): add in-memory TTL cache for GCS state reads -- ## Summary - Add module-level state cache with 45s TTL to eliminate redundant GCS reads on warm Cloud Run instances - 90%+ of executions (no new items) now hit cache instead of... (source: PR #142)
