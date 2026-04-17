# math-worksheet Design Decisions

## 2026-04-16: fix(fraction): 分数パターンがbasicテンプレにフォールバックしてA4から溢れる問題を修正

- **What**: fix(fraction): 分数パターンがbasicテンプレにフォールバックしてA4から溢れる問題を修正
- **Why**: ## Summary \`fix/hissan-mult-advanced-layout\` (#58) で3桁×2桁のかけ算を修正した流れで、全問題パターンを Playwright で俯瞰監査したところ、**5つの分数パターンが A4 から 312px も溢れる**ことが判明。原因は \`getEffectiveProblemType\` が分数パターンを検知できず \`basic\` テンプレート（30問上限）にフォールバックしていたこと。 ## 影響を受けていたパターン | Grade | Pattern | Before | After | | ----- | ------- | ------ | ----- | | 3 | frac-same-denom | 20問/2列, h=1435px ❌ | 14問/2列, h=1123px ✅ | | 5 | frac-different-denom | 20問/2列, h…
- **Source**: PR #59

## 2026-04-16: fix(hissan): 3桁×2桁のかけ算が2枚に分かれる問題と横線の幅を修正

- **What**: fix(hissan): 3桁×2桁のかけ算が2枚に分かれる問題と横線の幅を修正
- **Why**: ## Summary 4年生「3桁×2桁のかけ算の筆算」で報告された2つの問題を修正： 1. **12問でも印刷すると2ページに分かれる** — 実際の問題高さ（216px）が `minProblemHeight: 140px` を大きく超えていたため、A4に収まらず溢れていた 2. **横線の幅がバラバラで短い** — 上の線は4セル分（132px）、下の線は6セル分（200px）と不揃いで、5セル幅の答え行とも一致していなかった ## 変更内容 - **`src/components/Preview/ProblemList.tsx`**: `answerWidth` を一度だけ計算し、上下の横線を答え行と同じ幅に統一 - **`src/config/print-templates.ts`**: hissan テンプレートの `rowGap` を 56px→32px、`minProblemHeight` を 140px→20…
- **Source**: PR #58

## 2026-04-12: feat: 数字なぞり書きプリント機能（幼児向け）

- **What**: feat: 数字なぞり書きプリント機能（幼児向け）
- **Why**: ## Summary - 幼児（年長）向けの数字（0〜9）書き方練習プリントを新規追加 - 1行ごとに「数字ラベル | お手本（書き順番号・矢印付き）| なぞり書き×3 | 自由練習×3」を横並びで表示 - 学年セレクターに「幼児（年長）」を追加。選択時は自動で「数字なぞり書き」モードに切り替わる - 文字サイズは既存の列レイアウト（1/2/3列）で調整可能（1列=最大、3列=最小） ## 主な変更 | ファイル | 内容 | |---|---| | `src/types/index.ts` | `Grade` に `0` 追加、`NumberTracingProblem` 型追加 | | `src/lib/data/digit-strokes.ts` (新規) | 0〜9のSVGストロークデータ（書き順付き） | | `src/lib/generators/number-tracing.ts` (新規) | 問題生成ロジック…
- **Source**: PR #56

## 2026-04-11: refactor: Singapore Math を教育的に本質的なパターンのみに整理

- **What**: refactor: Singapore Math を教育的に本質的なパターンのみに整理
- **Why**: ## Summary Singapore Math のパターンを教育的価値の観点で見直し、本質的なものだけを残しました。 ### 残したもの - **Bar Model (Grade 1-2)**: CPA「Pictorial」段階の概念導入ダイアグラム - **Number Bond (Grade 1)**: 数の分解の概念導入ダイアグラム ### 削除したもの (12パターン, -2122行) Comparison, Multi-step, Fraction Set, Decimal, Ratio, Percentage, Rate, Volume, Algebra, Ratio Advanced, Circle, Data Analysis — 全てEnglish Word Problemsと本質的に同じテキスト文章題 ### その他の修正 - Bar Model diagram のオーバーフロー修正 (固定幅180px…
- **Source**: PR #55

## 2026-03-30: feat: Add Singapore Math problems for Grade 4-6 (Primary 4-6)

- **What**: feat: Add Singapore Math problems for Grade 4-6 (Primary 4-6)
- **Why**: ## Summary - Add 10 new Singapore Math problem patterns covering Grade 4-6 (Primary 4-6) curriculum - Grade 4: fraction-of-a-set, decimal word problems - Grade 5: ratio, percentage, speed/distance/time, volume - Grade 6: algebra, advanced ratio, circle (π=3.14), data analysis (mean/median/mode) - All generators follow established patterns with `assertValidProblem` validation Closes #49 ## Changes | File | Change | |…
- **Source**: PR #53

## 2026-03-29: feat: Add automated verification layer for math problem generators

- **What**: feat: Add automated verification layer for math problem generators
- **Why**: ## Summary - Add runtime assertions (`assertValidAnswer`, `assertNoDuplicateNames`, `assertNonEmptyText`) that catch bugs at generation time - Add 110 property-based tests generating 200+ samples per generator/grade — verifying name uniqueness, mathematical correctness, grade constraints, and diagram consistency - Extend Playwright verification script from 9 Singapore combos to 54 combos covering all problem types -…
- **Source**: PR #52

## 2026-03-29: fix: 1年生+1/+2たし算の2列レイアウトで列ごとに問題が重複するバグを修正

- **What**: fix: 1年生+1/+2たし算の2列レイアウトで列ごとに問題が重複するバグを修正
- **Why**: ## Summary - `generateAddPlusN`で問題数がプール（0〜9の10通り）を超えた場合、同じシャッフル順で巡回するため2列目が1列目の丸コピーになっていたバグを修正 - プール使い切り時に再シャッフルすることで、列ごとの構造的重複を防止 - 同じパターンを持つ`generateAddTo10`も併せて修正 ## Changes - `src/lib/generators/patterns/grade1.ts`: プール巡回時の再シャッフルロジック追加 - `src/lib/generators/patterns/grade1-beginner.test.ts`: 2列20問で前半・後半が完全一致しないことを検証するテスト追加（+1, +2両方） ## Root Cause `pool[i % pool.length]` でプールサイズを超えた場合、モジュロにより先頭から同一順序で再利用されていた。2列レ…
- **Source**: PR #51

## 2026-03-28: feat: add Singapore Math word problem patterns

- **What**: feat: add Singapore Math word problem patterns
- **Why**: ## 概要 - Singapore Mathの問題タイプ4種をGrade 1-6に追加 ## 変更内容 - `.gitignore` - `artifacts/` と `eng.traineddata` を除外対象に追加 - `scripts/verify-singapore-playwright.mjs` - Grade 1-3 のSingaporeパターンをPlaywrightで自動検証し、解答ON/OFFスクリーンショットを取得する検証スクリプトを追加 - `src/components/Math/WordProblemEn.tsx` - Singaporeカテゴリ（`comparison` / `missing-number` など）でも解答表示トグルが正しく反映されるように調整 - `src/config/__tests__/pattern-categories.test.ts` - Singaporeカテゴリの分類…
- **Source**: PR #47
