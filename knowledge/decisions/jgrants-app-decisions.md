# jgrants-app Design Decisions

Updated: 2026-05-15

## 2026-04-15: feat(ai): Anthropic prompt caching for Claude routes (#94)

- **What**: Closes #94 ## Summary - Mark system prompts with `cache_control: { type: 'ephemeral' }` in `generate-section` (streaming + non-streaming), `generate-schedule`, and...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #96

## 2025-11-23: enhance: Implement password reset with Resend (#89)

- **What**: ## 概要 OWASP準拠のパスワードリセット機能を実装しました。ユーザーがパスワードを忘れた際に、Resendによるメール送信でセルフリカバリーできる機能を提供し、サポート負荷を削減します。 Closes #89 ## 変更内容 ### フロントエンド #### 新規作成 - `app/(auth)/reset-password/page.tsx`...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #90

## 2025-11-07: test: Add E2E and integration tests for Claude API

- **What**: ## 概要 Issue #87 の対応として、Claude API を活用した補助金申請機能（スケジュール生成・書類生成）の E2E テストおよび統合テストを実装しました。 Closes #87 ## 実装内容 ### 🎭 Playwright E2E テスト **テストフレームワークのセットアップ:** - Playwright 1.47.0...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #88

## 2025-11-06: test: add comprehensive test coverage for organization management APIs (#72)

- **What**: ## Summary Resolves #72 This PR adds comprehensive test coverage for 4 organization management API endpoints that were previously untested: - ✅ **58 tests** across 4 endpoints...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #86

## 2025-11-06: enhance: Add audit logging for critical operations (#71)

- **What**: ## 概要 重要な操作（削除・更新・権限変更）の監査ログを記録し、コンプライアンス対応とセキュリティインシデント調査を可能にする機能を実装しました。 Closes #71 ## 変更内容 ### データベース - `supabase/migrations/20250206000000_add_audit_logs.sql` -...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #85

## 2025-11-06: fix: Prevent authenticated users from accessing login/register pages (#80)

- **What**: ## 概要 認証済みユーザーが `/login` および `/register` ページにアクセスした際、自動的に `/dashboard` にリダイレクトする機能を追加しました。 Closes #80 ## 変更内容 ### ファイル変更 - `lib/supabase/middleware.ts` (+16行) ### 実装詳細 1....
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #84

## 2025-11-04: Add edge runtime fetch polyfills for Jest

- **What**: ## Summary - add a comprehensive polyfill in `jest.setup.ts` that reuses Next.js edge runtime fetch primitives when the jsdom environment does not expose them - ensure...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #83

## 2025-11-04: test: polyfill fetch APIs for jest

- **What**: ## Summary - reuse Next.js edge runtime primitives to polyfill Request/Response and related web APIs for Jest - add TextEncoder/TextDecoder and stream polyfills so NextRequest...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #82

## 2025-11-04: enhance: Improve invitation email duplicate prevention and add Resend documentation (#78)

- **What**: ## 概要 組織招待システムの重複メール送信防止とResendドキュメントを包括的に実装しました（Issue #78）。 Closes #78 ## 変更内容 ### データベースマイグレーション - **新規カラム追加** (`supabase/migrations/20250204000000_add_email_tracking.sql`) -...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #81

## 2025-11-03: enhance: Implement automated email sending for organization invitations (#69)

- **What**: ## Summary Implements automated email sending when organization owners/admins invite new members, resolving Issue #69. Closes #69 ## Changes ### Core Implementation - ✅ **Resend...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #77
