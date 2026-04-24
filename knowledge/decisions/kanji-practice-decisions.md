# kanji-practice Design Decisions

## 2026-04-20: feat: 学習プリセット（9級読み・9級書き取り・8級先取り）を追加

- **What**: feat: 学習プリセット（9級読み・9級書き取り・8級先取り）を追加
- **Why**: - add learning preset definitions plus pure apply/match helpers for the three learner flows - add a learning preset selector to the settings panel while keeping existing manual controls intact - add unit tests covering preset defaults, active-state detection,…
- **Source**: PR #26

## 2026-04-12: fix: 写経モードのふりがなをルビ注釈方式でゼロフォールバック化

- **What**: fix: 写経モードのふりがなをルビ注釈方式でゼロフォールバック化
- **Why**: No summary captured.
- **Source**: PR #24

## 2026-04-11: feat: a11y改善（lang=ja / slider aria-label / 選択状態 / skip link）

- **What**: feat: a11y改善（lang=ja / slider aria-label / 選択状態 / skip link）
- **Why**: No summary captured.
- **Source**: PR #23

## 2026-04-11: fix: ページ数が問題生成後にリセットされる問題を修正

- **What**: fix: ページ数が問題生成後にリセットされる問題を修正
- **Why**: - 問題生成ロジックが`App.tsx`と`SettingsPanel`に重複していた構造を一元化 - `App.tsx`の重複ロジック（`excludedKanji`未対応）を削除し、storeの`regenerate`アクション経由に変更 - `partialize`で一時的データ（`questions`, `generationCounter`）の永続化を除外
- **Source**: PR #22

## 2026-03-22: fix: ふりがなフォールバックの送りがな・熟語コンテキスト改善

- **What**: fix: ふりがなフォールバックの送りがな・熟語コンテキスト改善
- **Why**: No summary captured.
- **Source**: PR #19

## 2026-03-09: fix: 3モードの問題間マージン最適化で問題数増加

- **What**: fix: 3モードの問題間マージン最適化で問題数増加
- **Why**: No summary captured.
- **Source**: PR #18

## 2026-03-08: fix: ふりがな生成の3つの問題を修正し回帰テスト追加

- **What**: fix: ふりがな生成の3つの問題を修正し回帰テスト追加
- **Why**: - ひらがな接頭辞の除去（「お寺」→寺(てら)に修正、「おてら」がスパンしていた） - 非連続漢字の読み分割（「買い物」→買(か)+物(もの)、「思い出」→思(おも)+出(で)等） - フォールバック読みのカタカナ→ひらがな変換（190件のカタカナ表示問題を解消） - 全2052例文で問題ゼロを確認する回帰テスト13件を追加
- **Source**: PR #17

## 2026-03-08: feat: sentenceモードを穴埋め形式に改善（ふりがな付き・漢字空欄化）

- **What**: feat: sentenceモードを穴埋め形式に改善（ふりがな付き・漢字空欄化）
- **Why**: No summary captured.
- **Source**: PR #16
