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
- Updated: 2026-04-16
- Collected: 2026-04-17

## Tech Stack

- package.json: present
- Dependencies (sample): pdfmake, react, react-dom, react-to-print, zustand
- Dev dependencies (sample): @eslint/js, @playwright/test, @testing-library/jest-dom, @testing-library/react, @testing-library/user-event, @types/node, @types/pdfmake, @types/react, @types/react-dom, @vitejs/plugin-react, @vitest/ui, autoprefixer
- npm scripts (keys): build, check:layout, check:layout:local, deploy, dev, format, format:check, lint, preview, test, test:coverage, test:ui
- pyproject.toml: not found
- requirements.txt: not found
- README signal: # 計算プリント自動作成サービス > 小学校算数のカリキュラムに沿った計算プリントを、ブラウザだけで生成・印刷できるReactアプリです。 [![TypeScript](https://img.shields.io/badge/TypeScript-5.9+-blue.svg)](https://www.typescriptlang.org/) [![React](https://img.shields.io/badge/React-19.0+-61dafb.svg)](https://react.dev/) […

## Architecture / Patterns

- Print-first worksheet generator optimized for A4 browser output
- Client-side state store drives settings, regeneration, and preview flow
- Problem-type catalog plus layout engine for grade-specific worksheet generation

## Competitive Landscape (notes)

- [2026-04-10] EdTech trend: adaptive math practice is increasingly organized around **skill-gap targeting** rather than static worksheet batches. That suggests value in reusing this repo's generator catalog for “next worksheet from mistakes” flows, not only one-off printing. (refs: https://www.discoveryeducation.com/blog/teaching-and-learning/adaptive-learning-supports-foundational-math-and-reading/ , https://www.mathbrix.com/blog/adaptive-learning-platforms-math/)
- [2026-04-10] Pedagogy trend: spaced / interleaved retrieval is being emphasized for durable math retention. Printable products can differentiate by generating **cumulative mixed review pages** instead of only topic-isolated sheets. (refs: https://www.mathematicshub.edu.au/plan-teach-and-assess/teaching/teaching-strategies/spaced-interleaved-and-retrieval-practice/ , https://www.carnegielearning.com/blog/retrieval-practice-guide-download)

Potential feature candidates for this repo:
- Add a **mistake-driven regeneration mode** that reissues similar-but-not-identical problems for weak skills.
- Add **spiral review worksheet presets** that intentionally mix prior topics across grades / units.

## Tech Decisions (from PRs/commits)

- [2026-04-16] fix(fraction): 分数パターンがbasicテンプレにフォールバックしてA4から溢れる問題を修正 -- ## Summary \`fix/hissan-mult-advanced-layout\` (#58) で3桁×2桁のかけ算を修正した流れで、全問題パターンを Playwright で俯瞰監査したところ、**5つの分数パターンが A4 から 312px も溢れる**ことが判明。原因は \`getEffectiveProblemType\` が分数パターンを検知できず \`basic\` テンプレート（30問上限）にフォールバックしていたこと。 ## 影響を受けていたパターン | Grade | Pattern … (source: PR #59)
- [2026-04-16] fix(hissan): 3桁×2桁のかけ算が2枚に分かれる問題と横線の幅を修正 -- ## Summary 4年生「3桁×2桁のかけ算の筆算」で報告された2つの問題を修正： 1. **12問でも印刷すると2ページに分かれる** — 実際の問題高さ（216px）が `minProblemHeight: 140px` を大きく超えていたため、A4に収まらず溢れていた 2. **横線の幅がバラバラで短い** — 上の線は4セル分（132px）、下の線は6セル分（200px）と不揃いで、5セル幅の答え行とも一致していなかった ## 変更内容 - **`src/components/Preview/Prob… (source: PR #58)
- [2026-04-12] feat: 数字なぞり書きプリント機能（幼児向け） -- ## Summary - 幼児（年長）向けの数字（0〜9）書き方練習プリントを新規追加 - 1行ごとに「数字ラベル | お手本（書き順番号・矢印付き）| なぞり書き×3 | 自由練習×3」を横並びで表示 - 学年セレクターに「幼児（年長）」を追加。選択時は自動で「数字なぞり書き」モードに切り替わる - 文字サイズは既存の列レイアウト（1/2/3列）で調整可能（1列=最大、3列=最小） ## 主な変更 | ファイル | 内容 | |---|---| | `src/types/index.ts` | `Grade` … (source: PR #56)
- [2026-04-11] refactor: Singapore Math を教育的に本質的なパターンのみに整理 -- ## Summary Singapore Math のパターンを教育的価値の観点で見直し、本質的なものだけを残しました。 ### 残したもの - **Bar Model (Grade 1-2)**: CPA「Pictorial」段階の概念導入ダイアグラム - **Number Bond (Grade 1)**: 数の分解の概念導入ダイアグラム ### 削除したもの (12パターン, -2122行) Comparison, Multi-step, Fraction Set, Decimal, Ratio, Perc… (source: PR #55)
- [2026-03-30] feat: Add Singapore Math problems for Grade 4-6 (Primary 4-6) -- ## Summary - Add 10 new Singapore Math problem patterns covering Grade 4-6 (Primary 4-6) curriculum - Grade 4: fraction-of-a-set, decimal word problems - Grade 5: ratio, percentage, speed/distance/time, volume - Grade 6: algebra, advanced ratio, circle (π=3.1… (source: PR #53)
- [2026-03-29] feat: Add automated verification layer for math problem generators -- ## Summary - Add runtime assertions (`assertValidAnswer`, `assertNoDuplicateNames`, `assertNonEmptyText`) that catch bugs at generation time - Add 110 property-based tests generating 200+ samples per generator/grade — verifying name uniqueness, mathematical c… (source: PR #52)
- [2026-03-29] fix: 1年生+1/+2たし算の2列レイアウトで列ごとに問題が重複するバグを修正 -- ## Summary - `generateAddPlusN`で問題数がプール（0〜9の10通り）を超えた場合、同じシャッフル順で巡回するため2列目が1列目の丸コピーになっていたバグを修正 - プール使い切り時に再シャッフルすることで、列ごとの構造的重複を防止 - 同じパターンを持つ`generateAddTo10`も併せて修正 ## Changes - `src/lib/generators/patterns/grade1.ts`: プール巡回時の再シャッフルロジック追加 - `src/lib/generato… (source: PR #51)
- [2026-03-28] feat: add Singapore Math word problem patterns -- ## 概要 - Singapore Mathの問題タイプ4種をGrade 1-6に追加 ## 変更内容 - `.gitignore` - `artifacts/` と `eng.traineddata` を除外対象に追加 - `scripts/verify-singapore-playwright.mjs` - Grade 1-3 のSingaporeパターンをPlaywrightで自動検証し、解答ON/OFFスクリーンショットを取得する検証スクリプトを追加 - `src/components/Math/Word… (source: PR #47)
