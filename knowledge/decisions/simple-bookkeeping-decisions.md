# simple-bookkeeping Design Decisions

Updated: 2026-05-15

## 2026-01-10: refactor: simplify auth context and extract common supabase validation

- **What**: ## Summary - Simplify `fetchUserData` in auth-context.tsx by removing redundant types and double filtering - Extract `assertNotLegacyKey` to shared `validation.ts` module...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #585

## 2025-11-24: feat: EmptyStateコンポーネントの実装とUI改善 (#481)

- **What**: ## 概要 データがない時の画面表示を改善し、ユーザーが次に何をすべきか分かりやすくしました。視覚的に魅力的で行動を促すEmptyStateコンポーネントを実装し、5つのダッシュボードページに統合しました。 Closes #481 ## 変更内容 ### 主な変更 - ✅ 再利用可能なEmptyStateコンポーネントの新規作成 - ✅...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #573

## 2025-11-24: fix(deps): update dev dependencies for security fixes (#531)

- **What**: ## Summary Fixed security vulnerabilities by updating 8 development dependencies to their latest minor versions. All updates are non-breaking and maintain compatibility with the...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #569

## 2025-11-12: Migrate from Prisma ORM to Supabase Client

- **What**: ## Summary Successfully completed the migration from Prisma ORM to Supabase Client for all database operations. The codebase now uses Supabase Client exclusively, ensuring...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #564

## 2025-11-11: Strengthen password requirements and add strength indicator

- **What**: Implement enhanced password security based on OWASP 2025 guidelines: **Password Requirements:** - Minimum 12 characters (increased from 8) - At least one uppercase letter - At...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #563

## 2025-11-11: Resolve Issue #555

- **What**: …tation ## Changes ### Security Headers Enhancement (Issue #555) - Add `interest-cohort=()` to Permissions-Policy to block Google's FLoC tracking - Improves privacy protection...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #562

## 2025-11-11: Fix authentication bypass vulnerability in test mode

- **What**: …st mode protection ## Summary Fix critical authentication bypass vulnerability (Issue #554) by removing user-controllable mockAuth cookie and implementing multi-layer...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #561

## 2025-11-11: Fix Issue 553

- **What**: …ns (#553) ## Summary Eliminated Service Role Key usage from middleware.ts and moved organization lookup logic to dedicated Server Action, reducing the attack surface and...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #560

## 2025-11-11: Set up Claude Code web development environment

- **What**: Add automated setup script that runs when starting a Claude Code web session. Changes: - Create .claude/hooks/session-start.sh with environment setup - Install pnpm dependencies...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #559

## 2025-11-11: fix(security): Remove excessive console logging from authentication flows (#552)

- **What**: ## Summary This PR addresses Issue #552 - a high-priority security issue that prevents information disclosure through console logs in production environments. ### Changes Made -...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #558
