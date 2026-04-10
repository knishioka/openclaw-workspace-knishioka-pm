# simple-bookkeeping Design Decisions

## 2026-01-10: refactor: simplify auth context and extract common supabase validation

- **What**: refactor: simplify auth context and extract common supabase validation
- **Why**: ## Summary - Simplify `fetchUserData` in auth-context.tsx by removing redundant types and double filtering - Extract `assertNotLegacyKey` to shared `validation.ts` module (removes duplication from client.ts and server.ts) - Consolidate cookie logging in auth.t…
- **Source**: PR #585

## 2025-11-24: feat: EmptyStateコンポーネントの実装とUI改善 (#481)

- **What**: feat: EmptyStateコンポーネントの実装とUI改善 (#481)
- **Why**: ## 概要 データがない時の画面表示を改善し、ユーザーが次に何をすべきか分かりやすくしました。視覚的に魅力的で行動を促すEmptyStateコンポーネントを実装し、5つのダッシュボードページに統合しました。 Closes #481 ## 変更内容 ### 主な変更 - ✅ 再利用可能なEmptyStateコンポーネントの新規作成 - ✅ ダッシュボードページへの統合 - ✅ 仕訳一覧ページへの統合 - ✅ 試算表ページへの統合 - ✅ 貸借対照表ページへの統合 - ✅ 損益計算書ページへの統合 ### 技術的詳細…
- **Source**: PR #573

## 2025-11-24: fix(deps): update dev dependencies for security fixes (#531)

- **What**: fix(deps): update dev dependencies for security fixes (#531)
- **Why**: ## Summary Fixed security vulnerabilities by updating 8 development dependencies to their latest minor versions. All updates are non-breaking and maintain compatibility with the existing codebase. ### Key Security Fix - **Playwright**: v1.55.1 already includes…
- **Source**: PR #569

## 2025-11-12: Migrate from Prisma ORM to Supabase Client

- **What**: Migrate from Prisma ORM to Supabase Client
- **Why**: ## Summary Successfully completed the migration from Prisma ORM to Supabase Client for all database operations. The codebase now uses Supabase Client exclusively, ensuring consistent RLS (Row Level Security) application and simplified architecture. ## Changes…
- **Source**: PR #564

## 2025-11-11: Strengthen password requirements and add strength indicator

- **What**: Strengthen password requirements and add strength indicator
- **Why**: Implement enhanced password security based on OWASP 2025 guidelines: **Password Requirements:** - Minimum 12 characters (increased from 8) - At least one uppercase letter - At least one lowercase letter - At least one number - At least one special character **…
- **Source**: PR #563

## 2025-11-11: Resolve Issue #555

- **What**: Resolve Issue #555
- **Why**: …tation ## Changes ### Security Headers Enhancement (Issue #555) - Add `interest-cohort=()` to Permissions-Policy to block Google's FLoC tracking - Improves privacy protection in line with modern web standards ### Documentation - Add comprehensive security hea…
- **Source**: PR #562
