# english-note-maker Design Decisions

Updated: 2026-05-15

## 2026-05-04: fix(alphabet): use bundled tracing font

- **What**: ## 背景 公開サイト `https://knishioka.github.io/english-note-maker/` を Playwright で直接確認したところ、PR #33 は反映済みでしたが、OS フォントの `Comic Sans MS` 由来で大文字・単語の右傾きが残っていました。 また、PR #34 初版の `Chalkboard...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #34

## 2026-05-04: fix(alphabet): refine lowercase tracing baseline position

- **What**: ## Summary 公開後のスクリーンショット確認で、小文字なぞり書きの形は改善されている一方、`a/apple/ant/b` の薄字ガイドが4本線の基準線に対して少し低く、さらにフォント字形由来の右傾きも少し目立っていました。罫線高さやページ密度は変えず、小文字系ガイドの縦位置と、なぞり文字・英字ラベルの傾きを微調整します。 ## Related...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #33

## 2026-05-04: fix(alphabet): align tracing guides with handwriting lines

- **What**: ## Summary アルファベットなぞり書きで、小文字や例示単語の薄字ガイドが手書き練習用の4本線に対してやや合っていなかったため、実表示を Playwright で確認しながら小文字・単語・罫線高さ別に調整しました。 ## Related Issue Relates to #31...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #32

## 2026-05-04: fix(build): restore Vite and typecheck pipeline

- **What**: ## Summary なぞり書きモードの小文字を手書き練習向けの字形に近づけ、あわせて `npm run build` を止めていた TypeScript / Vite 設定の問題を修正しました。 ## Related Issue 関連 Issue はありません。ユーザーからの直接依頼に基づく修正です。 ## Changes Made -...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #31

## 2026-05-02: feat(alphabet): beginner-friendly tracing — non-italic, full-line, repeated horizontally

- **What**: ## Summary Alphabet Practice のなぞり書きモードを初学者向けに改善します。実スクショで複数回イテレーションして仕上げました。 ### 1. 薄字ガイドのフォント刷新 - `font-style: italic → normal` (Century Schoolbook 斜体は子供には読みづらかった) - `font-...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #30

## 2026-05-02: feat(alphabet): expand vocabulary and add tracing mode

- **What**: ## Summary Alphabet Practice の余白問題と語彙不足を解消し、なぞり書き（トレース）モードを追加します。 - **データ拡張**: `ALPHABET_DATA` を `{ letter, words: [{english, japanese}, ...] }` 形式に変更し、各文字 3 語登録（合計 156 語）。 -...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #29

## 2026-04-25: feat(practice): apply paged dedup and difficulty presets to word/phrase/sentence

- **What**: ## Summary Generalizes the cloze-mode improvements from #26 (within-page deduplication + age-driven difficulty presets) to the **word**, **phrase**, and **sentence** practice...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #28

## 2026-04-25: fix(data): resolve near-duplicate phrases in classroom_english

- **What**: ## Summary - `classroom_english` カテゴリの 10-12 グループに、7-9 グループとほぼ同義のフレーズが含まれており、穴埋め演習で「同じ問題を 2 回解いている」感覚を与えていた - 重複の強い 2 フレーズを差し替え、`How` / `Why` 疑問文を新規追加して文型バリエーションを拡充 - 7-9...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #27

## 2026-04-25: fix(cloze): 同一ページ内のフレーズ重複を解消 + 難易度プリセット導入

- **What**: ## Summary - 「教室の英語」など小さめのフレーズプールで穴埋め練習を生成すると、**同一ページ内に同じフレーズが重複表示される**バグを修正 - 難易度プリセット（auto / easy / normal / hard）を導入。年齢グループに自動連動 + 手動オーバーライド対応 - 穴の選択を**スコアリング +...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #26

## 2026-04-16: feat: add phonics word-family practice mode

- **What**: Closes #22 ## Summary - add a phonics practice mode with selectable word-family patterns - render traceable baseline rows and pattern-aware word sequencing - add content,...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #23
