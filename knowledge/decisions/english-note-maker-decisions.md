# english-note-maker Design Decisions

## 2026-05-04: fix(alphabet): use bundled tracing font

- **What**: fix(alphabet): use bundled tracing font
- **Why**: 公開サイト `https://knishioka.github.io/english-note-maker/` を Playwright で直接確認したところ、PR #33 は反映済みでしたが、OS フォントの `Comic Sans MS` 由来で大文字・単語の右傾きが残っていました。 
- **Source**: PR #34

## 2026-05-04: fix(alphabet): refine lowercase tracing baseline position

- **What**: fix(alphabet): refine lowercase tracing baseline position
- **Why**: 公開後のスクリーンショット確認で、小文字なぞり書きの形は改善されている一方、`a/apple/ant/b` の薄字ガイドが4本線の基準線に対して少し低く、さらにフォント字形由来の右傾きも少し目立っていました。罫線高さやページ密度は変えず、小文字系ガイドの縦位置と、なぞり文字・英字ラベルの傾きを微調整します。 
- **Source**: PR #33

## 2026-05-04: fix(alphabet): align tracing guides with handwriting lines

- **What**: fix(alphabet): align tracing guides with handwriting lines
- **Why**: アルファベットなぞり書きで、小文字や例示単語の薄字ガイドが手書き練習用の4本線に対してやや合っていなかったため、実表示を Playwright で確認しながら小文字・単語・罫線高さ別に調整しました。 
- **Source**: PR #32

## 2026-05-04: fix(build): restore Vite and typecheck pipeline

- **What**: fix(build): restore Vite and typecheck pipeline
- **Why**: なぞり書きモードの小文字を手書き練習向けの字形に近づけ、あわせて `npm run build` を止めていた TypeScript / Vite 設定の問題を修正しました。 
- **Source**: PR #31

## 2026-05-02: feat(alphabet): beginner-friendly tracing — non-italic, full-line, repeated horizontally

- **What**: feat(alphabet): beginner-friendly tracing — non-italic, full-line, repeated horizontally
- **Why**: Alphabet Practice のなぞり書きモードを初学者向けに改善します。実スクショで複数回イテレーションして仕上げました。 
- **Source**: PR #30

## 2026-05-02: feat(alphabet): expand vocabulary and add tracing mode

- **What**: feat(alphabet): expand vocabulary and add tracing mode
- **Why**: Alphabet Practice の余白問題と語彙不足を解消し、なぞり書き（トレース）モードを追加します。 
- **Source**: PR #29
