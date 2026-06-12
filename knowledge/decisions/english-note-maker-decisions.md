# english-note-maker Design Decisions

## 2026-06-12: fix(phrase): フレーズコレクションの本番環境ランタイム読み込み修正 (#37)

- **What**: fix(phrase): フレーズコレクションの本番環境ランタイム読み込み修正 (#37)
- **Why**: 本番 GitHub Pages において、フレーズ／クローズカテゴリーを選択すると無関係なコンテンツが出題されていたバグを修正しました。根本原因は `import.meta.glob`（Vite コンパイル時マクロ）が未変換のままブラウザに渡ることで、全コレクション JSON（21カテゴリー・約1514フレーズ）が読み込まれていなかった点です。`fetch()` によるランタイムフォールバックを追加し、Vite を介さない素の静的配信環境でも正しく動作するよう対応しました。
- **Source**: PR #37

## 2026-04-25: feat(practice): apply paged dedup and difficulty presets to word/phrase/sentence

- **What**: feat(practice): apply paged dedup and difficulty presets to word/phrase/sentence
- **Why**: Generalizes the cloze-mode improvements from #26 (within-page deduplication + age-driven difficulty presets) to the **word**, **phrase**, and **sentence** practice modes.
- **Source**: PR #28

## 2026-04-25: fix(data): resolve near-duplicate phrases in classroom_english

- **What**: fix(data): resolve near-duplicate phrases in classroom_english
- **Why**: - `classroom_english` カテゴリの 10-12 グループに、7-9 グループとほぼ同義のフレーズが含まれており、穴埋め演習で「同じ問題を 2 回解いている」感覚を与えていた - 重複の強い 2 フレーズを差し替え、`How` / `Why` 疑問文を新規追加して文型バリエーションを拡充 - 7-9 のシンプル版は年齢相応として残し、10-12 側だけを置換
- **Source**: PR #27

## 2026-04-25: fix(cloze): 同一ページ内のフレーズ重複を解消 + 難易度プリセット導入

- **What**: fix(cloze): 同一ページ内のフレーズ重複を解消 + 難易度プリセット導入
- **Why**: - 「教室の英語」など小さめのフレーズプールで穴埋め練習を生成すると、**同一ページ内に同じフレーズが重複表示される**バグを修正 - 難易度プリセット（auto / easy / normal / hard）を導入。年齢グループに自動連動 + 手動オーバーライド対応 - 穴の選択を**スコアリング + ランダム化**にし、同じ文を再生成すると違う箇所が穴になるよう変更（反復学習の効果向上）
- **Source**: PR #26

## 2026-04-16: feat: add phonics word-family practice mode

- **What**: feat: add phonics word-family practice mode
- **Why**: ## Summary - add a phonics practice mode with selectable word-family patterns - render traceable baseline rows and pattern-aware word sequencing - add content, layout, and phonics data tests for the new mode
- **Source**: PR #23

## 2026-04-11: fix(cloze): increase questions per page and hide notice from print

- **What**: fix(cloze): increase questions per page and hide notice from print
- **Why**: ## Summary - 穴埋め問題の1ページあたりの問題数を増加（上限4→10、練習行を2行→1行に削減、CSS gapを縮小） - `getClozeCapacity()` の計算を正確なレイアウト高さに基づくように修正 - 自動調整通知（`.auto-layout-notice`）が印刷時に表示されてA4からはみ出す問題を修正
- **Source**: PR #21
