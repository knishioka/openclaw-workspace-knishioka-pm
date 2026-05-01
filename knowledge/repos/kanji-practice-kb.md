# kanji-practice Knowledge Base

## Overview

- Repo: knishioka/kanji-practice
- Description: 小学1〜6年生向け漢字練習プリント作成ツール（A4印刷対応、PDF出力）
- Primary language (GitHub): TypeScript
- Category / Priority: education / high
- Status: active
- License: none
- Default branch: main
- Created: 2025-12-30
- Updated: 2026-04-20
- Collected: 2026-04-24

## Tech Stack

- package.json: present
- Dependencies (sample): @radix-ui/react-checkbox, @radix-ui/react-select, @radix-ui/react-slider, clsx, dompurify, html2canvas, jspdf, react, react-dom, react-to-print, zustand
- Dev dependencies (sample): @biomejs/biome, @playwright/test, @tailwindcss/vite, @types/dompurify, @types/node, @types/react, @types/react-dom, @vitejs/plugin-react, @vitest/ui, husky, lint-staged, tailwindcss
- npm scripts (keys): build, check, check:fix, dev, format, lint, lint:fix, prepare, preview, test, test:debug, test:ui
- pyproject.toml: not found
- requirements.txt: not found
- README signal: 漢字練習プリント 小学1〜6年生向け（漢検10級〜5級対応）の漢字練習プリント作成ツールです。 A4サイズで印刷可能なプリントを生成し、PDF出力もサポートしています。 --- 🌐 デモサイト **https://knishioka.github.io/kanji-practice/** **インストール不要！** ブラウザからすぐに使えます。 --- 📸 スクリーンショット 設定パネル 学年・モード・ページ数などを簡単に設定できます。 印刷プレビュー A4サイズに最適化されたプリントをリアルタイムでプレビュー。 9種類の練習モード 読み練習、書き練習、画数問題、書き順練習、例文写経、同音異�

## Architecture / Patterns

- Print-first worksheet generator optimized for A4 browser output
- Client-side state store drives settings, regeneration, and preview flow
- Ruby/furigana-rich question rendering with multiple practice modes and layout-aware print components

## Competitive Landscape (notes)

[2026-04-24] 教育トレンド: spaced / interleaved / retrieval practice は、短い確認を時間差で繰り返す設計が定着に効くと整理されている。漢字プリントでは単発生成だけでなく、前回学習を混ぜた復習プリセットの価値が高い。 (refs: https://www.mathematicshub.edu.au/plan-teach-and-assess/teaching/teaching-strategies/spaced-interleaved-and-retrieval-practice/ , https://www.carnegielearning.com/blog/retrieval-practice-guide-download)
[2026-04-24] 直近の実装で学習プリセットが入ったため、次の差別化ポイントは「習熟の流れ」をプリセットに閉じ込めること。9級読み→9級書き取り→8級先取りの固定選択だけでなく、日次の cumulative review を自動構成できると教材として一段強くなる。 (source: repo PR #26 + refs above)

Potential feature candidates for this repo:
- Add **cumulative review presets** that automatically mix current-grade kanji with recently learned items for spaced retrieval.
- Add a **practice progression mode** that chains reading, writing, and sentence review across multiple days instead of one isolated print job.

## Competitive Landscape (notes)

[2026-04-24] 教育トレンド: spaced / interleaved / retrieval practice は、短い確認を時間差で繰り返す設計が定着に効くと整理されている。漢字プリントでは単発生成だけでなく、前回学習を混ぜた復習プリセットの価値が高い。 (refs: mathematicshub.edu.au/spaced-interleaved-and-retrieval-practice)
[2026-04-24] 直近の実装で学習プリセットが入ったため、次の差別化ポイントは「習熟の流れ」をプリセットに閉じ込めること。9級読み→9級書き取り→8級先取りの固定選択だけでなく、日次の cumulative review を自動構成できると教材として一段強くなる。 (source: repo PR #26)
[2026-05-01] フォント配信: Klee One を Google Fonts 経由の Web フォントに切り替えたことで、未インストール環境（macOS標準）でも教科書体が保証される。全ブラウザで とめ・はね・はらい が正しく表示される状態になった。 (source: PR #27, #28)
[2026-05-01] 写経モード深化: 練習行数が1-3行に可変化し、全マス書き取り対象になった。A4に最低2問収まる制約を保ちつつ1問あたりの運筆量が最大3倍になる。学習理論（2-3回反復）に沿った実装。 (source: PR #29, #30)

Potential feature candidates for this repo:
- Add **cumulative review presets** that automatically mix current-grade kanji with recently learned items for spaced retrieval.
- Add a **practice progression mode** that chains reading, writing, and sentence review across multiple days instead of one isolated print job.

## Tech Decisions (from PRs/commits)

- [2026-04-25] feat: 例文写経の練習行を全マス書き取り対象に -- 練習行の全セルを罫線+ガイドラインのみ（薄字の固定文字を撤去）にし、ターゲット漢字を太枠で視覚的に区別。1問あたりの運筆練習量を大幅増加。 (source: PR #30)
- [2026-04-25] feat: 例文写経モードの練習行数を可変化 -- sentencePracticeRows（デフォルト2、範囲1-3）を追加。calculateMaxSentencePracticeRows()で「最低2問/ページ」と「教育上限3」の小さい方を返す動的制御。 (source: PR #29)
- [2026-04-24] fix: Klee Oneフォント配信 -- CSS @import はTailwind @importの後ろでは無効になるため、index.htmlのlinkタグで Google Fonts 経由の Klee One を読み込む方式に修正。全環境で教科書体が保証される。 (source: PR #28, #27)
- [2026-04-20] feat: 学習プリセット（9級読み・9級書き取り・8級先取り）を追加 -- - add learning preset definitions plus pure apply/match helpers for the three learner flows - add a learning preset selector to the settings panel while keeping existing manual controls intact - add unit tests covering preset defaults, active-state detection, and explicit overwrite behavior Testing - npm run test:unit… (source: PR #26)
- [2026-04-12] fix: 写経モードのふりがなをルビ注釈方式でゼロフォールバック化 -- 写経モードの例文ふりがなが「フォールバック」推測に依存しており、活用形・音訓選択を誤った読み（例: `何の用？` → `なにのもちいる`）が大量に出ていた問題を根本解決。 - 例文文字列に `{漢字 よみ}` ルビ記法を導入し、ふりがな生成は注釈を最優先するように変更 - 全 2052 例文を機械注釈 + 約 200 件の手動修正でゼロフォールバック化 - `sentenceCoverage` テストで CI 上の再発防止を保証 主な変更 仕組み - `src/utils/sentenceRuby.ts`: `{漢字 よみ}` パーサ + plain 化ヘルパー - `src/utils/furigana.ts`: `buildFu… (source: PR #24)
- [2026-04-11] feat: a11y改善（lang=ja / slider aria-label / 選択状態 / skip link） -- - `<html lang="en">` → `<html lang="ja">` に修正（日本語UIに適切な言語属性） - ページ数・練習マス数・マスサイズの各rangeスライダーに `aria-label` を付与 - 学年選択・プリント種類・ガイドラインのトグルボタンに `aria-pressed` 属性を追加 - Skip link（設定へスキップ / プレビューへスキップ）を追加し、キーボードユーザーの操作性を向上 Closes #21 Test plan - [x] TypeScript型チェック通過 - [x] Biome lint/format チェック通過 - [x] ユニットテスト 256件全パス - [ ] ブ… (source: PR #23)
- [2026-04-11] fix: ページ数が問題生成後にリセットされる問題を修正 -- - 問題生成ロジックが`App.tsx`と`SettingsPanel`に重複していた構造を一元化 - `App.tsx`の重複ロジック（`excludedKanji`未対応）を削除し、storeの`regenerate`アクション経由に変更 - `partialize`で一時的データ（`questions`, `generationCounter`）の永続化を除外 Root Cause `App.tsx`の`handleGenerateQuestions`と`SettingsPanel`の`useEffect`が独立した問題生成パスとして存在し、`App.tsx`側は除外漢字を反映しない不整合があった。問題生成を`Settings… (source: PR #22)
- [2026-03-22] fix: ふりがなフォールバックの送りがな・熟語コンテキスト改善 -- - フォールバック時に辞書形の送りがな込み読みがそのまま付く問題を修正（例: 速く→速(はやい)を速(はや)に） - `okuriganaExamples` の語幹データを活用して送りがな部分を除去 - 隣接する未割り当て漢字がある場合、音読みを優先する熟語コンテキスト判定を追加 - 不足していた例語データ（気持ち、試合、田植え）を追加 修正前後の比較 文 修正前 修正後 --- --- --- 速く走る。 速(はやい) 速(はや) ✓ 日曜日は休み。 休(やすむ) 休(やす) ✓ 帰り道。 帰(かえる) 帰(かえ) ✓ 試合が中止。 試(こころみる), 合(あう) 試合(しあい) ✓ 気持ちがいい。 持(もつ) 気持(きも) ✓… (source: PR #19)
- [2026-03-09] fix: 3モードの問題間マージン最適化で問題数増加 -- - sentence(例文写経)、homophone(同音異字)、readingWriting(読み書き統合)の3モードで問題間マージンを最適化 - 各モード+1問/ページ: sentence 4→5問、homophone 5→6問、readingWriting 5→6問 - A4ページ内の余白(22〜30mm)を有効活用し、印刷効率を向上 変更内容 モード 変更前 変更後 余り -------------- ------------ -------------- ------- sentence 4問 (余30mm) 5問 (余19.5mm) -10.5mm homophone 5問 (余22mm) 6問 (余16mm) -6mm… (source: PR #18)
- [2026-03-08] fix: ふりがな生成の3つの問題を修正し回帰テスト追加 -- - ひらがな接頭辞の除去（「お寺」→寺(てら)に修正、「おてら」がスパンしていた） - 非連続漢字の読み分割（「買い物」→買(か)+物(もの)、「思い出」→思(おも)+出(で)等） - フォールバック読みのカタカナ→ひらがな変換（190件のカタカナ表示問題を解消） - 全2052例文で問題ゼロを確認する回帰テスト13件を追加 修正内容 1. `getKanjiReading`: 接頭辞除去の追加 「お寺(おてら)」のような単語で、先頭の「お」がふりがなに含まれていた問題。送りがな(suffix)に加えて接頭辞(prefix)も除去するよう拡張。 2. `splitReadingForNonContiguous`: 新規関数 「買い物… (source: PR #17)
- [2026-03-08] feat: sentenceモードを穴埋め形式に改善（ふりがな付き・漢字空欄化） -- - 手本行に各漢字のふりがな（訓読み優先）を表示 - 練習行で対象漢字を空欄（グリッドライン付き書き取りマス）に置換 - ひらがな・カタカナ・句読点は練習行でもそのまま表示 Closes #9 Changes File Change ------ -------- `src/components/WritingGrid.tsx` `SentenceGrid` に `targetKanji`/`furiganaMap`/`gridStyle` props追加、手本行にふりがな表示、練習行で空欄化 `src/components/print/SentenceQuestion.tsx` `allKanji` からふりがなマップ構築、pro… (source: PR #16)
