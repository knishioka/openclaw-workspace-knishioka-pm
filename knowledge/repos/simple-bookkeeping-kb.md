# simple-bookkeeping Knowledge Base

## Overview

- Repo: knishioka/simple-bookkeeping
- Description: 日本の確定申告（青色申告）に対応した複式簿記システム
- Primary language (GitHub): TypeScript
- Category / Priority: fintech / medium
- License: none
- Default branch: main
- Created: 2025-06-10
- Updated: 2026-01-10
- Collected: 2026-04-10

## Tech Stack

- package.json: present
- Dependencies (sample): not found
- Dev dependencies (sample): @eslint/eslintrc, @eslint/js, @types/node, @typescript-eslint/eslint-plugin, @typescript-eslint/parser, depcheck, eslint, eslint-config-prettier, eslint-import-resolver-node, eslint-import-resolver-typescript, eslint-plugin-import, eslint-plugin-jsx-a11y
- npm scripts (keys): audit, audit:fix, audit:high, audit:moderate, build, build:apps, build:benchmark, build:check, build:clean, build:packages, build:validate, build:web
- pyproject.toml: not found
- requirements.txt: not found
- README signal: # Simple Bookkeeping - 日本の確定申告対応複式簿記システム ## 概要 Simple Bookkeepingは、日本の確定申告（青色申告）に対応した複式簿記システムです。個人事業主や小規模事業者が簡単に帳簿管理と確定申告書類の作成ができることを目的としています。 ## システムアーキテクチャ ```mermaid graph TB %% UI層 subgraph "Client (Browser)" Browser…

## Architecture / Patterns

- Fintech web application for bookkeeping workflows
- App/backend structure evolving toward Supabase-based integrations
- Product features around accounting UX and auth/security

## Competitive Landscape (notes)

- No dedicated competitive / trend note recorded this week.

## Tech Decisions (from PRs/commits)

- [2026-01-10] refactor: simplify auth context and extract common supabase validation -- ## Summary - Simplify `fetchUserData` in auth-context.tsx by removing redundant types and double filtering - Extract `assertNotLegacyKey` to shared `validation.ts` module (removes duplication from client.ts and server.ts) - Consolidate cook… (source: PR #585)
- [2025-11-24] feat: EmptyStateコンポーネントの実装とUI改善 (#481) -- ## 概要 データがない時の画面表示を改善し、ユーザーが次に何をすべきか分かりやすくしました。視覚的に魅力的で行動を促すEmptyStateコンポーネントを実装し、5つのダッシュボードページに統合しました。 Closes #481 ## 変更内容 ### 主な変更 - ✅ 再利用可能なEmptyStateコンポーネントの新規作成 - ✅ ダッシュボードページへの統合 - ✅ 仕訳一覧ページへの統合 - ✅ 試算表ページへの統合 - ✅ 貸借対照表ページへの統合 - ✅ 損益計… (source: PR #573)
- [2025-11-24] fix(deps): update dev dependencies for security fixes (#531) -- ## Summary Fixed security vulnerabilities by updating 8 development dependencies to their latest minor versions. All updates are non-breaking and maintain compatibility with the existing codebase. ### Key Security Fix - **Playwright**: v1.5… (source: PR #569)
- [2025-11-12] Migrate from Prisma ORM to Supabase Client -- ## Summary Successfully completed the migration from Prisma ORM to Supabase Client for all database operations. The codebase now uses Supabase Client exclusively, ensuring consistent RLS (Row Level Security) application and simplified archi… (source: PR #564)
- [2025-11-11] Strengthen password requirements and add strength indicator -- Implement enhanced password security based on OWASP 2025 guidelines: **Password Requirements:** - Minimum 12 characters (increased from 8) - At least one uppercase letter - At least one lowercase letter - At least one number - At least one… (source: PR #563)
- [2025-11-11] Resolve Issue #555 -- …tation ## Changes ### Security Headers Enhancement (Issue #555) - Add `interest-cohort=()` to Permissions-Policy to block Google's FLoC tracking - Improves privacy protection in line with modern web standards ### Documentation - Add compre… (source: PR #562)
