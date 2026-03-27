# simple-bookkeeping Design Decisions

## 2026-01-10: refactor: simplify auth context and extract common supabase validation

- **What**: refactor: simplify auth context and extract common supabase validation
- **Why**: ## Summary - Simplify `fetchUserData` in auth-context.tsx by removing redundant types and double filtering - Extract `assertNotLegacyKey` to shared `validation.ts` module (removes duplication from client.ts and server.ts) - Consolidate cook 
- **Source**: PR #585

## 2025-11-24: feat: EmptyStateコンポーネントの実装とUI改善 (#481)

- **What**: feat: EmptyStateコンポーネントの実装とUI改善 (#481)
- **Why**: データがない時の画面表示を改善し、ユーザーが次に何をすべきか分かりやすくしました。視覚的に魅力的で行動を促すEmptyStateコンポーネントを実装し、5つのダッシュボードページに統合しました。 
- **Source**: PR #573

## 2025-11-24: fix(deps): update dev dependencies for security fixes (#531)

- **What**: fix(deps): update dev dependencies for security fixes (#531)
- **Why**: Fixed security vulnerabilities by updating 8 development dependencies to their latest minor versions. All updates are non-breaking and maintain compatibility with the existing codebase. 
- **Source**: PR #569

## 2025-11-12: Migrate from Prisma ORM to Supabase Client

- **What**: Migrate from Prisma ORM to Supabase Client
- **Why**: Successfully completed the migration from Prisma ORM to Supabase Client for all database operations. The codebase now uses Supabase Client exclusively, ensuring consistent RLS (Row Level Security) application and simplified architecture. 
- **Source**: PR #564

## 2025-11-11: Strengthen password requirements and add strength indicator

- **What**: Strengthen password requirements and add strength indicator
- **Why**: Implement enhanced password security based on OWASP 2025 guidelines: 
- **Source**: PR #563

## 2025-11-11: Resolve Issue #555

- **What**: Resolve Issue #555
- **Why**: ### Security Headers Enhancement (Issue #555) - Add `interest-cohort=()` to Permissions-Policy to block Google's FLoC tracking - Improves privacy protection in line with modern web standards 
- **Source**: PR #562
