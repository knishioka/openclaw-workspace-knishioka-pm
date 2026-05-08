# english-note-maker Design Decisions

## 2026-05-04: use bundled tracing font

- **What**: use bundled tracing font
- **Why**: 公開サイト https://knishioka.github.io/english-note-maker/ を Playwright で直接確認したところ、PR #33 は反映済みでしたが、OS フォントの Comic Sans MS 由来で大文字・単語の右傾きが残っていました。
- **Source**: PR #34

## 2026-05-04: refine lowercase tracing baseline position

- **What**: refine lowercase tracing baseline position
- **Why**: 公開後のスクリーンショット確認で、小文字なぞり書きの形は改善されている一方、a/apple/ant/b の薄字ガイドが4本線の基準線に対して少し低く、さらにフォント字形由来の右傾きも少し目立っていました。罫線高さやページ密度は変えず、小文字系ガイドの縦位置と、なぞり文字・英字ラベルの傾きを微調整します。
- **Source**: PR #33

## 2026-05-04: align tracing guides with handwriting lines

- **What**: align tracing guides with handwriting lines
- **Why**: アルファベットなぞり書きで、小文字や例示単語の薄字ガイドが手書き練習用の4本線に対してやや合っていなかったため、実表示を Playwright で確認しながら小文字・単語・罫線高さ別に調整しました。
- **Source**: PR #32

## 2026-05-04: restore Vite and typecheck pipeline

- **What**: restore Vite and typecheck pipeline
- **Why**: なぞり書きモードの小文字を手書き練習向けの字形に近づけ、あわせて npm run build を止めていた TypeScript / Vite 設定の問題を修正しました。
- **Source**: PR #31

## 2026-05-02: beginner-friendly tracing — non-italic, full-line, repeated horizontally

- **What**: beginner-friendly tracing — non-italic, full-line, repeated horizontally
- **Why**: Alphabet Practice のなぞり書きモードを初学者向けに改善します。実スクショで複数回イテレーションして仕上げました。
- **Source**: PR #30

## 2026-05-02: expand vocabulary and add tracing mode

- **What**: expand vocabulary and add tracing mode
- **Why**: Alphabet Practice の余白問題と語彙不足を解消し、なぞり書き（トレース）モードを追加します。
- **Source**: PR #29

## 2026-04-25: apply paged dedup and difficulty presets to word/phrase/sentence

- **What**: apply paged dedup and difficulty presets to word/phrase/sentence
- **Why**: Generalizes the cloze-mode improvements from #26 (within-page deduplication + age-driven difficulty presets) to the **word**, **phrase**, and **sentence** practice modes.
- **Source**: PR #28

## 2026-04-25: resolve near-duplicate phrases in classroom_english

- **What**: resolve near-duplicate phrases in classroom_english
- **Why**: ループとほぼ同義のフレーズが含まれており、穴埋め演習で「同じ問題を 2 回解いている」感覚を与えていた 重複の強い 2 フレーズを差し替え、How / Why 疑問文を新規追加して文型バリエーションを拡充 7-9 のシンプル版は年齢相応として残し、10-12 側だけを置換 Closes #24 | Age Group | Before | After | 理由 | |-----------|--------|-------|------| | 10-12 | Could you explain that again?
- **Source**: PR #27

## 2026-04-25: 同一ページ内のフレーズ重複を解消 + 難易度プリセット導入

- **What**: 同一ページ内のフレーズ重複を解消 + 難易度プリセット導入
- **Why**: \buildExtendedSequence\ がプール枯渇時にその場で再シャッフルする実装で、再シャッフル境界が**ページ内に落ちる**ケースで同一ページ内重複が発生していた。例：\classroom_english\ 7-9 歳（プール 12 件）× perPage 10 のとき、ページ 2 が \shuffle1[10..11]\ + \shuffle2[0..7]\ となりページ内で同じフレーズが出る。
- **Source**: PR #26

## 2026-04-16: add phonics word-family practice mode

- **What**: add phonics word-family practice mode
- **Why**: Closes #22 add a phonics practice mode with selectable word-family patterns render traceable baseline rows and pattern-aware word sequencing add content, layout, and phonics data tests for the new mode
- **Source**: PR #23
