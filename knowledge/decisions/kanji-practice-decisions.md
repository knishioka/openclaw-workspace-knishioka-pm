# kanji-practice Design Decisions

## 2026-04-20: feat: 学習プリセット（9級読み・9級書き取り・8級先取り）を追加

- **What**: feat: 学習プリセット（9級読み・9級書き取り・8級先取り）を追加
- **Why**: ## Summary - add learning preset definitions plus pure apply/match helpers for the three learner flows - add a learning preset selector to the settings panel while keeping existing manual controls intact - add unit tests covering preset def
- **Source**: PR #26

## 2026-04-12: fix: 写経モードのふりがなをルビ注釈方式でゼロフォールバック化

- **What**: fix: 写経モードのふりがなをルビ注釈方式でゼロフォールバック化
- **Why**: 写経モードの例文ふりがなが「フォールバック」推測に依存しており、活用形・音訓選択を誤った読み（例: `何の用？` → `なにのもちいる`）が大量に出ていた問題を根本解決。
- **Source**: PR #24

## 2026-04-11: feat: a11y改善（lang=ja / slider aria-label / 選択状態 / skip link）

- **What**: feat: a11y改善（lang=ja / slider aria-label / 選択状態 / skip link）
- **Why**: - `<html lang="en">` → `<html lang="ja">` に修正（日本語UIに適切な言語属性） - ページ数・練習マス数・マスサイズの各rangeスライダーに `aria-label` を付与 - 学年選択・プリント種類・ガイドラインのトグルボタンに `aria-pressed` 属性を追加 - Skip link（設定へスキップ / プレビューへスキップ）を追加し、キーボードユーザーの操作性を向上
- **Source**: PR #23

## 2026-04-11: fix: ページ数が問題生成後にリセットされる問題を修正

- **What**: fix: ページ数が問題生成後にリセットされる問題を修正
- **Why**: ## Summary - 問題生成ロジックが`App.tsx`と`SettingsPanel`に重複していた構造を一元化 - `App.tsx`の重複ロジック（`excludedKanji`未対応）を削除し、storeの`regenerate`アクション経由に変更 - `partialize`で一時的データ（`questions`, `generationCounter`）の永続化を除外
- **Source**: PR #22

## 2026-03-22: fix: ふりがなフォールバックの送りがな・熟語コンテキスト改善

- **What**: fix: ふりがなフォールバックの送りがな・熟語コンテキスト改善
- **Why**: - フォールバック時に辞書形の送りがな込み読みがそのまま付く問題を修正（例: 速く→速(はやい)を速(はや)に） - `okuriganaExamples` の語幹データを活用して送りがな部分を除去 - 隣接する未割り当て漢字がある場合、音読みを優先する熟語コンテキスト判定を追加 - 不足していた例語データ（気持ち、試合、田植え）を追加
- **Source**: PR #19

## 2026-03-09: fix: 3モードの問題間マージン最適化で問題数増加

- **What**: fix: 3モードの問題間マージン最適化で問題数増加
- **Why**: - sentence(例文写経)、homophone(同音異字)、readingWriting(読み書き統合)の3モードで問題間マージンを最適化 - 各モード+1問/ページ: sentence 4→5問、homophone 5→6問、readingWriting 5→6問 - A4ページ内の余白(22〜30mm)を有効活用し、印刷効率を向上
- **Source**: PR #18
