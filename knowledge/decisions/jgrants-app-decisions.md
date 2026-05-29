# jgrants-app Design Decisions

## 2026-04-15: feat(ai): Anthropic prompt caching for Claude routes (#94)

- **What**: feat(ai): Anthropic prompt caching for Claude routes (#94)
- **Why**: ## Summary - Mark system prompts with `cache_control: { type: 'ephemeral' }` in `generate-section` (streaming + non-streaming), `generate-schedule`, and `ClaudeClient` so repeated calls against the same subsidy context can reuse the cached  
- **Source**: PR #96

## 2025-11-23: enhance: Implement password reset with Resend (#89)

- **What**: enhance: Implement password reset with Resend (#89)
- **Why**: OWASP準拠のパスワードリセット機能を実装しました。ユーザーがパスワードを忘れた際に、Resendによるメール送信でセルフリカバリーできる機能を提供し、サポート負荷を削減します。 
- **Source**: PR #90

## 2025-11-07: test: Add E2E and integration tests for Claude API

- **What**: test: Add E2E and integration tests for Claude API
- **Why**: Issue #87 の対応として、Claude API を活用した補助金申請機能（スケジュール生成・書類生成）の E2E テストおよび統合テストを実装しました。 
- **Source**: PR #88

## 2025-11-06: test: add comprehensive test coverage for organization management APIs (#72)

- **What**: test: add comprehensive test coverage for organization management APIs (#72)
- **Why**: This PR adds comprehensive test coverage for 4 organization management API endpoints that were previously untested: 
- **Source**: PR #86

## 2025-11-06: enhance: Add audit logging for critical operations (#71)

- **What**: enhance: Add audit logging for critical operations (#71)
- **Why**: 重要な操作（削除・更新・権限変更）の監査ログを記録し、コンプライアンス対応とセキュリティインシデント調査を可能にする機能を実装しました。 
- **Source**: PR #85

## 2025-11-06: fix: Prevent authenticated users from accessing login/register pages (#80)

- **What**: fix: Prevent authenticated users from accessing login/register pages (#80)
- **Why**: 認証済みユーザーが `/login` および `/register` ページにアクセスした際、自動的に `/dashboard` にリダイレクトする機能を追加しました。 
- **Source**: PR #84
