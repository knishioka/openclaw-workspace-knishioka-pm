# simple-bookkeeping Design Decisions

## 2026-01-10: refactor: simplify auth context and extract common supabase validation

- **What**: refactor: simplify auth context and extract common supabase validation
- **Why**: - Simplify `fetchUserData` in auth-context.tsx by removing redundant types and double filtering - Extract `assertNotLegacyKey` to shared `validation.ts` module (removes duplication from client.ts and server.ts) - Consolidate cookie logging in auth.ts to struct…
- **Source**: PR #585

## 2025-11-24: feat: EmptyStateコンポーネントの実装とUI改善 (#481)

- **What**: feat: EmptyStateコンポーネントの実装とUI改善 (#481)
- **Why**: 概要
- **Source**: PR #573

## 2025-11-24: fix(deps): update dev dependencies for security fixes (#531)

- **What**: fix(deps): update dev dependencies for security fixes (#531)
- **Why**: No summary captured.
- **Source**: PR #569

## 2025-11-12: Migrate from Prisma ORM to Supabase Client

- **What**: Migrate from Prisma ORM to Supabase Client
- **Why**: Successfully completed the migration from Prisma ORM to Supabase Client for all database operations. The codebase now uses Supabase Client exclusively, ensuring consistent RLS (Row Level Security) application and simplified architecture. Changes Phase 1: Audit…
- **Source**: PR #564

## 2025-11-11: Strengthen password requirements and add strength indicator

- **What**: Strengthen password requirements and add strength indicator
- **Why**: Implement enhanced password security based on OWASP 2025 guidelines: **Password Requirements:** - Minimum 12 characters (increased from 8) - At least one uppercase letter - At least one lowercase letter - At least one number - At least one special character **…
- **Source**: PR #563

## 2025-11-11: Resolve Issue #555

- **What**: Resolve Issue #555
- **Why**: …tation Changes Security Headers Enhancement (Issue #555) - Add `interest-cohort=()` to Permissions-Policy to block Google's FLoC tracking - Improves privacy protection in line with modern web standards Documentation - Add comprehensive security headers sectio…
- **Source**: PR #562

## 2025-11-11: Fix authentication bypass vulnerability in test mode

- **What**: Fix authentication bypass vulnerability in test mode
- **Why**: …st mode protection Summary Fix critical authentication bypass vulnerability (Issue #554) by removing user-controllable mockAuth cookie and implementing multi-layer production detection. Security Improvements 1. Removed User-Controllable mockAuth Cookie - **RE…
- **Source**: PR #561

## 2025-11-11: Fix Issue 553

- **What**: Fix Issue 553
- **Why**: …ns (#553) Summary Eliminated Service Role Key usage from middleware.ts and moved organization lookup logic to dedicated Server Action, reducing the attack surface and following the principle of least privilege. Changes - Created `getDefaultUserOrganization` S…
- **Source**: PR #560
