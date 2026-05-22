# simple-bookkeeping Knowledge Base

## Overview

- Repo: knishioka/simple-bookkeeping
- Description: 日本の確定申告（青色申告）に対応した複式簿記システム
- Primary language (GitHub): TypeScript
- License: none
- Default branch: main
- Created: 2025-06-10
- Updated: 2026-01-10
- Collected: 2026-05-22

## Tech Stack

- package.json: present
- Dev dependencies (sample): @eslint/eslintrc, @eslint/js, @types/node, @typescript-eslint/eslint-plugin, @typescript-eslint/parser, depcheck, eslint, eslint-config-prettier, eslint-import-resolver-node, eslint-import-resolver-typescript, eslint-plugin-import, eslint-plugin-jsx-a11y
- npm scripts (keys): audit, audit:fix, audit:high, audit:moderate, build, build:apps, build:benchmark, build:check, build:clean, build:packages, build:validate, build:web, check:all, check:build, check:deps
- pyproject.toml: not found
- requirements.txt: not found

## Architecture / Patterns

- CLI-style usage

## Tech Decisions (from PRs/commits)

- [2025-11-07] fix: create select-organization page and improve login error handling (#541) -- Fixes #541 - Login error when users have no organization (source: PR #542)
- [2025-11-06] fix: use serviceClient for organization creation during signup (#538) -- 新規ユーザー登録時に「組織の作成に失敗しました」エラーが発生する問題を修正しました。 (source: PR #539)
- [2025-11-06] feat: Claude Codeからのデータベース操作機能を追加 -- Claude Codeがローカル/本番Supabaseデータベースに対して安全にクエリを実行できる機能とドキュメントを整備しました。 (source: PR #537)
- [2025-11-03] test: stabilize auth action flow -- ## Summary - update auth server action tests to mock the action client, cookies API, and Next.js redirects so the suite reflects the redirect-driven control flow - adjust sign-in expectations to assert redirects and service interactions ins (source: PR #536)
- [2025-10-12] feat: add strict pre-push review to resolve-gh-issue workflow -- Enhance the `/resolve-gh-issue` workflow with a new Step 7.5 that performs strict code review before pushing, preventing unnecessary files and scope creep in PRs. (source: PR #524)
- [2025-10-11] fix: production login infinite redirect loop (#522) -- ## 🎯 Summary 本番環境でログイン時に発生していた無限リダイレクトループ（ERR_TOO_MANY_REDIRECTS）を修正しました。 (source: PR #523)
