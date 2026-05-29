# math-worksheet Knowledge Base

## Overview

- Repo: knishioka/math-worksheet
- Primary language (GitHub): TypeScript
- License: none
- Default branch: main
- Created: 2025-06-09
- Updated: 2026-05-27
- Collected: 2026-05-29

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

- [2026-05-27] feat(word-en): align English word problems with elementary curriculum -- - English Word Problems の各学年に、その学年で実際に習う計算（2桁×1桁、分数加減、小数演算、速さ、百分率など）を確実に含めるよう改修 - 学年に対して簡単すぎる/難しすぎるテンプレートを `minGrade`/`maxGrade` で再配分 - 答えが分数・小数・あまりになるケースを `number | string` でレンダラ変更なしに表示 (source: PR #72)
- [2026-05-23] feat: add partial product rows for advanced hissan -- ## 概要 - 4年生向け `hissan-mult-advanced` で部分積を2段に分けて練習できるようにしました - 問題面では部分積の記入欄、解答面では桁を揃えた部分積の数値を表示します - 関連説明と回帰テストを追加しました (source: PR #71)
- [2026-05-12] feat(word-en): raise grade 4-6 difficulty for English word problems -- 4年生以上の English Word Problems (`word-en`) のレベルが、数値計算面でも英文構造面でも低すぎたため、Grade 4-6 全体を引き上げ。 (source: PR #69)
- [2026-05-12] feat: add equation line option for word problems -- 文章題で立式の練習ができるように、文章題系パターンだけに「式を書く欄」トグルを追加しました。トグルON時は日本語文章題・英語文章題・Singapore Math の各問題で、答え欄の前に式欄を表示します。 (source: PR #68)
- [2026-05-10] [codex] Improve answer line spacing -- - Increase the writable area for Japanese word-problem answer lines. - Move the answer line lower for first-grade symbol/counting problems so it uses the blank space below the prompt. - Apply the same minimum answer-line height treatment to (source: PR #66)
- [2026-05-05] fix(number-tracing): match reference handwriting strokes -- ## Summary Refines the preschool number tracing digits 7, 8, and 9 to better match the supplied handwriting reference. The new shapes focus on the actual pencil path rather than clean vector-symbol outlines. (source: PR #65)
