# workflow-engine Knowledge Base

## Overview

- Repo: knishioka/workflow-engine
- Description: Convert Zapier workflows to Claude Code, Agent SDK, or API implementations
- Primary language (GitHub): Python
- License: MIT
- Default branch: master
- Created: 2025-10-19
- Updated: 2026-05-12
- Collected: 2026-05-29

## Tech Stack

- package.json: not found (or not accessible via GitHub contents API)
- pyproject.toml: present
- requirements.txt: present

## Architecture / Patterns

- (No clear patterns inferred from README/dependencies in this snapshot)

## Tech Decisions (from PRs/commits)

- [2026-05-11] feat(actions): bundle multi-item LINE notifications via batch mode -- ファミリーカレンダーで一度に多数の予定変更が起きた際、現状はイベントごとに個別の LINE push が走り、`max_per_execution=10` の rate limiter で10件目以降が失敗する（2026-05-11 06:00 UTC で実際に発生）。 (source: PR #152)
- [2026-05-02] feat(notion): auto-close Notion tasks when their GitHub PR is merged -- ## Summary - Adds new trigger `notion_pr_tasks` and action `notion_close_task_if_pr_merged` that periodically scan the Notion `tasks` DB for incomplete tasks with GitHub PR URLs and mark them Done once the PR is merged/closed. - Cleans up t (source: PR #151)
- [2026-04-28] fix(github_pr_to_notion): skip Notion task creation for merged/closed PRs -- - Trigger fetch から action 実行までの間に PR が merge/close されると、古い `open` スナップショットで Notion task が作られてしまう問題を修正 - `GitHubPRToNotionAction` に optional config `github_account` を追加。設定時は LLM 解析前に `GET /repos/{owner}/{repo}/pulls/{number}` で PR 最新状態を再 fet (source: PR #149)
- [2026-04-20] fix(github_pr_events): prevent duplicate Notion tasks and skip merged PRs -- ## Summary - `GitHub PR → Notion` ワークフローで同じ PR から Notion タスクが2個作られる問題と、cron 起動時に既に merged/closed の PR でもタスクが作られる問題を修正 - 新規テスト4件追加 (全1265件 pass) (source: PR #147)
- [2026-04-16] fix(scripts): migrate sync_and_deploy.py from Secret Manager to GCS tokens.json -- After the Secret Manager → GCS migration (89f7552, 630be37), `scripts/sync_and_deploy.py` was left pointing at the obsolete Secret Manager API. Re-running it would update Secret Manager versions while Cloud Run kept reading the unchanged GC (source: PR #144)
- [2026-03-18] perf(state): add in-memory TTL cache for GCS state reads -- - Add module-level state cache with 45s TTL to eliminate redundant GCS reads on warm Cloud Run instances - 90%+ of executions (no new items) now hit cache instead of GCS - Returns deep copies to prevent mutation of cached data - Cache updat (source: PR #142)
