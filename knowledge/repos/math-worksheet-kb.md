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
- Updated: 2026-05-05
- Collected: 2026-05-08

## Tech Stack

- package.json: present
- Dependencies (sample): pdfmake, react, react-dom, react-to-print, zustand
- Dev dependencies (sample): @eslint/js, @playwright/test, @testing-library/jest-dom, @testing-library/react, @testing-library/user-event, @types/node, @types/pdfmake, @types/react, @types/react-dom, @vitejs/plugin-react, @vitest/ui, autoprefixer
- npm scripts (keys): build, check:layout, check:layout:local, deploy, dev, format, format:check, lint, preview, test, test:coverage, test:ui, typecheck, verify:playwright:dev, verify:playwright:preview, verify:singapore
- pyproject.toml: not found
- requirements.txt: not found
- README signal: # 計算プリント自動作成サービス > 小学校算数のカリキュラムに沿った計算プリントを、ブラウザだけで生成・印刷できるReactアプリです。 [![TypeScript](https://img.shields.io/badge/TypeScript-5.9+-blue.svg)](https://www.typescriptlang.org/) [![React](https://img.shields.io/badge/React-19.0+-61dafb.svg)](https://react.dev/) [![Vite](https://img.s

## Architecture / Patterns

- Preset/config-driven content generation with browser preview before export
- Learning-content rendering that balances pedagogy, layout density, and accessibility
- Typed frontend/tooling workflow with npm-based build/test scripts

## Competitive Landscape (notes)

No competitive research captured yet.

Potential feature candidates for this repo:
- Add a **URL-shareable preset library** so teachers can bookmark/share specific worksheet configurations.
- Add a **mistake-driven regeneration mode** that reissues similar-but-not-identical problems for weak skills.
- Add **spiral review worksheet presets** that intentionally mix prior topics across grades / units.

## Tech Decisions (from PRs/commits)

- [2026-05-05] fix(number-tracing): match reference handwriting strokes -- Refines the preschool number tracing digits 7, 8, and 9 to better match the supplied handwriting reference. (source: PR #65)
- [2026-05-04] fix(number-tracing): refine handwritten digit strokes -- Refines the preschool number tracing digit paths so the examples behave more like pencil handwriting centerlines instead of print-like vector shapes. (source: PR #64)
- [2026-04-25] feat(tracing): 各数字に2行目の練習マスを追加し余白を活用 -- 数字なぞり書きプリントで A4 下部に大きな余白が残っていたため、各数字に **2行目の練習マス（4マス）** を追加して、ページ全体を有効活用しつつ練習量を倍増させました。 (source: PR #63)
- [2026-04-25] fix(tracing): ラベルなしのセルでもボックス位置を揃える -- 数字なぞり書きプリントで、各行の最初のセル（おてほん/なぞる/かいてみよう のラベル付き）と、それ以降のラベルなしセルで、ボックスの **上端位置がずれていた** 問題を修正。 (source: PR #62)
- [2026-04-25] fix(tracing): 数字7の左の棒を下向きに修正 -- 教科書体の数字7では、左の短い縦棒は上の横棒から **下へ** 伸ばすのが正しい形（serif）。これまでは横棒の **上** に飛び出していたため修正。 (source: PR #61)
- [2026-04-25] feat(tracing): 0〜4/5〜9の左右2分割レイアウトと教科書体準拠の数字に刷新 -- | 変更内容 | | -------- | -------- | | src/components/Preview/ProblemList.tsx | NumberTracingGrid を追加し、number-tracing をトップレベルで特殊扱い。旧 ProblemItem 内分岐を削除 | | src/lib/data/digit-strokes.ts | 全10字の SVG パスを再設計。0,1,2,3,6,8 = 1画 / 5,7,9 = 2画 / 4 = 3画 | | `src/component... (source: PR #60)
- [2026-04-16] fix(fraction): 分数パターンがbasicテンプレにフォールバックしてA4から溢れる問題を修正 -- \fix/hissan-mult-advanced-layout\ (#58) で3桁×2桁のかけ算を修正した流れで、全問題パターンを Playwright で俯瞰監査したところ、**5つの分数パターンが A4 から 312px も溢れる**ことが判明。原因は \getEffectiveProblemType\ が分数パターンを検知できず \basic\ テンプレート（30問上限）にフォールバックしていたこと。 (source: PR #59)
- [2026-04-16] fix(hissan): 3桁×2桁のかけ算が2枚に分かれる問題と横線の幅を修正 -- 4年生「3桁×2桁のかけ算の筆算」で報告された2つの問題を修正： 1. (source: PR #58)
