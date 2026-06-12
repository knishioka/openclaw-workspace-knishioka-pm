# jgrants-app Knowledge Base

## Overview

- Repo: knishioka/jgrants-app
- Description: jGrants APIを活用した補助金申請支援アプリケーション
- Primary language (GitHub): TypeScript
- License: none
- Default branch: main
- Created: 2025-10-26
- Updated: 2026-06-08
- Collected: 2026-06-12

## Tech Stack

- package.json: present
- Dependencies (sample): @anthropic-ai/sdk, @radix-ui/react-checkbox, @radix-ui/react-dialog, @radix-ui/react-label, @radix-ui/react-select, @react-email/render, @supabase/ssr, @supabase/supabase-js, @types/diff-match-patch, class-variance-authority, clsx, date-fns
- Dev dependencies (sample): @peculiar/webcrypto, @playwright/test, @testing-library/jest-dom, @testing-library/react, @testing-library/user-event, @types/dompurify, @types/jest, @types/jszip, @types/node, @types/react, @types/react-dom, @types/uuid
- npm scripts (keys): build, dev, lint, prepare, start, test, test:all, test:api, test:api:prod, test:coverage, test:e2e, test:e2e:debug, test:e2e:headed, test:e2e:ui, test:integration
- pyproject.toml: not found
- requirements.txt: not found

## Architecture / Patterns

- Runtime schema validation
- React/Next.js UI
- CLI-style usage

## Tech Decisions (from PRs/commits)

- [2026-06-08] fix(schedule): タイムゾーン安全な日付ヘルパー（off-by-one 修正） -- `lib/schedule/utils.ts` の日付ヘルパーが、UTC より西のタイムゾーンで**カレンダー日が1日ずれる**バグを修正します。 (source: PR #118)
- [2026-06-07] fix(security): npm audit 脆弱性解消（critical×1 + high×5 含む 15件） -- `npm audit fix`（`--force` なし／**非破壊的修正のみ**）で脆弱性を解消しました。すべて既存の `package.json` semver 範囲内で解決できたため、**変更は `package-lock.json` のみ**（直接依存のレンジ変更なし）。 (source: PR #111)
- [2026-06-07] feat(ui): improve list loading and error states -- - Replaced spinner-only loading on favorites and applications list pages with card/grid skeletons. - Kept existing list data visible during refetches with `aria-busy` and reduced opacity to reduce flicker. - Replaced favorites page `alert() (source: PR #108)
- [2026-06-07] refactor(ui): replace native dialogs with toasts -- ## Summary - Add a reusable ConfirmDialog with focus trapping, Escape/backdrop close, and destructive action styling - Add a global react-hot-toast provider and replace in-scope native alert/confirm calls with toast notifications and confir (source: PR #107)
- [2026-06-07] fix(ui): add organization creation page -- Issue #97 の対応として、`/organizations/new` のデッドリンクを解消し、ログイン後に新しい組織を作成できる導線を追加しました。 (source: PR #106)
- [2026-06-07] feat(ui): 登録フォームのリアルタイムバリデーション＋都道府県47件化 -- ## Summary - add field-level realtime validation for required register fields using zod - show inline red-border error states on change, blur, and submit without duplicate password messaging - expand the prefecture select to all 47 prefectu (source: PR #105)
