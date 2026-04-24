# english-note-maker Design Decisions

## 2026-04-16: feat: add phonics word-family practice mode

- **What**: feat: add phonics word-family practice mode
- **Why**: Closes #22
- **Source**: PR #23

## 2026-04-11: fix(cloze): increase questions per page and hide notice from print

- **What**: fix(cloze): increase questions per page and hide notice from print
- **Why**: - 穴埋め問題の1ページあたりの問題数を増加（上限4→10、練習行を2行→1行に削減、CSS gapを縮小） - `getClozeCapacity()` の計算を正確なレイアウト高さに基づくように修正 - 自動調整通知（`.auto-layout-notice`）が印刷時に表示されてA4からはみ出す問題を修正
- **Source**: PR #21

## 2026-04-11: feat(cloze): add fill-in-the-blank phrase practice mode

- **What**: feat(cloze): add fill-in-the-blank phrase practice mode
- **Why**: - Add new "穴埋めフレーズ練習" (cloze/fill-in-the-blank) practice mode with sight words and phonics support - Support two blank granularities: word-level (replace sight words) and character-level (phonics-targeted letter blanking) - Include answer key with show/hide to…
- **Source**: PR #20

## 2025-11-12: Allow printing up to 20 pages

- **What**: Allow printing up to 20 pages
- **Why**: - Update page count max from 5 to 20 in index.html - Update README.md to reflect new page limit 🤖 Generated with
- **Source**: PR #18

## 2025-11-12: Add more math problem types

- **What**: Add more math problem types
- **Why**: No summary captured.
- **Source**: PR #17

## 2025-11-11: Set up Claude Code Web development

- **What**: Set up Claude Code Web development
- **Why**: - Add SessionStart hook for automatic dependency installation - Configure npm install with PUPPETEER_SKIP_DOWNLOAD for remote env - Install Playwright browsers for e2e testing - Only run hook in remote environment (Claude Code on the Web) - Add .claude/setting…
- **Source**: PR #16

## 2025-11-05: fix: keep phrase practice print within a4

- **What**: fix: keep phrase practice print within a4
- **Why**: No summary captured.
- **Source**: PR #15

## 2025-11-05: fix: auto-adjust layouts to fit a4 output

- **What**: fix: auto-adjust layouts to fit a4 output
- **Why**: 背景 - 既存の警告表示だけでは実際のPDF出力でA4外にはみ出すケースが解消されず、利用者が都度ページ数や項目数を手動調整する必要があった - レイアウト診断で検出した問題をフロー内で即座に解消し、印刷プレビューの段階で安定したA4収まりを保証する仕組みが求められていた - HTML の構造不備がCIでのみ検知される状態だったため、ローカル段階で同じ品質チェックを実施できるよう整備したい
- **Source**: PR #14
