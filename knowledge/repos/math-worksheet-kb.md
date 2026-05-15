# math-worksheet Knowledge Base

## Overview

- Repo: knishioka/math-worksheet
- Description: Math worksheet generator
- Primary language (GitHub): TypeScript
- Category / Priority: education / high
- Status: active
- License: none
- Default branch: main
- Created: 2025-06-09
- Updated: 2026-05-12
- Collected: 2026-05-15

## Tech Stack

- Runtime dependencies: pdfmake, react, react-dom, react-to-print, zustand
- Dev dependencies: @eslint/js, @playwright/test, @testing-library/jest-dom, @testing-library/react, @testing-library/user-event, @types/node, @types/pdfmake, @types/react, @types/react-dom, @vitejs/plugin-react, @vitest/ui, autoprefixer, eslint, eslint-config-prettier, eslint-plugin-react-hooks, eslint-plugin-react-refresh, gh-pages, globals
- npm scripts: build, check:layout, check:layout:local, deploy, dev, format, format:check, lint, preview, test, test:coverage, test:ui, typecheck, verify:playwright:dev, verify:playwright:preview, verify:singapore
- pyproject.toml: not found
- requirements.txt: not found
- README signal: # 計算プリント自動作成サービス > 小学校算数のカリキュラムに沿った計算プリントを、ブラウザだけで生成・印刷できるReactアプリです。 [![TypeScript](https://img.shields.io/badge/TypeScript-5.9+-blue.svg)](https://www.typescriptlang.org/)...

## Architecture / Patterns

- Browser/app code uses package-managed TypeScript/JavaScript workflow with explicit build/test scripts.
- Learning-content rendering balances pedagogy, layout density, and printable output constraints.
- Worksheet/problem generation is configuration-driven, with preview/verification loops used to catch A4 overflow.

## Competitive Landscape (source: 2026-05-15 web research)

- Singapore MOE updated its AI-in-education page on 2026-05-11: SLS now frames AI around responsible use, Learning Assistant guided questions, and Adaptive Learning System personalized paths for Primary 5-Secondary 2 Mathematics. Feature candidate: add adaptive “next worksheet” recommendations based on selected grade/topic and past mistakes. (source: MOE AI in Education, 2026-05-11)
- Current worksheet-generator competitors emphasize AI-generated unique practice, answer keys, real-time feedback, and adaptive difficulty. Feature candidate: mistake-driven regeneration plus auto-generated answer/explanation sheets. (source: web_search, 2026-05-15)
- Singapore Math competitors highlight bar-model drawing, hints, and step-by-step solutions. Feature candidate: optional bar-model scaffold/hint mode for word problems, separate from printable answer lines. (source: web_search, 2026-05-15)

## Tech Decisions (from recent PRs/commits)

- [2026-05-12] feat(word-en): raise grade 4-6 difficulty for English word problems -- ## Summary 4年生以上の English Word Problems (`word-en`) のレベルが、数値計算面でも英文構造面でも低すぎたため、Grade 4-6 全体を引き上げ。 -... (source: PR #69)
- [2026-05-12] feat: add equation line option for word problems -- ## 概要 文章題で立式の練習ができるように、文章題系パターンだけに「式を書く欄」トグルを追加しました。トグルON時は日本語文章題・英語文章題・Singapore Math の各問題で、答え欄の前に式欄を表示します。 Closes #67 ## 変更内容 - `WorksheetSettings` に `showEquationLine`... (source: PR #68)
- [2026-05-10] [codex] Improve answer line spacing -- ## Summary - Increase the writable area for Japanese word-problem answer lines. - Move the answer line lower for first-grade symbol/counting problems so it uses the blank space... (source: PR #66)
- [2026-05-05] fix(number-tracing): match reference handwriting strokes -- ## Summary Refines the preschool number tracing digits 7, 8, and 9 to better match the supplied handwriting reference. The new shapes focus on the actual pencil path rather than... (source: PR #65)
- [2026-05-04] fix(number-tracing): refine handwritten digit strokes -- ## Summary Refines the preschool number tracing digit paths so the examples behave more like pencil handwriting centerlines instead of print-like vector shapes. ## Related Issue... (source: PR #64)
- [2026-04-25] feat(tracing): 各数字に2行目の練習マスを追加し余白を活用 -- ## Summary 数字なぞり書きプリントで A4 下部に大きな余白が残っていたため、各数字に **2行目の練習マス（4マス）** を追加して、ページ全体を有効活用しつつ練習量を倍増させました。 ## Before / After | | 1問あたりのセル | 練習マス | 余白 | |---|---|---|---| | Before |... (source: PR #63)
- [2026-04-25] fix(tracing): ラベルなしのセルでもボックス位置を揃える -- ## Summary 数字なぞり書きプリントで、各行の最初のセル（おてほん/なぞる/かいてみよう のラベル付き）と、それ以降のラベルなしセルで、ボックスの **上端位置がずれていた** 問題を修正。 ## 原因 `Cell` コンポーネント（`NumberTracingRow.tsx`）でラベルを `{label && (...)}`... (source: PR #62)
- [2026-04-25] fix(tracing): 数字7の左の棒を下向きに修正 -- ## Summary 教科書体の数字7では、左の短い縦棒は上の横棒から **下へ** 伸ばすのが正しい形（serif）。これまでは横棒の **上** に飛び出していたため修正。 ## Before / After | | path | 説明 | |---|---|---| | Before | `M 22 14 L 22 26` | 横棒(y=26)の... (source: PR #61)
