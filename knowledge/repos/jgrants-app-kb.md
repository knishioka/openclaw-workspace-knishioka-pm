# jgrants-app Knowledge Base

## Overview

- Repo: knishioka/jgrants-app
- Description: jGrants APIを活用した補助金申請支援アプリケーション
- Primary language (GitHub): TypeScript
- License: none
- Default branch: main
- Created: 2025-10-26
- Updated: 2026-04-15
- Collected: 2026-05-29

## Tech Stack

- package.json: present
- Dependencies (sample): @anthropic-ai/sdk, @react-email/render, @supabase/ssr, @supabase/supabase-js, @types/diff-match-patch, clsx, date-fns, diff-match-patch, dompurify, file-type, isomorphic-dompurify, jszip
- Dev dependencies (sample): @peculiar/webcrypto, @playwright/test, @testing-library/jest-dom, @testing-library/react, @testing-library/user-event, @types/dompurify, @types/jest, @types/jszip, @types/node, @types/react, @types/react-dom, @types/uuid
- npm scripts (keys): build, dev, lint, prepare, start, test, test:all, test:api, test:api:prod, test:coverage, test:e2e, test:e2e:debug, test:e2e:headed, test:e2e:ui, test:integration
- pyproject.toml: not found
- requirements.txt: not found

## Architecture / Patterns

- Runtime schema validation
- React/Next.js UI
- CLI-style usage

## Tech Decisions (from PRs/commits)

- [2026-04-15] feat(ai): Anthropic prompt caching for Claude routes (#94) -- ## Summary - Mark system prompts with `cache_control: { type: 'ephemeral' }` in `generate-section` (streaming + non-streaming), `generate-schedule`, and `ClaudeClient` so repeated calls against the same subsidy context can reuse the cached  (source: PR #96)
- [2025-11-23] enhance: Implement password reset with Resend (#89) -- OWASP準拠のパスワードリセット機能を実装しました。ユーザーがパスワードを忘れた際に、Resendによるメール送信でセルフリカバリーできる機能を提供し、サポート負荷を削減します。 (source: PR #90)
- [2025-11-07] test: Add E2E and integration tests for Claude API -- Issue #87 の対応として、Claude API を活用した補助金申請機能（スケジュール生成・書類生成）の E2E テストおよび統合テストを実装しました。 (source: PR #88)
- [2025-11-06] test: add comprehensive test coverage for organization management APIs (#72) -- This PR adds comprehensive test coverage for 4 organization management API endpoints that were previously untested: (source: PR #86)
- [2025-11-06] enhance: Add audit logging for critical operations (#71) -- 重要な操作（削除・更新・権限変更）の監査ログを記録し、コンプライアンス対応とセキュリティインシデント調査を可能にする機能を実装しました。 (source: PR #85)
- [2025-11-06] fix: Prevent authenticated users from accessing login/register pages (#80) -- 認証済みユーザーが `/login` および `/register` ページにアクセスした際、自動的に `/dashboard` にリダイレクトする機能を追加しました。 (source: PR #84)
