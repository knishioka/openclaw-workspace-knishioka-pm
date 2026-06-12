# math-worksheet Design Decisions

## 2026-06-11: feat(grade1): +3〜+9のたし算パターンを追加（答えが10を超えてよい）

- **What**: feat(grade1): +3〜+9のたし算パターンを追加（答えが10を超えてよい）
- **Why**: 小学1年生の入門パターンに **+3〜+9のたし算** を追加します（既存の+1/+2と同シリーズ）。あわせて「**足した結果が10を超えてもよい**」ルールを適用します。
- **Source**: PR #74

## 2026-06-11: feat(print): 実測ベースのA4オーバーフローガードを追加

- **What**: feat(print): 実測ベースのA4オーバーフローガードを追加
- **Why**: PDFのA4はみ出しが繰り返し再発する問題（直近では4年生word-en）への根本対策の第1弾です。
- **Source**: PR #73

## 2026-05-04: fix(number-tracing): refine handwritten digit strokes

- **What**: fix(number-tracing): refine handwritten digit strokes
- **Why**: ## Summary Refines the preschool number tracing digit paths so the examples behave more like pencil handwriting centerlines instead of print-like vector shapes.
- **Source**: PR #64

## 2026-04-25: feat(tracing): 各数字に2行目の練習マスを追加し余白を活用

- **What**: feat(tracing): 各数字に2行目の練習マスを追加し余白を活用
- **Why**: 数字なぞり書きプリントで A4 下部に大きな余白が残っていたため、各数字に **2行目の練習マス（4マス）** を追加して、ページ全体を有効活用しつつ練習量を倍増させました。
- **Source**: PR #63

## 2026-04-25: fix(tracing): ラベルなしのセルでもボックス位置を揃える

- **What**: fix(tracing): ラベルなしのセルでもボックス位置を揃える
- **Why**: 数字なぞり書きプリントで、各行の最初のセル（おてほん/なぞる/かいてみよう のラベル付き）と、それ以降のラベルなしセルで、ボックスの **上端位置がずれていた** 問題を修正。
- **Source**: PR #62

## 2026-04-25: fix(tracing): 数字7の左の棒を下向きに修正

- **What**: fix(tracing): 数字7の左の棒を下向きに修正
- **Why**: 教科書体の数字7では、左の短い縦棒は上の横棒から **下へ** 伸ばすのが正しい形（serif）。これまでは横棒の **上** に飛び出していたため修正。
- **Source**: PR #61
