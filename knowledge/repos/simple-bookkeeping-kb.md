# simple-bookkeeping Knowledge Base

## Overview

- Repo: knishioka/simple-bookkeeping
- Description: Double-entry bookkeeping for Japanese tax filing (blue return)
- Primary language (GitHub): TypeScript
- Category / Priority: fintech / medium
- Status: dormant
- License: none
- Default branch: main
- Created: 2025-06-10
- Updated: 2026-01-10
- Collected: 2026-05-15

## Tech Stack

- Runtime dependencies: none detected
- Dev dependencies: @eslint/eslintrc, @eslint/js, @types/node, @typescript-eslint/eslint-plugin, @typescript-eslint/parser, depcheck, eslint, eslint-config-prettier, eslint-import-resolver-node, eslint-import-resolver-typescript, eslint-plugin-import, eslint-plugin-jsx-a11y, eslint-plugin-react, eslint-plugin-react-hooks, eslint-plugin-security, husky, lint-staged, prettier
- npm scripts: audit, audit:fix, audit:high, audit:moderate, build, build:apps, build:benchmark, build:check, build:clean, build:packages, build:validate, build:web, check:all, check:build, check:deps, check:imports, check:types, check:unused, clean, db:init
- pyproject.toml: not found
- requirements.txt: not found
- README signal: # Simple Bookkeeping - 日本の確定申告対応複式簿記システム ## 概要 Simple Bookkeepingは、日本の確定申告（青色申告）に対応した複式簿記システムです。個人事業主や小規模事業者が簡単に帳簿管理と確定申告書類の作成ができることを目的としています。 ## システムアーキテクチャ ```mermaid graph TB %% UI層 subgraph "Client (Browser)"...

## Architecture / Patterns

- Browser/app code uses package-managed TypeScript/JavaScript workflow with explicit build/test scripts.
- Financial data workflows need deterministic calculations, auditability, and careful domain terminology.

## Competitive Landscape (notes)

No competitive research captured in this weekly rotation.

## Tech Decisions (from recent PRs/commits)

- [2026-01-10] refactor: simplify auth context and extract common supabase validation -- ## Summary - Simplify `fetchUserData` in auth-context.tsx by removing redundant types and double filtering - Extract `assertNotLegacyKey` to shared `validation.ts` module... (source: PR #585)
- [2025-11-24] feat: EmptyStateコンポーネントの実装とUI改善 (#481) -- ## 概要 データがない時の画面表示を改善し、ユーザーが次に何をすべきか分かりやすくしました。視覚的に魅力的で行動を促すEmptyStateコンポーネントを実装し、5つのダッシュボードページに統合しました。 Closes #481 ## 変更内容 ### 主な変更 - ✅ 再利用可能なEmptyStateコンポーネントの新規作成 - ✅... (source: PR #573)
- [2025-11-24] fix(deps): update dev dependencies for security fixes (#531) -- ## Summary Fixed security vulnerabilities by updating 8 development dependencies to their latest minor versions. All updates are non-breaking and maintain compatibility with the... (source: PR #569)
- [2025-11-12] Migrate from Prisma ORM to Supabase Client -- ## Summary Successfully completed the migration from Prisma ORM to Supabase Client for all database operations. The codebase now uses Supabase Client exclusively, ensuring... (source: PR #564)
- [2025-11-11] Strengthen password requirements and add strength indicator -- Implement enhanced password security based on OWASP 2025 guidelines: **Password Requirements:** - Minimum 12 characters (increased from 8) - At least one uppercase letter - At... (source: PR #563)
- [2025-11-11] Resolve Issue #555 -- …tation ## Changes ### Security Headers Enhancement (Issue #555) - Add `interest-cohort=()` to Permissions-Policy to block Google's FLoC tracking - Improves privacy protection... (source: PR #562)
- [2025-11-11] Fix authentication bypass vulnerability in test mode -- …st mode protection ## Summary Fix critical authentication bypass vulnerability (Issue #554) by removing user-controllable mockAuth cookie and implementing multi-layer... (source: PR #561)
- [2025-11-11] Fix Issue 553 -- …ns (#553) ## Summary Eliminated Service Role Key usage from middleware.ts and moved organization lookup logic to dedicated Server Action, reducing the attack surface and... (source: PR #560)
