# math-worksheet Knowledge Base

## Overview

- Repo: knishioka/math-worksheet
- Primary language (GitHub): TypeScript
- License: none
- Default branch: main
- Created: 2025-06-09
- Updated: 2026-06-11
- Collected: 2026-06-12

## Tech Stack

- package.json: present
- Dependencies (sample): pdfmake, react, react-dom, react-to-print, zustand
- Dev dependencies (sample): @eslint/js, @playwright/test, @testing-library/jest-dom, @testing-library/react, @testing-library/user-event, @types/node, @types/pdfmake, @types/react, @types/react-dom, @vitejs/plugin-react, @vitest/ui, autoprefixer
- npm scripts (keys): build, check:layout, check:layout:local, deploy, dev, format, format:check, lint, preview, test, test:coverage, test:ui, typecheck, verify:playwright:dev, verify:playwright:preview
- pyproject.toml: not found
- requirements.txt: not found

## Architecture / Patterns

- React/Next.js UI

## Tech Decisions (from PRs/commits)

- [2026-06-11] feat(grade1): +3〜+9のたし算パターンを追加（答えが10を超えてよい） -- 小学1年生の入門パターンに **+3〜+9のたし算** を追加します（既存の+1/+2と同シリーズ）。あわせて「**足した結果が10を超えてもよい**」ルールを適用します。 (source: PR #74)
- [2026-06-11] feat(print): 実測ベースのA4オーバーフローガードを追加 -- PDFのA4はみ出しが繰り返し再発する問題（直近では4年生word-en）への根本対策の第1弾です。 (source: PR #73)
- [2026-05-04] fix(number-tracing): refine handwritten digit strokes -- ## Summary Refines the preschool number tracing digit paths so the examples behave more like pencil handwriting centerlines instead of print-like vector shapes. (source: PR #64)
- [2026-04-25] feat(tracing): 各数字に2行目の練習マスを追加し余白を活用 -- 数字なぞり書きプリントで A4 下部に大きな余白が残っていたため、各数字に **2行目の練習マス（4マス）** を追加して、ページ全体を有効活用しつつ練習量を倍増させました。 (source: PR #63)
- [2026-04-25] fix(tracing): ラベルなしのセルでもボックス位置を揃える -- 数字なぞり書きプリントで、各行の最初のセル（おてほん/なぞる/かいてみよう のラベル付き）と、それ以降のラベルなしセルで、ボックスの **上端位置がずれていた** 問題を修正。 (source: PR #62)
- [2026-04-25] fix(tracing): 数字7の左の棒を下向きに修正 -- 教科書体の数字7では、左の短い縦棒は上の横棒から **下へ** 伸ばすのが正しい形（serif）。これまでは横棒の **上** に飛び出していたため修正。 (source: PR #61)
