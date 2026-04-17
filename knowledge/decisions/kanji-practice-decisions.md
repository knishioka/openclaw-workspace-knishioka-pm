# kanji-practice Design Decisions

## 2026-04-12: fix: 写経モードのふりがなをルビ注釈方式でゼロフォールバック化

- **What**: fix: 写経モードのふりがなをルビ注釈方式でゼロフォールバック化
- **Why**: ## Summary 写経モードの例文ふりがなが「フォールバック」推測に依存しており、活用形・音訓選択を誤った読み（例: `何の用？` → `なにのもちいる`）が大量に出ていた問題を根本解決。 - 例文文字列に `{漢字|よみ}` ルビ記法を導入し、ふりがな生成は注釈を最優先するように変更 - 全 2052 例文を機械注釈 + 約 200 件の手動修正でゼロフォールバック化 - `sentenceCoverage` テストで CI 上の再発防止を保証 ## 主な変更 ### 仕組み - `src/utils/sentenceRuby.ts`: `{漢字|よみ}` パーサ + plain 化ヘルパー - `src/utils/furigana.ts`: `buildFuriganaGroups` 冒頭で注釈優先、`isKanjiChar` に々(U+3005)を追加 - `src/components/print/Sentenc…
- **Source**: PR #24

## 2026-04-11: feat: a11y改善（lang=ja / slider aria-label / 選択状態 / skip link）

- **What**: feat: a11y改善（lang=ja / slider aria-label / 選択状態 / skip link）
- **Why**: ## Summary - `<html lang="en">` → `<html lang="ja">` に修正（日本語UIに適切な言語属性） - ページ数・練習マス数・マスサイズの各rangeスライダーに `aria-label` を付与 - 学年選択・プリント種類・ガイドラインのトグルボタンに `aria-pressed` 属性を追加 - Skip link（設定へスキップ / プレビューへスキップ）を追加し、キーボードユーザーの操作性を向上 Closes #21 ## Test plan - [x] TypeScript型チェック通過 - [x] Biome lint/format チェック通過 - [x] ユニットテスト 256件全パス - [ ] ブラウザでTabキー操作を確認し、Skip linkが表示されることを検証 - [ ] スクリーンリーダーでスライダーのラベルが読み上げられることを確認 - [ ] 学年/…
- **Source**: PR #23

## 2026-04-11: fix: ページ数が問題生成後にリセットされる問題を修正

- **What**: fix: ページ数が問題生成後にリセットされる問題を修正
- **Why**: ## Summary - 問題生成ロジックが`App.tsx`と`SettingsPanel`に重複していた構造を一元化 - `App.tsx`の重複ロジック（`excludedKanji`未対応）を削除し、storeの`regenerate`アクション経由に変更 - `partialize`で一時的データ（`questions`, `generationCounter`）の永続化を除外 ## Root Cause `App.tsx`の`handleGenerateQuestions`と`SettingsPanel`の`useEffect`が独立した問題生成パスとして存在し、`App.tsx`側は除外漢字を反映しない不整合があった。問題生成を`SettingsPanel`の`useEffect`に統一し、「問題を生成」ボタンは`generationCounter`をインクリメントして再生成をトリガーする設計に変更。 ## Ch…
- **Source**: PR #22

## 2026-03-22: fix: ふりがなフォールバックの送りがな・熟語コンテキスト改善

- **What**: fix: ふりがなフォールバックの送りがな・熟語コンテキスト改善
- **Why**: ## Summary - フォールバック時に辞書形の送りがな込み読みがそのまま付く問題を修正（例: 速く→速(はやい)を速(はや)に） - `okuriganaExamples` の語幹データを活用して送りがな部分を除去 - 隣接する未割り当て漢字がある場合、音読みを優先する熟語コンテキスト判定を追加 - 不足していた例語データ（気持ち、試合、田植え）を追加 ### 修正前後の比較 | 文 | 修正前 | 修正後 | |---|---|---| | 速く走る。 | 速(はやい) | 速(はや) ✓ | | 日曜日は休み。 | 休(やすむ) | 休(やす) ✓ | | 帰り道。 | 帰(かえる) | 帰(かえ) ✓ | | 試合が中止。 | 試(こころみる), 合(あう) | 試合(しあい) ✓ | | 気持ちがいい。 | 持(もつ) | 気持(きも) ✓ | | 細かい作業。 | 作(つくる), 業(わざ) | 作(さく), …
- **Source**: PR #19

## 2026-03-09: fix: 3モードの問題間マージン最適化で問題数増加

- **What**: fix: 3モードの問題間マージン最適化で問題数増加
- **Why**: ## Summary - sentence(例文写経)、homophone(同音異字)、readingWriting(読み書き統合)の3モードで問題間マージンを最適化 - 各モード+1問/ページ: sentence 4→5問、homophone 5→6問、readingWriting 5→6問 - A4ページ内の余白(22〜30mm)を有効活用し、印刷効率を向上 ## 変更内容 | モード | 変更前 | 変更後 | 余り | | -------------- | ------------ | -------------- | ------- | | sentence | 4問 (余30mm) | 5問 (余19.5mm) | -10.5mm | | homophone | 5問 (余22mm) | 6問 (余16mm) | -6mm | | readingWriting | 5問 (余22mm) | 6問 (余16mm) |…
- **Source**: PR #18

## 2026-03-08: fix: ふりがな生成の3つの問題を修正し回帰テスト追加

- **What**: fix: ふりがな生成の3つの問題を修正し回帰テスト追加
- **Why**: ## Summary - ひらがな接頭辞の除去（「お寺」→寺(てら)に修正、「おてら」がスパンしていた） - 非連続漢字の読み分割（「買い物」→買(か)+物(もの)、「思い出」→思(おも)+出(で)等） - フォールバック読みのカタカナ→ひらがな変換（190件のカタカナ表示問題を解消） - 全2052例文で問題ゼロを確認する回帰テスト13件を追加 ## 修正内容 ### 1. `getKanjiReading`: 接頭辞除去の追加 「お寺(おてら)」のような単語で、先頭の「お」がふりがなに含まれていた問題。送りがな(suffix)に加えて接頭辞(prefix)も除去するよう拡張。 ### 2. `splitReadingForNonContiguous`: 新規関数 「買い物」「女の子」「思い出」等、漢字間にひらがなが挟まる単語の読みを、間のかな文字をデリミタとして正しく分割。 ### 3. `katakanaToHiraga…
- **Source**: PR #17

## 2026-03-08: feat: sentenceモードを穴埋め形式に改善（ふりがな付き・漢字空欄化）

- **What**: feat: sentenceモードを穴埋め形式に改善（ふりがな付き・漢字空欄化）
- **Why**: ## Summary - 手本行に各漢字のふりがな（訓読み優先）を表示 - 練習行で対象漢字を空欄（グリッドライン付き書き取りマス）に置換 - ひらがな・カタカナ・句読点は練習行でもそのまま表示 Closes #9 ## Changes | File | Change | |------|--------| | `src/components/WritingGrid.tsx` | `SentenceGrid` に `targetKanji`/`furiganaMap`/`gridStyle` props追加、手本行にふりがな表示、練習行で空欄化 | | `src/components/print/SentenceQuestion.tsx` | `allKanji` からふりがなマップ構築、props受け渡し | | `src/components/PrintablePages.tsx` | `SentenceQuestion`…
- **Source**: PR #16

## 2026-03-08: feat: strokeOrderモードにふりがな・読み・例語を追加

- **What**: feat: strokeOrderモードにふりがな・読み・例語を追加
- **Why**: ## Summary - 書き順モードのSVG横に音読み・訓読み・例語（ふりがな付き）を表示 - 既存のレイアウト計算（`cellSize + 6`）内に収まるコンパクトな表示 - biome-ignoreコメントの不正確な記述（DOMPurify→信頼済みソース）を修正 Closes #10 ## Changes - `src/components/print/StrokeOrderQuestion.tsx`: 画数表示エリアを拡張し、読み・例語情報を追加 - `e2e/` スナップショット: フォントレンダリング差異による再生成 ## Test plan - [x] TypeScript型チェック通過 - [x] Biome lint/format通過 - [x] ユニットテスト全233件通過 - [x] E2E機能テスト全20件通過（strokeOrder含む全モードA4レイアウト確認） - [x] セルサイズ12mm/…
- **Source**: PR #15
