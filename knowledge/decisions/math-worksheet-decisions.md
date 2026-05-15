# math-worksheet Design Decisions

Updated: 2026-05-15

## 2026-05-12: feat(word-en): raise grade 4-6 difficulty for English word problems

- **What**: ## Summary 4年生以上の English Word Problems (`word-en`) のレベルが、数値計算面でも英文構造面でも低すぎたため、Grade 4-6 全体を引き上げ。 -...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #69

## 2026-05-12: feat: add equation line option for word problems

- **What**: ## 概要 文章題で立式の練習ができるように、文章題系パターンだけに「式を書く欄」トグルを追加しました。トグルON時は日本語文章題・英語文章題・Singapore Math の各問題で、答え欄の前に式欄を表示します。 Closes #67 ## 変更内容 - `WorksheetSettings` に `showEquationLine`...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #68

## 2026-05-10: [codex] Improve answer line spacing

- **What**: ## Summary - Increase the writable area for Japanese word-problem answer lines. - Move the answer line lower for first-grade symbol/counting problems so it uses the blank space...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #66

## 2026-05-05: fix(number-tracing): match reference handwriting strokes

- **What**: ## Summary Refines the preschool number tracing digits 7, 8, and 9 to better match the supplied handwriting reference. The new shapes focus on the actual pencil path rather than...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #65

## 2026-05-04: fix(number-tracing): refine handwritten digit strokes

- **What**: ## Summary Refines the preschool number tracing digit paths so the examples behave more like pencil handwriting centerlines instead of print-like vector shapes. ## Related Issue...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #64

## 2026-04-25: feat(tracing): 各数字に2行目の練習マスを追加し余白を活用

- **What**: ## Summary 数字なぞり書きプリントで A4 下部に大きな余白が残っていたため、各数字に **2行目の練習マス（4マス）** を追加して、ページ全体を有効活用しつつ練習量を倍増させました。 ## Before / After | | 1問あたりのセル | 練習マス | 余白 | |---|---|---|---| | Before |...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #63

## 2026-04-25: fix(tracing): ラベルなしのセルでもボックス位置を揃える

- **What**: ## Summary 数字なぞり書きプリントで、各行の最初のセル（おてほん/なぞる/かいてみよう のラベル付き）と、それ以降のラベルなしセルで、ボックスの **上端位置がずれていた** 問題を修正。 ## 原因 `Cell` コンポーネント（`NumberTracingRow.tsx`）でラベルを `{label && (...)}`...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #62

## 2026-04-25: fix(tracing): 数字7の左の棒を下向きに修正

- **What**: ## Summary 教科書体の数字7では、左の短い縦棒は上の横棒から **下へ** 伸ばすのが正しい形（serif）。これまでは横棒の **上** に飛び出していたため修正。 ## Before / After | | path | 説明 | |---|---|---| | Before | `M 22 14 L 22 26` | 横棒(y=26)の...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #61

## 2026-04-25: feat(tracing): 0〜4/5〜9の左右2分割レイアウトと教科書体準拠の数字に刷新

- **What**: ## Summary - 数字なぞり書きプリントを「0〜4 を左、5〜9 を右」の固定2分割レイアウトに変更し、各セルを大きく（44px→70px）してなぞり書きしやすく改善 - 全10字の SVG パスを教科書体（学参フォント系）の字形に再設計。特に数字「7」を鋭角な2画（横線→斜め線）として明確化、数字「1」に教科書体らしい上部フラッグを追加 -...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #60

## 2026-04-16: fix(fraction): 分数パターンがbasicテンプレにフォールバックしてA4から溢れる問題を修正

- **What**: ## Summary \`fix/hissan-mult-advanced-layout\` (#58) で3桁×2桁のかけ算を修正した流れで、全問題パターンを Playwright で俯瞰監査したところ、**5つの分数パターンが A4 から 312px も溢れる**ことが判明。原因は \`getEffectiveProblemType\`...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #59
