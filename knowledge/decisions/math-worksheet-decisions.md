# math-worksheet Design Decisions

## 2026-05-05: match reference handwriting strokes

- **What**: match reference handwriting strokes
- **Why**: Refines the preschool number tracing digits 7, 8, and 9 to better match the supplied handwriting reference.
- **Source**: PR #65

## 2026-05-04: refine handwritten digit strokes

- **What**: refine handwritten digit strokes
- **Why**: Refines the preschool number tracing digit paths so the examples behave more like pencil handwriting centerlines instead of print-like vector shapes.
- **Source**: PR #64

## 2026-04-25: 各数字に2行目の練習マスを追加し余白を活用

- **What**: 各数字に2行目の練習マスを追加し余白を活用
- **Why**: 数字なぞり書きプリントで A4 下部に大きな余白が残っていたため、各数字に **2行目の練習マス（4マス）** を追加して、ページ全体を有効活用しつつ練習量を倍増させました。
- **Source**: PR #63

## 2026-04-25: ラベルなしのセルでもボックス位置を揃える

- **What**: ラベルなしのセルでもボックス位置を揃える
- **Why**: 数字なぞり書きプリントで、各行の最初のセル（おてほん/なぞる/かいてみよう のラベル付き）と、それ以降のラベルなしセルで、ボックスの **上端位置がずれていた** 問題を修正。
- **Source**: PR #62

## 2026-04-25: 数字7の左の棒を下向きに修正

- **What**: 数字7の左の棒を下向きに修正
- **Why**: 教科書体の数字7では、左の短い縦棒は上の横棒から **下へ** 伸ばすのが正しい形（serif）。これまでは横棒の **上** に飛び出していたため修正。
- **Source**: PR #61

## 2026-04-25: 0〜4/5〜9の左右2分割レイアウトと教科書体準拠の数字に刷新

- **What**: 0〜4/5〜9の左右2分割レイアウトと教科書体準拠の数字に刷新
- **Why**: | 変更内容 | | -------- | -------- | | src/components/Preview/ProblemList.tsx | NumberTracingGrid を追加し、number-tracing をトップレベルで特殊扱い。旧 ProblemItem 内分岐を削除 | | src/lib/data/digit-strokes.ts | 全10字の SVG パスを再設計。0,1,2,3,6,8 = 1画 / 5,7,9 = 2画 / 4 = 3画 | | `src/component...
- **Source**: PR #60

## 2026-04-16: 分数パターンがbasicテンプレにフォールバックしてA4から溢れる問題を修正

- **What**: 分数パターンがbasicテンプレにフォールバックしてA4から溢れる問題を修正
- **Why**: \fix/hissan-mult-advanced-layout\ (#58) で3桁×2桁のかけ算を修正した流れで、全問題パターンを Playwright で俯瞰監査したところ、**5つの分数パターンが A4 から 312px も溢れる**ことが判明。原因は \getEffectiveProblemType\ が分数パターンを検知できず \basic\ テンプレート（30問上限）にフォールバックしていたこと。
- **Source**: PR #59

## 2026-04-16: 3桁×2桁のかけ算が2枚に分かれる問題と横線の幅を修正

- **What**: 3桁×2桁のかけ算が2枚に分かれる問題と横線の幅を修正
- **Why**: 4年生「3桁×2桁のかけ算の筆算」で報告された2つの問題を修正： 1.
- **Source**: PR #58

## 2026-04-12: 数字なぞり書きプリント機能（幼児向け）

- **What**: 数字なぞり書きプリント機能（幼児向け）
- **Why**: | src/types/index.ts | Grade に 0 追加、NumberTracingProblem 型追加 | | src/lib/data/digit-strokes.ts (新規) | 0〜9のSVGストロークデータ（書き順付き） | | src/lib/generators/number-tracing.ts (新規) | 問題生成ロジック | | src/components/Math/NumberTracingRow.tsx (新規) | お手本・なぞり書き・練習マスのSVGレンダリン...
- **Source**: PR #56

## 2026-04-11: Singapore Math を教育的に本質的なパターンのみに整理

- **What**: Singapore Math を教育的に本質的なパターンのみに整理
- **Why**: Singapore Math のパターンを教育的価値の観点で見直し、本質的なものだけを残しました。
- **Source**: PR #55
