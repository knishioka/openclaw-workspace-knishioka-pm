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
- Updated: 2026-04-17
- Collected: 2026-04-17

## Tech Stack

- package.json: not found (or not accessible via GitHub contents API)
- Dependencies (sample): not found
- Dev dependencies (sample): not found
- npm scripts (keys): not found
- pyproject.toml: present
- requirements.txt: present
- README signal: # workflow-engine [![Codecov](https://codecov.io/gh/knishioka/workflow-engine/branch/master/graph/badge.svg)](https://codecov.io/gh/knishioka/workflow-engine) **Workflow Engine - Run your automations with full control** ZapierワークフローをCloud Functions + Cloud Sc…

## Architecture / Patterns

- Python application with repo-specific automation around its core domain
- Workflow translation/orchestration layer between no-code automation and agent/API execution

## Competitive Landscape (notes)

No fresh competitive research in this run.

## Tech Decisions (from PRs/commits)

- [2026-04-16] fix(scripts): migrate sync_and_deploy.py from Secret Manager to GCS tokens.json -- Closes #143 ## Summary After the Secret Manager → GCS migration (89f7552, 630be37), `scripts/sync_and_deploy.py` was left pointing at the obsolete Secret Manager API. Re-running it would update Secret Manager versions while Cloud Run kept reading the unchange… (source: PR #144)
- [2026-03-18] perf(state): add in-memory TTL cache for GCS state reads -- ## Summary - Add module-level state cache with 45s TTL to eliminate redundant GCS reads on warm Cloud Run instances - 90%+ of executions (no new items) now hit cache instead of GCS - Returns deep copies to prevent mutation of cached data - Cache updated on bo… (source: PR #142)
- [2026-03-17] perf(state): reduce GCS API calls for state management -- ## Summary - Remove redundant `blob.exists()` calls in GCS load/save operations (3→2 and 2→1 API calls) - Cache migration status on warm Cloud Run instances to skip repeated GCS reads on init - Batch `mark_action_completed()` in memory, flush once at `mark_it… (source: PR #140)
- [2026-03-09] feat: add sync_and_deploy.py to ensure Secret Manager + Cloud Run sync -- ## Summary - Secret Manager のトークン更新後に Cloud Run リデプロイを忘れると、古いトークンが使われ続ける問題を解決 - `scripts/sync_and_deploy.py` を追加: トークンアップロード + Cloud Run リデプロイを1コマンドで実行 - `.claude/rules/authentication.md` を更新: リデプロイ必須を CRITICAL として明記、パイプラインとチェックリストを改訂 ## Background Google For… (source: PR #138)
- [2026-03-08] feat(github_pr): add Search API mode for cross-org PR monitoring -- ## Summary - GitHub PR→Notion タスク作成ワークフローを、リポジトリ個別ポーリングから **GraphQL Search API** に変更 - `author` パラメータ指定で全アクセス可能リポジトリのPRを **1回のAPIコール** で取得 - 3つのワークフロー（personal/D-stats/datainformed-jp）を1つに統合可能に - リポジトリリストのメンテナンス不要、新しいリポジトリは自動的に監視対象 ### 変更点 - `_fetch_via_searc… (source: PR #137)
- [2026-03-05] fix(auth): detect missing OAuth scopes and force full re-authentication -- ## 背景 `gmail_poolsalon_info` アカウントで HTTP 403 エラーが24件発生。原因はトークンに `spreadsheets.readonly` スコープが不足していたこと。 ## 問題の根本原因 `authenticate_gmail_multi.py` は既存トークンが期限切れの場合に `creds.refresh()` でリフレッシュするが、**refresh_token は元の OAuth フローで付与されたスコープ内でしか更新できない**。新しいスコープが `SCOPES`… (source: PR #136)
- [2026-01-17] fix(memory): prevent GCS/Firestore client memory leak in Cloud Run (#133) -- ## Summary Fixes critical memory leak in Cloud Run causing OOM crashes after ~12 hours of operation. **Root Cause:** Each `StateManager` and `FirestoreLock` instance created new GCS/Firestore clients, causing unbounded memory growth over time. **Solution:** I… (source: PR #134)
- [2026-01-09] fix(error_tracker): add file locking to prevent JSON corruption -- ## Summary - Add two-level locking (thread lock + file lock) to ErrorTracker to prevent JSON corruption during concurrent access - Add `fcntl` file locking (`LOCK_EX` for writes, `LOCK_SH` for reads) following StateManager pattern - Add `threading.Lock` for t… (source: PR #132)
