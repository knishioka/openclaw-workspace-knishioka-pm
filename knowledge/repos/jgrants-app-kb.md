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
- Collected: 2026-05-08

## Tech Stack

- package.json: present
- Dependencies (sample): @anthropic-ai/sdk, @react-email/render, @supabase/ssr, @supabase/supabase-js, @types/diff-match-patch, clsx, date-fns, diff-match-patch, dompurify, file-type, isomorphic-dompurify, jszip
- Dev dependencies (sample): @peculiar/webcrypto, @playwright/test, @testing-library/jest-dom, @testing-library/react, @testing-library/user-event, @types/dompurify, @types/jest, @types/jszip, @types/node, @types/react, @types/react-dom, @types/uuid
- npm scripts (keys): build, dev, lint, prepare, start, test, test:all, test:api, test:api:prod, test:coverage, test:e2e, test:e2e:debug, test:e2e:headed, test:e2e:ui, test:integration, test:watch, type-check, validate:schema
- pyproject.toml: not found
- requirements.txt: not found
- README signal: # jGrants補助金申請支援アプリ 税理士や企業が補助金の検索から申請書類の作成までを一貫してサポートするアプリケーションです。 ## 主要機能 - **補助金検索**: jGrants APIから補助金を検索・フィルタリング - **詳細表示**: 補助金の詳細情報を確認 - **申請管理**: 申請状況の管理（開発中） - **書類生成**: Claude APIで申請書類のたたき台を生成（開発中） ## 技術スタック - **フロントエンド**: Next.js 15 (App Router), React 19, TypeScript, Ta

## Architecture / Patterns

- TypeScript-based application with repo-specific service boundaries
- Incremental feature delivery through PR-sized vertical slices
- Automation and deployment concerns handled alongside product logic

## Competitive Landscape (notes)

No fresh competitive research in this run.

Potential feature candidates for this repo:
- No candidates captured yet.

## Tech Decisions (from PRs/commits)

- [2026-04-15] feat(ai): Anthropic prompt caching for Claude routes (#94) -- Closes #94 Mark system prompts with cache_control: { type: 'ephemeral' } in generate-section (streaming + non-streaming), generate-schedule, and ClaudeClient so repeated calls against the same subsidy context can reuse the cached prefix. (source: PR #96)
- [2025-11-23] enhance: Implement password reset with Resend (#89) -- OWASP準拠のパスワードリセット機能を実装しました。ユーザーがパスワードを忘れた際に、Resendによるメール送信でセルフリカバリーできる機能を提供し、サポート負荷を削減します。 (source: PR #90)
- [2025-11-07] test: Add E2E and integration tests for Claude API -- Issue #87 の対応として、Claude API を活用した補助金申請機能（スケジュール生成・書類生成）の E2E テストおよび統合テストを実装しました。 (source: PR #88)
- [2025-11-06] test: add comprehensive test coverage for organization management APIs (#72) -- erage** on 3/4 endpoints (target: 80%) ✅ **Production-ready** with 9.2/10 quality score from code review ✅ All security boundaries tested (auth, authz, permissions) | Endpoint | Tests | Coverage | Lines Covered | |----------|-------|----------|--------------... (source: PR #86)
- [2025-11-06] enhance: Add audit logging for critical operations (#71) -- 重要な操作（削除・更新・権限変更）の監査ログを記録し、コンプライアンス対応とセキュリティインシデント調査を可能にする機能を実装しました。 (source: PR #85)
- [2025-11-06] fix: Prevent authenticated users from accessing login/register pages (#80) -- 認証済みユーザーが /login および /register ページにアクセスした際、自動的に /dashboard にリダイレクトする機能を追加しました。 (source: PR #84)
- [2025-11-04] Add edge runtime fetch polyfills for Jest -- able before loading the edge runtime shims retain the existing global fetch mock while preserving access to the native implementation for tests npm test -- app/api/claude/generate-schedule/__tests__/route.test.ts --runInBand ------ https://chatgpt.com/codex/... (source: PR #83)
- [2025-11-04] test: polyfill fetch APIs for jest -- h that proxies to the edge implementation while preserving existing environment stubs npm test -- --watch=false *(fails: multiple API route suites now execute but fail due to Supabase mocks returning unexpected shapes)* ------ https://chatgpt.com/codex/tasks... (source: PR #82)
