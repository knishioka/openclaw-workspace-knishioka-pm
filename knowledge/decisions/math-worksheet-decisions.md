# math-worksheet Design Decisions

## 2026-03-30: feat: Add Singapore Math problems for Grade 4-6 (Primary 4-6)

- **What**: feat: Add Singapore Math problems for Grade 4-6 (Primary 4-6)
- **Why**: ## Summary - Add 10 new Singapore Math problem patterns covering Grade 4-6 (Primary 4-6) curriculum - Grade 4: fraction-of-a-set, decimal word problems - Grade 5: ratio, percentage, speed/distance/time, volume - Grade 6: algebra, advanced ratio, circle (π=3.14…
- **Source**: PR #53

## 2026-03-29: feat: Add automated verification layer for math problem generators

- **What**: feat: Add automated verification layer for math problem generators
- **Why**: ## Summary - Add runtime assertions (`assertValidAnswer`, `assertNoDuplicateNames`, `assertNonEmptyText`) that catch bugs at generation time - Add 110 property-based tests generating 200+ samples per generator/grade — verifying name uniqueness, mathematical co…
- **Source**: PR #52

## 2026-03-29: fix: 1年生+1/+2たし算の2列レイアウトで列ごとに問題が重複するバグを修正

- **What**: fix: 1年生+1/+2たし算の2列レイアウトで列ごとに問題が重複するバグを修正
- **Why**: ## Summary - `generateAddPlusN`で問題数がプール（0〜9の10通り）を超えた場合、同じシャッフル順で巡回するため2列目が1列目の丸コピーになっていたバグを修正 - プール使い切り時に再シャッフルすることで、列ごとの構造的重複を防止 - 同じパターンを持つ`generateAddTo10`も併せて修正 ## Changes - `src/lib/generators/patterns/grade1.ts`: プール巡回時の再シャッフルロジック追加 - `src/lib/generator…
- **Source**: PR #51

## 2026-03-28: feat: add Singapore Math word problem patterns

- **What**: feat: add Singapore Math word problem patterns
- **Why**: ## 概要 - Singapore Mathの問題タイプ4種をGrade 1-6に追加 ## 変更内容 - `.gitignore` - `artifacts/` と `eng.traineddata` を除外対象に追加 - `scripts/verify-singapore-playwright.mjs` - Grade 1-3 のSingaporeパターンをPlaywrightで自動検証し、解答ON/OFFスクリーンショットを取得する検証スクリプトを追加 - `src/components/Math/WordP…
- **Source**: PR #47

## 2026-03-22: feat: 1年生向け入門計算パターン5種を追加

- **What**: feat: 1年生向け入門計算パターン5種を追加
- **Why**: ## Summary - 小さい子向けのより簡単な計算問題パターン5種を1年生に追加 - **+1のたし算** / **+2のたし算**: 固定値を足すシンプルな計算 - **かずをかぞえよう**: ○や★などのシンボルを数える問題 - **○をつかったたし算**: 2グループのシンボルを合わせる - **○をつかったひき算**: シンボルから取り除いた残りを答える - シンボルは20px・5個ごとに改行で視認性を確保 - `PATTERN_COUNT_OVERRIDES`でパターン固有の推奨問題数を設定し、A4印…
- **Source**: PR #46

## 2026-03-07: chore: PR #38マージ後のlocalStorageクリーンアップ

- **What**: chore: PR #38マージ後のlocalStorageクリーンアップ
- **Why**: ## Summary - Add `localStorage.removeItem('math-worksheet-settings')` to the mount `useEffect` in `App.tsx` to clean up legacy persisted data from pre-URL-state migration (PR #38) - Note: The duplicate `getOperationFromPattern` function mentioned in #41 was al…
- **Source**: PR #45
