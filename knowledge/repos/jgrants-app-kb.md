# jgrants-app Knowledge Base

## Overview

- Repo: knishioka/jgrants-app
- Description: jGrants APIを活用した補助金申請支援アプリケーション
- Primary language (GitHub): TypeScript
- License: none
- Default branch: main
- Created: 2025-10-26
- Updated: 2026-04-15
- Collected: 2026-05-22

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

- [2025-11-03] enhance: Standardize error handling and response format (#66) -- APIエンドポイント全体で統一されたエラーハンドリングとレスポンス形式を実装しました。これにより、エラー発生時の原因特定が容易になり、ユーザー体験と開発者体験の両方が向上します。 (source: PR #74)
- [2025-11-02] enhance: Add tab navigation to application detail page (#64) -- 申請作成後、ユーザーがスケジュール管理や書類編集機能に迷わずアクセスできるよう、申請詳細ページにタブナビゲーションと編集リンクを追加しました。 (source: PR #65)
- [2025-11-02] enhance: Add application creation flow from subsidy pages (#58) -- Implement comprehensive user flow from subsidy discovery to application creation, addressing the "cannot find where to start application" user pain point identified in Issue #58. (source: PR #63)
- [2025-11-02] enhance: Implement skeleton UI for organization info on subsidies page (#57) -- Implements skeleton UI for the organization information block on the subsidies search page to improve loading UX and prevent layout shift. (source: PR #62)
- [2025-11-02] fix: Fix favorite button not working due to missing subsidy auto-save (#59) -- 補助金検索結果からお気に入りボタンをクリックしても、補助金がお気に入りに追加されない404エラーを修正しました。jGrants APIから取得した補助金情報がローカルDBに保存されていなかったため、お気に入り追加時の外部キー制約チェックで失敗していました。 (source: PR #61)
- [2025-11-01] enhance: Implement skeleton UI for dashboard loading (#56) -- Replaced simple spinner with skeleton UI to improve perceived performance and prevent layout shift (CLS improvement) on the dashboard page. (source: PR #60)
