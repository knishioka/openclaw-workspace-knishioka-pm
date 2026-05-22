# workflow-engine Knowledge Base

## Overview

- Repo: knishioka/workflow-engine
- Description: Convert Zapier workflows to Claude Code, Agent SDK, or API implementations
- Primary language (GitHub): Python
- License: MIT
- Default branch: master
- Created: 2025-10-19
- Updated: 2026-05-12
- Collected: 2026-05-22

## Tech Stack

- package.json: not found (or not accessible via GitHub contents API)
- pyproject.toml: present
- requirements.txt: present

## Architecture / Patterns

- (No clear patterns inferred from README/dependencies in this snapshot)

## Tech Decisions (from PRs/commits)

- [2026-03-08] feat(github_pr): add Search API mode for cross-org PR monitoring -- ## Summary - GitHub PR→Notion タスク作成ワークフローを、リポジトリ個別ポーリングから **GraphQL Search API** に変更 - `author` パラメータ指定で全アクセス可能リポジトリのPRを **1回のAPIコール** で取得 - 3つのワークフロー（personal/D-stats/datainformed-jp）を1つに統合可能に - リポジトリリストのメンテナンス不要、新しいリポジトリは自動的に監視対象 (source: PR #137)
- [2026-03-05] fix(auth): detect missing OAuth scopes and force full re-authentication -- `gmail_poolsalon_info` アカウントで HTTP 403 エラーが24件発生。原因はトークンに `spreadsheets.readonly` スコープが不足していたこと。 (source: PR #136)
- [2026-01-17] fix(memory): prevent GCS/Firestore client memory leak in Cloud Run (#133) -- Fixes critical memory leak in Cloud Run causing OOM crashes after ~12 hours of operation. (source: PR #134)
- [2026-01-09] fix(error_tracker): add file locking to prevent JSON corruption -- ## Summary - Add two-level locking (thread lock + file lock) to ErrorTracker to prevent JSON corruption during concurrent access - Add `fcntl` file locking (`LOCK_EX` for writes, `LOCK_SH` for reads) following StateManager pattern - Add `th (source: PR #132)
- [2026-01-09] perf(state-manager): add item count limit to prevent unbounded growth -- Add `max_items` parameter to `cleanup_old_state()` to prevent unbounded growth of `processed_items` in long-running, high-frequency workflows. (source: PR #131)
- [2026-01-09] perf(error-tracker): optimize retention policy to reduce memory usage -- Optimizes ErrorTracker retention policy to address Cloud Run memory limit exceeded errors (1024 MiB → 1040 MiB used). (source: PR #130)
