# jgrants-app Design Decisions

## 2026-06-08: fix(schedule): タイムゾーン安全な日付ヘルパー（off-by-one 修正）

- **What**: fix(schedule): タイムゾーン安全な日付ヘルパー（off-by-one 修正）
- **Why**: `lib/schedule/utils.ts` の日付ヘルパーが、UTC より西のタイムゾーンで**カレンダー日が1日ずれる**バグを修正します。
- **Source**: PR #118

## 2026-06-07: fix(security): npm audit 脆弱性解消（critical×1 + high×5 含む 15件）

- **What**: fix(security): npm audit 脆弱性解消（critical×1 + high×5 含む 15件）
- **Why**: `npm audit fix`（`--force` なし／**非破壊的修正のみ**）で脆弱性を解消しました。すべて既存の `package.json` semver 範囲内で解決できたため、**変更は `package-lock.json` のみ**（直接依存のレンジ変更なし）。
- **Source**: PR #111

## 2026-06-07: feat(ui): improve list loading and error states

- **What**: feat(ui): improve list loading and error states
- **Why**: - Replaced spinner-only loading on favorites and applications list pages with card/grid skeletons. - Kept existing list data visible during refetches with `aria-busy` and reduced opacity to reduce flicker. - Replaced favorites page `alert()
- **Source**: PR #108

## 2026-06-07: refactor(ui): replace native dialogs with toasts

- **What**: refactor(ui): replace native dialogs with toasts
- **Why**: ## Summary - Add a reusable ConfirmDialog with focus trapping, Escape/backdrop close, and destructive action styling - Add a global react-hot-toast provider and replace in-scope native alert/confirm calls with toast notifications and confir
- **Source**: PR #107

## 2026-06-07: fix(ui): add organization creation page

- **What**: fix(ui): add organization creation page
- **Why**: Issue #97 の対応として、`/organizations/new` のデッドリンクを解消し、ログイン後に新しい組織を作成できる導線を追加しました。
- **Source**: PR #106

## 2026-06-07: feat(ui): 登録フォームのリアルタイムバリデーション＋都道府県47件化

- **What**: feat(ui): 登録フォームのリアルタイムバリデーション＋都道府県47件化
- **Why**: ## Summary - add field-level realtime validation for required register fields using zod - show inline red-border error states on change, blur, and submit without duplicate password messaging - expand the prefecture select to all 47 prefectu
- **Source**: PR #105
