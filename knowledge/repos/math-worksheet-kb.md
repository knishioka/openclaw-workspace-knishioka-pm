# math-worksheet Knowledge Base

## Overview

- Repo: knishioka/math-worksheet
- Primary language (GitHub): TypeScript
- Category / Priority: education / high
- License: none
- Default branch: main
- Created: 2025-06-09
- Updated: 2026-04-10
- Collected: 2026-04-10

## Tech Stack

- package.json: present
- Dependencies (sample): pdfmake, react, react-dom, react-to-print, zustand
- Dev dependencies (sample): @eslint/js, @playwright/test, @testing-library/jest-dom, @testing-library/react, @testing-library/user-event, @types/node, @types/pdfmake, @types/react, @types/react-dom, @vitejs/plugin-react, @vitest/ui, autoprefixer
- npm scripts (keys): build, check:layout, check:layout:local, deploy, dev, format, format:check, lint, preview, test, test:coverage, test:ui
- pyproject.toml: not found
- requirements.txt: not found
- README signal: # 計算プリント自動作成サービス > 小学校算数のカリキュラムに沿った計算プリントを、ブラウザだけで生成・印刷できるReactアプリです。 [![TypeScript](https://img.shields.io/badge/TypeScript-5.9+-blue.svg)](https://www.typescriptlang.org/) [![React](https://img.shields.io/badge/React-1…

## Architecture / Patterns

- React-based printable worksheet generator
- Generator catalog split by grade / pattern family
- Verification-heavy pipeline: runtime assertions, tests, Playwright layout checks

## Competitive Landscape (notes)

- [2026-04-10] EdTech trend: adaptive math practice is increasingly organized around **skill-gap targeting** rather than static worksheet batches. That suggests value in reusing this repo's generator catalog for “next worksheet from mistakes” flows, not only one-off printing. (refs: https://www.discoveryeducation.com/blog/teaching-and-learning/adaptive-learning-supports-foundational-math-and-reading/ , https://www.mathbrix.com/blog/adaptive-learning-platforms-math/)
- [2026-04-10] Pedagogy trend: spaced / interleaved retrieval is being emphasized for durable math retention. Printable products can differentiate by generating **cumulative mixed review pages** instead of only topic-isolated sheets. (refs: https://www.mathematicshub.edu.au/plan-teach-and-assess/teaching/teaching-strategies/spaced-interleaved-and-retrieval-practice/ , https://www.carnegielearning.com/blog/retrieval-practice-guide-download)

Potential feature candidates for this repo:
- Add a **mistake-driven regeneration mode** that reissues similar-but-not-identical problems for weak skills.
- Add **spiral review worksheet presets** that intentionally mix prior topics across grades / units.

## Tech Decisions (from PRs/commits)

- [2026-04-10] fix: Bar Model diagram overflow and Grade 4-6 number ranges (source: commit 5bd8d57)
- [2026-03-30] feat: Add Singapore Math problems for Grade 4-6 (Primary 4-6) -- ## Summary - Add 10 new Singapore Math problem patterns covering Grade 4-6 (Primary 4-6) curriculum - Grade 4: fraction-of-a-set, decimal word problems - Grade 5: ratio, percentage, speed/distance/time, volume - Grade 6: algebra, advanced r… (source: PR #53)
- [2026-03-29] feat: Add automated verification layer for math problem generators -- ## Summary - Add runtime assertions (`assertValidAnswer`, `assertNoDuplicateNames`, `assertNonEmptyText`) that catch bugs at generation time - Add 110 property-based tests generating 200+ samples per generator/grade — verifying name uniquen… (source: PR #52)
- [2026-03-29] fix: 1年生+1/+2たし算の2列レイアウトで列ごとに問題が重複するバグを修正 -- ## Summary - `generateAddPlusN`で問題数がプール（0〜9の10通り）を超えた場合、同じシャッフル順で巡回するため2列目が1列目の丸コピーになっていたバグを修正 - プール使い切り時に再シャッフルすることで、列ごとの構造的重複を防止 - 同じパターンを持つ`generateAddTo10`も併せて修正 ## Changes - `src/lib/generators/patterns/grade1.ts`: プール巡回時の再シャッフルロジック追加… (source: PR #51)
- [2026-03-28] feat: add Singapore Math word problem patterns -- ## 概要 - Singapore Mathの問題タイプ4種をGrade 1-6に追加 ## 変更内容 - `.gitignore` - `artifacts/` と `eng.traineddata` を除外対象に追加 - `scripts/verify-singapore-playwright.mjs` - Grade 1-3 のSingaporeパターンをPlaywrightで自動検証し、解答ON/OFFスクリーンショットを取得する検証スクリプトを追加 - `src/c… (source: PR #47)
- [2026-03-22] feat: 1年生向け入門計算パターン5種を追加 -- ## Summary - 小さい子向けのより簡単な計算問題パターン5種を1年生に追加 - **+1のたし算** / **+2のたし算**: 固定値を足すシンプルな計算 - **かずをかぞえよう**: ○や★などのシンボルを数える問題 - **○をつかったたし算**: 2グループのシンボルを合わせる - **○をつかったひき算**: シンボルから取り除いた残りを答える - シンボルは20px・5個ごとに改行で視認性を確保 - `PATTERN_COUNT_OVERRIDES`で… (source: PR #46)
- [2026-03-07] chore: PR #38マージ後のlocalStorageクリーンアップ -- ## Summary - Add `localStorage.removeItem('math-worksheet-settings')` to the mount `useEffect` in `App.tsx` to clean up legacy persisted data from pre-URL-state migration (PR #38) - Note: The duplicate `getOperationFromPattern` function men… (source: PR #45)
