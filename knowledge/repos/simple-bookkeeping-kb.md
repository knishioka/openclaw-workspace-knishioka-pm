# simple-bookkeeping Knowledge Base

## Overview

- Repo: knishioka/simple-bookkeeping
- Description: 日本の確定申告（青色申告）に対応した複式簿記システム
- Primary language (GitHub): TypeScript
- Category / Priority: fintech / medium
- Status: dormant
- License: none
- Default branch: main
- Created: 2025-06-10
- Updated: 2026-01-10
- Collected: 2026-05-08

## Tech Stack

- package.json: present
- Dependencies (sample): none listed
- Dev dependencies (sample): @eslint/eslintrc, @eslint/js, @types/node, @typescript-eslint/eslint-plugin, @typescript-eslint/parser, depcheck, eslint, eslint-config-prettier, eslint-import-resolver-node, eslint-import-resolver-typescript, eslint-plugin-import, eslint-plugin-jsx-a11y
- npm scripts (keys): audit, audit:fix, audit:high, audit:moderate, build, build:apps, build:benchmark, build:check, build:clean, build:packages, build:validate, build:web, check:all, check:build, check:deps, check:imports, check:types, check:unused, clean, db:init, db:migrate, db:query, db:query:local, db:query:prod, db:seed, db:tables, db:tables:prod, deploy:check, dev, dev:check-ports, docker:down, docker:logs, docker:up, env:validate, env:validate:strict, env:validate:web, format, format:check, health, health:quick, lint, lint:fix, lint:strict, lint:zero-warnings, logs:prod, migrate:users, postinstall, precommit:check, precommit:validate, prepare, prepush:check, security:audit, security:check, security:fix, security:gitleaks, start, supabase:docker, supabase:docker:down, supabase:docker:logs, supabase:start, supabase:status, supabase:stop, test, test:accounting, test:audit, test:coverage, test:e2e, test:e2e:docker, test:e2e:docker:build, test:e2e:docker:clean, test:e2e:docker:debug, test:e2e:docker:watch, test:failing, test:watch, typecheck, validate:all, validate:scripts, validate:workflows, validate:yaml, vercel:api, vercel:deployments, vercel:list, vercel:logs, vercel:logs:prod, vercel:status
- pyproject.toml: not found
- requirements.txt: not found
- README signal: # Simple Bookkeeping - 日本の確定申告対応複式簿記システム ## 概要 Simple Bookkeepingは、日本の確定申告（青色申告）に対応した複式簿記システムです。個人事業主や小規模事業者が簡単に帳簿管理と確定申告書類の作成ができることを目的としています。 ## システムアーキテクチャ ```mermaid graph TB %% UI層 subgraph "Client (Browser)" Browser["🌐 ユーザーブラウザ<br/>React Components"] end %% アプリケーション層 subgrap

## Architecture / Patterns

- Domain-model-heavy app around financial records, ledgers, or reporting flows
- Validation and transformation boundaries between raw inputs and accounting views
- Workflow emphasis on correctness, auditability, and repeatable exports/reports

## Competitive Landscape (notes)

No competitive research captured yet.

Potential feature candidates for this repo:
- No candidates captured yet.

## Tech Decisions (from PRs/commits)

- [2026-01-10] refactor: simplify auth context and extract common supabase validation -- s duplication from client.ts and server.ts) Consolidate cookie logging in auth.ts to structured format Refactor logger.ts to use function declarations per project conventions Removed redundant UserOrgWithRelations interface Removed unnecessary `crypto.random... (source: PR #585)
- [2025-11-24] feat: EmptyStateコンポーネントの実装とUI改善 (#481) -- データがない時の画面表示を改善し、ユーザーが次に何をすべきか分かりやすくしました。視覚的に魅力的で行動を促すEmptyStateコンポーネントを実装し、5つのダッシュボードページに統合しました。 (source: PR #573)
- [2025-11-24] fix(deps): update dev dependencies for security fixes (#531) -- Fixed security vulnerabilities by updating 8 development dependencies to their latest minor versions. (source: PR #569)
- [2025-11-12] Migrate from Prisma ORM to Supabase Client -- Successfully completed the migration from Prisma ORM to Supabase Client for all database operations. (source: PR #564)
- [2025-11-11] Strengthen password requirements and add strength indicator -- mber At least one special character **Changes:** Update signup validation to enforce new password requirements Update server-side auth actions (signUp and updatePassword) with validatePassword() Add real-time password strength meter component with visual fee... (source: PR #563)
- [2025-11-11] Resolve Issue #555 -- e with modern web standards Add comprehensive security headers section to docs/ai-guide/security-deployment.md Document all 7 security headers currently implemented: Content-Security-Policy (CSP) X-Frame-Options X-Content-Type-Options X-XSS-Protection Referr... (source: PR #562)
- [2025-11-11] Fix authentication bypass vulnerability in test mode -- …st mode protection Fix critical authentication bypass vulnerability (Issue #554) by removing user-controllable mockAuth cookie and implementing multi-layer production detection. (source: PR #561)
- [2025-11-11] Fix Issue 553 -- …ns (#553) Eliminated Service Role Key usage from middleware.ts and moved organization lookup logic to dedicated Server Action, reducing the attack surface and following the principle of least privilege. (source: PR #560)
