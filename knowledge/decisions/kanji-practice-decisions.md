# kanji-practice Design Decisions

## 2026-05-14: feat(print): customize first page header fields

- **What**: feat(print): customize first page header fields
- **Why**: 1ページ目ヘッダーの名前欄・日付欄について、表示/非表示とラベル文言を設定パネルから変更できるようにしました。既存設定ロード時はデフォルト値を migration で補完し、2ページ目以降のヘッダー表示は従来どおり維持しています。
- **Source**: PR #34

## 2026-05-02: feat: harness pack (AGENTS.md / verify.sh / PR template) — Phase B PoC

- **What**: feat: harness pack (AGENTS.md / verify.sh / PR template) — Phase B PoC
- **Why**: knishioka/openclaw-workspace-knishioka-pm#21 (Phase B PoC) の harness pack を kanji-practice に配備する。 workspace 側で整備した SSOT テンプレ (AGENTS.md / PR template / verify.sh) を本リポに写し、 Codex auto-resolve の振る舞い検証用に最初の運用リポにする。
- **Source**: PR #32

## 2026-04-25: feat: 例文写経の練習行を全マス書き取り対象に

- **What**: feat: 例文写経の練習行を全マス書き取り対象に
- **Why**: 例文写経モードの練習行はこれまで「ターゲット漢字のセルだけ書き取り用の白マス、それ以外は薄字の固定文字を表示（読む対象）」という構成だった。 しかし例文には対象漢字以外にも漢字・ひらがな・カタカナが含まれており、これらもついでに書写練習できれば、1問あたりの運筆練習量を大幅に増やせる。
- **Source**: PR #30

## 2026-04-25: feat: 例文写経モードの練習行数を可変化（デフォルト2行・最大3行）

- **What**: feat: 例文写経モードの練習行数を可変化（デフォルト2行・最大3行）
- **Why**: 例文写経モード（PrintMode='sentence'）は従来「お手本1行 + 練習1行」の固定構成で、同じ例文を 1 回しか書写できなかった。学習理論上、写経による定着には 2〜3 回の反復が効果的（`.claude/rules/education/learning-theory.md`）。本 PR は A4 1 ページに最低 2 問が収まる制約を保ったまま、例文の繰り返し書写を可能にする。
- **Source**: PR #29

## 2026-04-24: fix: Klee Oneフォントをindex.htmlのlinkタグで読み込む（#27の修正）

- **What**: fix: Klee Oneフォントをindex.htmlのlinkタグで読み込む（#27の修正）
- **Why**: PR #27 で `src/index.css` に `@import url(...)` で Klee One を読み込んだが、CSS 仕様上 `@import` は他のすべてのルールより前に配置されている必要があり、`@import "tailwindcss"` の後ろに書かれていたため**本番で無効化**されていた。
- **Source**: PR #28

## 2026-04-24: fix: 教科書体フォント(Klee One)をWebフォントとして読み込む

- **What**: fix: 教科書体フォント(Klee One)をWebフォントとして読み込む
- **Why**: 漢字練習プリントの漢字がゴシック体で表示される問題を修正。`.font-textbook` クラスは Klee One を `local()` のみで指定していたため、フォント未インストール環境（多くの macOS 標準環境含む）では `serif` フォールバックや OS 標準フォントに落ち、教科書体になっていなかった。
- **Source**: PR #27
