# simple-bookkeeping Design Decisions

## 2026-01-10: simplify auth context and extract common supabase validation

- **What**: simplify auth context and extract common supabase validation
- **Why**: s duplication from client.ts and server.ts) Consolidate cookie logging in auth.ts to structured format Refactor logger.ts to use function declarations per project conventions Removed redundant UserOrgWithRelations interface Removed unnecessary `crypto.random...
- **Source**: PR #585

## 2025-11-24: EmptyStateコンポーネントの実装とUI改善 (#481)

- **What**: EmptyStateコンポーネントの実装とUI改善 (#481)
- **Why**: データがない時の画面表示を改善し、ユーザーが次に何をすべきか分かりやすくしました。視覚的に魅力的で行動を促すEmptyStateコンポーネントを実装し、5つのダッシュボードページに統合しました。
- **Source**: PR #573

## 2025-11-24: update dev dependencies for security fixes (#531)

- **What**: update dev dependencies for security fixes (#531)
- **Why**: Fixed security vulnerabilities by updating 8 development dependencies to their latest minor versions.
- **Source**: PR #569

## 2025-11-12: Migrate from Prisma ORM to Supabase Client

- **What**: Migrate from Prisma ORM to Supabase Client
- **Why**: Successfully completed the migration from Prisma ORM to Supabase Client for all database operations.
- **Source**: PR #564

## 2025-11-11: Strengthen password requirements and add strength indicator

- **What**: Strengthen password requirements and add strength indicator
- **Why**: mber At least one special character **Changes:** Update signup validation to enforce new password requirements Update server-side auth actions (signUp and updatePassword) with validatePassword() Add real-time password strength meter component with visual fee...
- **Source**: PR #563

## 2025-11-11: Resolve Issue #555

- **What**: Resolve Issue #555
- **Why**: e with modern web standards Add comprehensive security headers section to docs/ai-guide/security-deployment.md Document all 7 security headers currently implemented: Content-Security-Policy (CSP) X-Frame-Options X-Content-Type-Options X-XSS-Protection Referr...
- **Source**: PR #562

## 2025-11-11: Fix authentication bypass vulnerability in test mode

- **What**: Fix authentication bypass vulnerability in test mode
- **Why**: …st mode protection Fix critical authentication bypass vulnerability (Issue #554) by removing user-controllable mockAuth cookie and implementing multi-layer production detection.
- **Source**: PR #561

## 2025-11-11: Fix Issue 553

- **What**: Fix Issue 553
- **Why**: …ns (#553) Eliminated Service Role Key usage from middleware.ts and moved organization lookup logic to dedicated Server Action, reducing the attack surface and following the principle of least privilege.
- **Source**: PR #560

## 2025-11-11: Set up Claude Code web development environment

- **What**: Set up Claude Code web development environment
- **Why**: Add automated setup script that runs when starting a Claude Code web session.
- **Source**: PR #559

## 2025-11-11: Remove excessive console logging from authentication flows (#552)

- **What**: Remove excessive console logging from authentication flows (#552)
- **Why**: ✅ Created environment-aware logger utility (apps/web/lib/logger.ts) ✅ Replaced all console.info/console.warn in authentication code with logger ✅ Removed all PII (emails, user IDs) from log statements ✅ Maintained console.error for critical errors ✅ Added logg
- **Source**: PR #558
