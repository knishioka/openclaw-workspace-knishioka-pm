# jgrants-app Knowledge Base

## Overview

- Repo: knishioka/jgrants-app
- Description: jGrants API subsidy application support
- Primary language (GitHub): TypeScript
- Category / Priority: tool / low
- Status: active
- License: none
- Default branch: main
- Created: 2025-10-26
- Updated: 2026-04-15
- Collected: 2026-05-15

## Tech Stack

- Runtime dependencies: @anthropic-ai/sdk, @react-email/render, @supabase/ssr, @supabase/supabase-js, @types/diff-match-patch, clsx, date-fns, diff-match-patch, dompurify, file-type, isomorphic-dompurify, jszip, lucide-react, next, react, react-dom, react-hot-toast, recharts
- Dev dependencies: @peculiar/webcrypto, @playwright/test, @testing-library/jest-dom, @testing-library/react, @testing-library/user-event, @types/dompurify, @types/jest, @types/jszip, @types/node, @types/react, @types/react-dom, @types/uuid, autoprefixer, dotenv, eslint, eslint-config-next, husky, jest
- npm scripts: build, dev, lint, prepare, start, test, test:all, test:api, test:api:prod, test:coverage, test:e2e, test:e2e:debug, test:e2e:headed, test:e2e:ui, test:integration, test:watch, type-check, validate:schema
- pyproject.toml: not found
- requirements.txt: not found
- README signal: # jGrants補助金申請支援アプリ 税理士や企業が補助金の検索から申請書類の作成までを一貫してサポートするアプリケーションです。 ## 主要機能 - **補助金検索**: jGrants APIから補助金を検索・フィルタリング - **詳細表示**: 補助金の詳細情報を確認 - **申請管理**: 申請状況の管理（開発中） - **書類生成**: Claude APIで申請書類のたたき台を生成（開発中） ## 技術スタック -...

## Architecture / Patterns

- Browser/app code uses package-managed TypeScript/JavaScript workflow with explicit build/test scripts.
- Product value depends on stable ingestion/workflow orchestration and clear operator feedback.

## Competitive Landscape (notes)

No competitive research captured in this weekly rotation.

## Tech Decisions (from recent PRs/commits)

- [2026-04-15] feat(ai): Anthropic prompt caching for Claude routes (#94) -- Closes #94 ## Summary - Mark system prompts with `cache_control: { type: 'ephemeral' }` in `generate-section` (streaming + non-streaming), `generate-schedule`, and... (source: PR #96)
- [2025-11-23] enhance: Implement password reset with Resend (#89) -- ## 概要 OWASP準拠のパスワードリセット機能を実装しました。ユーザーがパスワードを忘れた際に、Resendによるメール送信でセルフリカバリーできる機能を提供し、サポート負荷を削減します。 Closes #89 ## 変更内容 ### フロントエンド #### 新規作成 - `app/(auth)/reset-password/page.tsx`... (source: PR #90)
- [2025-11-07] test: Add E2E and integration tests for Claude API -- ## 概要 Issue #87 の対応として、Claude API を活用した補助金申請機能（スケジュール生成・書類生成）の E2E テストおよび統合テストを実装しました。 Closes #87 ## 実装内容 ### 🎭 Playwright E2E テスト **テストフレームワークのセットアップ:** - Playwright 1.47.0... (source: PR #88)
- [2025-11-06] test: add comprehensive test coverage for organization management APIs (#72) -- ## Summary Resolves #72 This PR adds comprehensive test coverage for 4 organization management API endpoints that were previously untested: - ✅ **58 tests** across 4 endpoints... (source: PR #86)
- [2025-11-06] enhance: Add audit logging for critical operations (#71) -- ## 概要 重要な操作（削除・更新・権限変更）の監査ログを記録し、コンプライアンス対応とセキュリティインシデント調査を可能にする機能を実装しました。 Closes #71 ## 変更内容 ### データベース - `supabase/migrations/20250206000000_add_audit_logs.sql` -... (source: PR #85)
- [2025-11-06] fix: Prevent authenticated users from accessing login/register pages (#80) -- ## 概要 認証済みユーザーが `/login` および `/register` ページにアクセスした際、自動的に `/dashboard` にリダイレクトする機能を追加しました。 Closes #80 ## 変更内容 ### ファイル変更 - `lib/supabase/middleware.ts` (+16行) ### 実装詳細 1.... (source: PR #84)
- [2025-11-04] Add edge runtime fetch polyfills for Jest -- ## Summary - add a comprehensive polyfill in `jest.setup.ts` that reuses Next.js edge runtime fetch primitives when the jsdom environment does not expose them - ensure... (source: PR #83)
- [2025-11-04] test: polyfill fetch APIs for jest -- ## Summary - reuse Next.js edge runtime primitives to polyfill Request/Response and related web APIs for Jest - add TextEncoder/TextDecoder and stream polyfills so NextRequest... (source: PR #82)
