# jgrants-app Design Decisions

## 2026-04-15: Anthropic prompt caching for Claude routes (#94)

- **What**: Anthropic prompt caching for Claude routes (#94)
- **Why**: Closes #94 Mark system prompts with cache_control: { type: 'ephemeral' } in generate-section (streaming + non-streaming), generate-schedule, and ClaudeClient so repeated calls against the same subsidy context can reuse the cached prefix.
- **Source**: PR #96

## 2025-11-23: enhance: Implement password reset with Resend (#89)

- **What**: enhance: Implement password reset with Resend (#89)
- **Why**: OWASP準拠のパスワードリセット機能を実装しました。ユーザーがパスワードを忘れた際に、Resendによるメール送信でセルフリカバリーできる機能を提供し、サポート負荷を削減します。
- **Source**: PR #90

## 2025-11-07: Add E2E and integration tests for Claude API

- **What**: Add E2E and integration tests for Claude API
- **Why**: Issue #87 の対応として、Claude API を活用した補助金申請機能（スケジュール生成・書類生成）の E2E テストおよび統合テストを実装しました。
- **Source**: PR #88

## 2025-11-06: add comprehensive test coverage for organization management APIs (#72)

- **What**: add comprehensive test coverage for organization management APIs (#72)
- **Why**: erage** on 3/4 endpoints (target: 80%) ✅ **Production-ready** with 9.2/10 quality score from code review ✅ All security boundaries tested (auth, authz, permissions) | Endpoint | Tests | Coverage | Lines Covered | |----------|-------|----------|--------------...
- **Source**: PR #86

## 2025-11-06: enhance: Add audit logging for critical operations (#71)

- **What**: enhance: Add audit logging for critical operations (#71)
- **Why**: 重要な操作（削除・更新・権限変更）の監査ログを記録し、コンプライアンス対応とセキュリティインシデント調査を可能にする機能を実装しました。
- **Source**: PR #85

## 2025-11-06: Prevent authenticated users from accessing login/register pages (#80)

- **What**: Prevent authenticated users from accessing login/register pages (#80)
- **Why**: 認証済みユーザーが /login および /register ページにアクセスした際、自動的に /dashboard にリダイレクトする機能を追加しました。
- **Source**: PR #84

## 2025-11-04: Add edge runtime fetch polyfills for Jest

- **What**: Add edge runtime fetch polyfills for Jest
- **Why**: able before loading the edge runtime shims retain the existing global fetch mock while preserving access to the native implementation for tests npm test -- app/api/claude/generate-schedule/__tests__/route.test.ts --runInBand ------ https://chatgpt.com/codex/...
- **Source**: PR #83

## 2025-11-04: polyfill fetch APIs for jest

- **What**: polyfill fetch APIs for jest
- **Why**: h that proxies to the edge implementation while preserving existing environment stubs npm test -- --watch=false *(fails: multiple API route suites now execute but fail due to Supabase mocks returning unexpected shapes)* ------ https://chatgpt.com/codex/tasks...
- **Source**: PR #82

## 2025-11-04: enhance: Improve invitation email duplicate prevention and add Resend documentation (#78)

- **What**: enhance: Improve invitation email duplicate prevention and add Resend documentation (#78)
- **Why**: 組織招待システムの重複メール送信防止とResendドキュメントを包括的に実装しました（Issue #78）。
- **Source**: PR #81

## 2025-11-03: enhance: Implement automated email sending for organization invitations (#69)

- **What**: enhance: Implement automated email sending for organization invitations (#69)
- **Why**: Implements automated email sending when organization owners/admins invite new members, resolving Issue #69.
- **Source**: PR #77
