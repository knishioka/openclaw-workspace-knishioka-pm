# kanji-practice Design Decisions

Updated: 2026-05-15

## 2026-05-14: feat(print): customize first page header fields

- **What**: ## 概要 1ページ目ヘッダーの名前欄・日付欄について、表示/非表示とラベル文言を設定パネルから変更できるようにしました。既存設定ロード時はデフォルト値を migration で補完し、2ページ目以降のヘッダー表示は従来どおり維持しています。 Closes #33 ## 変更内容 - `Settings` に `showNameField` /...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #34

## 2026-05-02: feat: harness pack (AGENTS.md / verify.sh / PR template) — Phase B PoC

- **What**: ## 概要 knishioka/openclaw-workspace-knishioka-pm#21 (Phase B PoC) の harness pack を kanji-practice に配備する。 workspace 側で整備した SSOT テンプレ (AGENTS.md / PR template / verify.sh) を本リポに写し、...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #32

## 2026-04-25: feat: 例文写経の練習行を全マス書き取り対象に

- **What**: ## 背景・狙い 例文写経モードの練習行はこれまで「ターゲット漢字のセルだけ書き取り用の白マス、それ以外は薄字の固定文字を表示（読む対象）」という構成だった。 しかし例文には対象漢字以外にも漢字・ひらがな・カタカナが含まれており、これらもついでに書写練習できれば、1問あたりの運筆練習量を大幅に増やせる。 ## 変更内容 - 練習行:...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #30

## 2026-04-25: feat: 例文写経モードの練習行数を可変化（デフォルト2行・最大3行）

- **What**: ## 背景 例文写経モード（PrintMode='sentence'）は従来「お手本1行 + 練習1行」の固定構成で、同じ例文を 1 回しか書写できなかった。学習理論上、写経による定着には 2〜3 回の反復が効果的（`.claude/rules/education/learning-theory.md`）。本 PR は A4 1 ページに最低 2...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #29

## 2026-04-24: fix: Klee Oneフォントをindex.htmlのlinkタグで読み込む（#27の修正）

- **What**: ## 背景 PR #27 で `src/index.css` に `@import url(...)` で Klee One を読み込んだが、CSS 仕様上 `@import` は他のすべてのルールより前に配置されている必要があり、`@import "tailwindcss"` の後ろに書かれていたため**本番で無効化**されていた。...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #28

## 2026-04-24: fix: 教科書体フォント(Klee One)をWebフォントとして読み込む

- **What**: ## Summary 漢字練習プリントの漢字がゴシック体で表示される問題を修正。`.font-textbook` クラスは Klee One を `local()` のみで指定していたため、フォント未インストール環境（多くの macOS 標準環境含む）では `serif` フォールバックや OS 標準フォントに落ち、教科書体になっていなかった。...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #27

## 2026-04-20: feat: 学習プリセット（9級読み・9級書き取り・8級先取り）を追加

- **What**: ## Summary - add learning preset definitions plus pure apply/match helpers for the three learner flows - add a learning preset selector to the settings panel while keeping...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #26

## 2026-04-12: fix: 写経モードのふりがなをルビ注釈方式でゼロフォールバック化

- **What**: ## Summary 写経モードの例文ふりがなが「フォールバック」推測に依存しており、活用形・音訓選択を誤った読み（例: `何の用？` → `なにのもちいる`）が大量に出ていた問題を根本解決。 - 例文文字列に `{漢字|よみ}` ルビ記法を導入し、ふりがな生成は注釈を最優先するように変更 - 全 2052 例文を機械注釈 + 約 200...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #24

## 2026-04-11: feat: a11y改善（lang=ja / slider aria-label / 選択状態 / skip link）

- **What**: ## Summary - `<html lang="en">` → `<html lang="ja">` に修正（日本語UIに適切な言語属性） - ページ数・練習マス数・マスサイズの各rangeスライダーに `aria-label` を付与 - 学年選択・プリント種類・ガイドラインのトグルボタンに `aria-pressed` 属性を追加 - Skip...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #23

## 2026-04-11: fix: ページ数が問題生成後にリセットされる問題を修正

- **What**: ## Summary - 問題生成ロジックが`App.tsx`と`SettingsPanel`に重複していた構造を一元化 - `App.tsx`の重複ロジック（`excludedKanji`未対応）を削除し、storeの`regenerate`アクション経由に変更 - `partialize`で一時的データ（`questions`,...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #22
