# simple-bookkeeping Knowledge Base

## Overview

- Repo: knishioka/simple-bookkeeping
- Description: 日本の確定申告（青色申告）に対応した複式簿記システム
- Primary language (GitHub): TypeScript
- License: none
- Default branch: main
- Created: 2025-06-10
- Updated: 2026-01-10
- Collected: 2026-03-27

## Tech Stack

- package.json: present
- Dev dependencies (sample): @eslint/eslintrc, @eslint/js, @types/node, @typescript-eslint/eslint-plugin, @typescript-eslint/parser, depcheck, eslint, eslint-config-prettier, eslint-import-resolver-node, eslint-import-resolver-typescript, eslint-plugin-import, eslint-plugin-jsx-a11y
- npm scripts (keys): audit, audit:fix, audit:high, audit:moderate, build, build:apps, build:benchmark, build:check, build:clean, build:packages, build:validate, build:web, check:all, check:build, check:deps
- pyproject.toml: not found
- requirements.txt: not found

## Architecture / Patterns

- CLI-style usage

## Tech Decisions (from PRs/commits)

- [2026-01-10] refactor: simplify auth context and extract common supabase validation -- ## Summary - Simplify `fetchUserData` in auth-context.tsx by removing redundant types and double filtering - Extract `assertNotLegacyKey` to shared `validation.ts` module (removes duplication from client.ts and server.ts) - Consolidate cook (source: PR #585)
- [2025-11-24] feat: EmptyStateコンポーネントの実装とUI改善 (#481) -- データがない時の画面表示を改善し、ユーザーが次に何をすべきか分かりやすくしました。視覚的に魅力的で行動を促すEmptyStateコンポーネントを実装し、5つのダッシュボードページに統合しました。 (source: PR #573)
- [2025-11-24] fix(deps): update dev dependencies for security fixes (#531) -- Fixed security vulnerabilities by updating 8 development dependencies to their latest minor versions. All updates are non-breaking and maintain compatibility with the existing codebase. (source: PR #569)
- [2025-11-12] Migrate from Prisma ORM to Supabase Client -- Successfully completed the migration from Prisma ORM to Supabase Client for all database operations. The codebase now uses Supabase Client exclusively, ensuring consistent RLS (Row Level Security) application and simplified architecture. (source: PR #564)
- [2025-11-11] Strengthen password requirements and add strength indicator -- Implement enhanced password security based on OWASP 2025 guidelines: (source: PR #563)
- [2025-11-11] Resolve Issue #555 -- ### Security Headers Enhancement (Issue #555) - Add `interest-cohort=()` to Permissions-Policy to block Google's FLoC tracking - Improves privacy protection in line with modern web standards (source: PR #562)
