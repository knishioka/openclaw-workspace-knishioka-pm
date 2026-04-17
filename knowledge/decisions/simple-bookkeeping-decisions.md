# simple-bookkeeping Design Decisions

## 2026-01-10: refactor: simplify auth context and extract common supabase validation

- **What**: refactor: simplify auth context and extract common supabase validation
- **Why**: ## Summary - Simplify `fetchUserData` in auth-context.tsx by removing redundant types and double filtering - Extract `assertNotLegacyKey` to shared `validation.ts` module (removes duplication from client.ts and server.ts) - Consolidate cookie logging in auth.ts to structured format - Refactor logger.ts to use function declarations per project conventions ## Changes ### auth-context.tsx (~22 lines reduced) - Removed …
- **Source**: PR #585

## 2025-11-24: feat: EmptyStateコンポーネントの実装とUI改善 (#481)

- **What**: feat: EmptyStateコンポーネントの実装とUI改善 (#481)
- **Why**: ## 概要 データがない時の画面表示を改善し、ユーザーが次に何をすべきか分かりやすくしました。視覚的に魅力的で行動を促すEmptyStateコンポーネントを実装し、5つのダッシュボードページに統合しました。 Closes #481 ## 変更内容 ### 主な変更 - ✅ 再利用可能なEmptyStateコンポーネントの新規作成 - ✅ ダッシュボードページへの統合 - ✅ 仕訳一覧ページへの統合 - ✅ 試算表ページへの統合 - ✅ 貸借対照表ページへの統合 - ✅ 損益計算書ページへの統合 ### 技術的詳細 **新規コンポーネント: EmptyState** - TypeScript strict typingで実装（`any`型なし） - shadcn/uiデザインパターンに準拠 - Lucide iconsを使用した視覚的表現 - フェードインアニメーション付き - レスポンシブデザイン（モバイルファースト） - ア…
- **Source**: PR #573

## 2025-11-24: fix(deps): update dev dependencies for security fixes (#531)

- **What**: fix(deps): update dev dependencies for security fixes (#531)
- **Why**: ## Summary Fixed security vulnerabilities by updating 8 development dependencies to their latest minor versions. All updates are non-breaking and maintain compatibility with the existing codebase. ### Key Security Fix - **Playwright**: v1.55.1 already includes the fix for CVE-2024-57727 (HIGH severity) - Vulnerability: Command Injection in `launchServer` API - Status: ✅ Resolved (no action needed, version already in…
- **Source**: PR #569

## 2025-11-12: Migrate from Prisma ORM to Supabase Client

- **What**: Migrate from Prisma ORM to Supabase Client
- **Why**: ## Summary Successfully completed the migration from Prisma ORM to Supabase Client for all database operations. The codebase now uses Supabase Client exclusively, ensuring consistent RLS (Row Level Security) application and simplified architecture. ## Changes ### Phase 1: Audit ✅ - Identified all Prisma usage in codebase (found zero actual usage) - Confirmed all database queries already use Supabase Client - Created…
- **Source**: PR #564

## 2025-11-11: Strengthen password requirements and add strength indicator

- **What**: Strengthen password requirements and add strength indicator
- **Why**: Implement enhanced password security based on OWASP 2025 guidelines: **Password Requirements:** - Minimum 12 characters (increased from 8) - At least one uppercase letter - At least one lowercase letter - At least one number - At least one special character **Changes:** - Update signup validation to enforce new password requirements - Update server-side auth actions (signUp and updatePassword) with validatePassword(…
- **Source**: PR #563

## 2025-11-11: Resolve Issue #555

- **What**: Resolve Issue #555
- **Why**: …tation ## Changes ### Security Headers Enhancement (Issue #555) - Add `interest-cohort=()` to Permissions-Policy to block Google's FLoC tracking - Improves privacy protection in line with modern web standards ### Documentation - Add comprehensive security headers section to docs/ai-guide/security-deployment.md - Document all 7 security headers currently implemented: - Content-Security-Policy (CSP) - X-Frame-Options…
- **Source**: PR #562

## 2025-11-11: Fix authentication bypass vulnerability in test mode

- **What**: Fix authentication bypass vulnerability in test mode
- **Why**: …st mode protection ## Summary Fix critical authentication bypass vulnerability (Issue #554) by removing user-controllable mockAuth cookie and implementing multi-layer production detection. ## Security Improvements ### 1. Removed User-Controllable mockAuth Cookie - **REMOVED**: mockAuth cookie that could be set via browser DevTools - **Risk**: Attackers could bypass authentication by setting `document.cookie = "mock…
- **Source**: PR #561

## 2025-11-11: Fix Issue 553

- **What**: Fix Issue 553
- **Why**: …ns (#553) ## Summary Eliminated Service Role Key usage from middleware.ts and moved organization lookup logic to dedicated Server Action, reducing the attack surface and following the principle of least privilege. ## Changes - Created `getDefaultUserOrganization` Server Action in organizations.ts - Updated middleware.ts to call Server Action instead of direct DB query - Removed all Service Role Key imports and usag…
- **Source**: PR #560
