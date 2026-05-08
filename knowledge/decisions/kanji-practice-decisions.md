# kanji-practice Design Decisions

## 2026-05-02: harness pack (AGENTS.md / verify.sh / PR template) — Phase B PoC

- **What**: harness pack (AGENTS.md / verify.sh / PR template) — Phase B PoC
- **Why**: knishioka/openclaw-workspace-knishioka-pm#21 (Phase B PoC) の harness pack を kanji-practice に配備する。
- **Source**: PR #32

## 2026-04-25: 例文写経の練習行を全マス書き取り対象に

- **What**: 例文写経の練習行を全マス書き取り対象に
- **Why**: 例文写経モードの練習行はこれまで「ターゲット漢字のセルだけ書き取り用の白マス、それ以外は薄字の固定文字を表示（読む対象）」という構成だった。
- **Source**: PR #30

## 2026-04-25: 例文写経モードの練習行数を可変化（デフォルト2行・最大3行）

- **What**: 例文写経モードの練習行数を可変化（デフォルト2行・最大3行）
- **Why**: 例文写経モード（PrintMode='sentence'）は従来「お手本1行 + 練習1行」の固定構成で、同じ例文を 1 回しか書写できなかった。学習理論上、写経による定着には 2〜3 回の反復が効果的（.claude/rules/education/learning-theory.md）。本 PR は A4 1 ページに最低 2 問が収まる制約を保ったまま、例文の繰り返し書写を可能にする。
- **Source**: PR #29

## 2026-04-24: Klee Oneフォントをindex.htmlのlinkタグで読み込む（#27の修正）

- **What**: Klee Oneフォントをindex.htmlのlinkタグで読み込む（#27の修正）
- **Why**: PR #27 で src/index.css に @import url(...) で Klee One を読み込んだが、CSS 仕様上 @import は他のすべてのルールより前に配置されている必要があり、@import "tailwindcss" の後ろに書かれていたため**本番で無効化**されていた。
- **Source**: PR #28

## 2026-04-24: 教科書体フォント(Klee One)をWebフォントとして読み込む

- **What**: 教科書体フォント(Klee One)をWebフォントとして読み込む
- **Why**: 漢字練習プリントの漢字がゴシック体で表示される問題を修正。.font-textbook クラスは Klee One を local() のみで指定していたため、フォント未インストール環境（多くの macOS 標準環境含む）では serif フォールバックや OS 標準フォントに落ち、教科書体になっていなかった。
- **Source**: PR #27

## 2026-04-20: 学習プリセット（9級読み・9級書き取り・8級先取り）を追加

- **What**: 学習プリセット（9級読み・9級書き取り・8級先取り）を追加
- **Why**: add learning preset definitions plus pure apply/match helpers for the three learner flows add a learning preset selector to the settings panel while keeping existing manual controls intact add unit tests covering preset defaults, active-state detection, and ex
- **Source**: PR #26

## 2026-04-12: 写経モードのふりがなをルビ注釈方式でゼロフォールバック化

- **What**: 写経モードのふりがなをルビ注釈方式でゼロフォールバック化
- **Why**: 写経モードの例文ふりがなが「フォールバック」推測に依存しており、活用形・音訓選択を誤った読み（例: 何の用？ → なにのもちいる）が大量に出ていた問題を根本解決。
- **Source**: PR #24

## 2026-04-11: a11y改善（lang=ja / slider aria-label / 選択状態 / skip link）

- **What**: a11y改善（lang=ja / slider aria-label / 選択状態 / skip link）
- **Why**: 、キーボードユーザーの操作性を向上 Closes #21 [x] TypeScript型チェック通過 [x] Biome lint/format チェック通過 [x] ユニットテスト 256件全パス [ ] ブラウザでTabキー操作を確認し、Skip linkが表示されることを検証 [ ] スクリーンリーダーでスライダーのラベルが読み上げられることを確認 [ ] 学年/モード変更時に aria-pressed の値が正しく切り替わることを確認 [ ] 印刷プレビュー/PDF生成に影響がないことを確認 🤖 Gen...
- **Source**: PR #23

## 2026-04-11: ページ数が問題生成後にリセットされる問題を修正

- **What**: ページ数が問題生成後にリセットされる問題を修正
- **Why**: App.tsxのhandleGenerateQuestionsとSettingsPanelのuseEffectが独立した問題生成パスとして存在し、App.tsx側は除外漢字を反映しない不整合があった。問題生成をSettingsPanelのuseEffectに統一し、「問題を生成」ボタンはgenerationCounterをインクリメントして再生成をトリガーする設計に変更。
- **Source**: PR #22

## 2026-03-22: ふりがなフォールバックの送りがな・熟語コンテキスト改善

- **What**: ふりがなフォールバックの送りがな・熟語コンテキスト改善
- **Why**: フォールバック時に辞書形の送りがな込み読みがそのまま付く問題を修正（例: 速く→速(はやい)を速(はや)に） okuriganaExamples の語幹データを活用して送りがな部分を除去 隣接する未割り当て漢字がある場合、音読みを優先する熟語コンテキスト判定を追加 不足していた例語データ（気持ち、試合、田植え）を追加 | 文 | 修正前 | 修正後 | |---|---|---| | 速く走る。
- **Source**: PR #19
