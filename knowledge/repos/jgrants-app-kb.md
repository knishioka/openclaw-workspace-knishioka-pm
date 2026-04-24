# jgrants-app Knowledge Base

## Overview

- Repo: knishioka/jgrants-app
- Description: jGrants APIを活用した補助金申請支援アプリケーション
- Primary language (GitHub): TypeScript
- Category / Priority: tool / low
- Status: active
- License: none
- Default branch: main
- Created: 2025-10-26
- Updated: 2026-04-15
- Collected: 2026-04-24

## Tech Stack

- package.json: present
- Dependencies (sample): @anthropic-ai/sdk, @react-email/render, @supabase/ssr, @supabase/supabase-js, @types/diff-match-patch, clsx, date-fns, diff-match-patch, dompurify, file-type, isomorphic-dompurify, jszip
- Dev dependencies (sample): @peculiar/webcrypto, @playwright/test, @testing-library/jest-dom, @testing-library/react, @testing-library/user-event, @types/dompurify, @types/jest, @types/jszip, @types/node, @types/react, @types/react-dom, @types/uuid
- npm scripts (keys): build, dev, lint, prepare, start, test, test:all, test:api, test:api:prod, test:coverage, test:e2e, test:e2e:debug
- pyproject.toml: not found
- requirements.txt: not found
- README signal: jGrants補助金申請支援アプリ 税理士や企業が補助金の検索から申請書類の作成までを一貫してサポートするアプリケーションです。 主要機能 - **補助金検索**: jGrants APIから補助金を検索・フィルタリング - **詳細表示**: 補助金の詳細情報を確認 - **申請管理**: 申請状況の管理（開発中） - **書類生成**: Claude APIで申請書類のたたき台を生成（開発中） 技術スタック - **フロントエンド**: Next.js 15 (App Router), React 19, TypeScript, Tailwind CSS - **認証・DB**: Supabase (PostgreSQL + A…

## Architecture / Patterns

- TypeScript application with repo-specific automation around its core domain
- Incremental automation-oriented architecture inferred from recent commits and README

## Competitive Landscape (notes)

No fresh competitive research in this run.

## Tech Decisions (from PRs/commits)

- [2026-04-15] feat(ai): Anthropic prompt caching for Claude routes (#94) -- Closes #94 Summary - Mark system prompts with `cache_control: { type: 'ephemeral' }` in `generate-section` (streaming + non-streaming), `generate-schedule`, and `ClaudeClient` so repeated calls against the same subsidy context can reuse the cached prefix. - Capture `cache_creation_input_tokens` / `cache_read_input_toke… (source: PR #96)
- [2025-11-23] enhance: Implement password reset with Resend (#89) -- 概要 OWASP準拠のパスワードリセット機能を実装しました。ユーザーがパスワードを忘れた際に、Resendによるメール送信でセルフリカバリーできる機能を提供し、サポート負荷を削減します。 Closes #89 変更内容 フロントエンド 新規作成 - `app/(auth)/reset-password/page.tsx` - パスワードリセットリクエスト画面 - メールアドレス入力フォーム - レート制限チェック連携 - アカウント列挙攻撃防止（常に成功メッセージ表示） - 228行 - `app/(auth)/update-password/page.tsx` - パスワード更新画面 - URLハッシュから認証情報取得 - パスワ… (source: PR #90)
- [2025-11-07] test: Add E2E and integration tests for Claude API -- 概要 Issue #87 の対応として、Claude API を活用した補助金申請機能（スケジュール生成・書類生成）の E2E テストおよび統合テストを実装しました。 Closes #87 実装内容 🎭 Playwright E2E テスト **テストフレームワークのセットアップ:** - Playwright 1.47.0 の導入と設定 - TypeScript サポート - CI/CD 対応の設定（GitHub Actions） **認証フロー（`tests/e2e/auth/login.spec.ts`）:** - ✅ 正常なログイン・ログアウト - ✅ 不正な認証情報のエラーハンドリング - ✅ セッション管理の検証 - ✅… (source: PR #88)
- [2025-11-06] test: add comprehensive test coverage for organization management APIs (#72) -- Resolves #72 This PR adds comprehensive test coverage for 4 organization management API endpoints that were previously untested: - ✅ **58 tests** across 4 endpoints (target: 40+) - ✅ **90-97% coverage** on 3/4 endpoints (target: 80%) - ✅ **Production-ready** with 9.2/10 quality score from code review - ✅ All security b… (source: PR #86)
- [2025-11-06] enhance: Add audit logging for critical operations (#71) -- 概要 重要な操作（削除・更新・権限変更）の監査ログを記録し、コンプライアンス対応とセキュリティインシデント調査を可能にする機能を実装しました。 Closes #71 変更内容 データベース - `supabase/migrations/20250206000000_add_audit_logs.sql` - audit_logsテーブル作成 - 組織・ユーザー・操作種別・リソース情報・変更内容を記録 - RLSポリシー設定（管理者のみ閲覧可能、改ざん防止） - 最適化されたインデックス（organization_id, user_id, resource, created_at） バックエンド - `lib/audit/logger… (source: PR #85)
- [2025-11-06] fix: Prevent authenticated users from accessing login/register pages (#80) -- 概要 認証済みユーザーが `/login` および `/register` ページにアクセスした際、自動的に `/dashboard` にリダイレクトする機能を追加しました。 Closes #80 変更内容 ファイル変更 - `lib/supabase/middleware.ts` (+16行) 実装詳細 1. **認証済みユーザーのリダイレクト** - `/login` または `/register` にアクセス時、`/dashboard` へリダイレクト - 既存の未認証ユーザーのリダイレクト（行40-51）の後に実装 2. **セッション保持** - `NextResponse.redirect()` 使用時にSupabase… (source: PR #84)
- [2025-11-04] Add edge runtime fetch polyfills for Jest -- - add a comprehensive polyfill in `jest.setup.ts` that reuses Next.js edge runtime fetch primitives when the jsdom environment does not expose them - ensure TextEncoder/TextDecoder and Web Streams APIs are available before loading the edge runtime shims - retain the existing global fetch mock while preserving access to… (source: PR #83)
- [2025-11-04] test: polyfill fetch APIs for jest -- - reuse Next.js edge runtime primitives to polyfill Request/Response and related web APIs for Jest - add TextEncoder/TextDecoder and stream polyfills so NextRequest can instantiate under jsdom - keep a jest mock fetch that proxies to the edge implementation while preserving existing environment stubs Testing - npm test… (source: PR #82)
