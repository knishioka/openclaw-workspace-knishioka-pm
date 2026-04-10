# kanji-practice Knowledge Base

## Overview

- Repo: knishioka/kanji-practice
- Description: 小学1〜6年生向け漢字練習プリント作成ツール（A4印刷対応、PDF出力）
- Primary language (GitHub): TypeScript
- Category / Priority: education / high
- License: none
- Default branch: main
- Created: 2025-12-30
- Updated: 2026-03-22
- Collected: 2026-04-10

## Tech Stack

- package.json: present
- Dependencies (sample): @radix-ui/react-checkbox, @radix-ui/react-select, @radix-ui/react-slider, clsx, dompurify, html2canvas, jspdf, react, react-dom, react-to-print, zustand
- Dev dependencies (sample): @biomejs/biome, @playwright/test, @tailwindcss/vite, @types/dompurify, @types/node, @types/react, @types/react-dom, @vitejs/plugin-react, @vitest/ui, husky, lint-staged, tailwindcss
- npm scripts (keys): build, check, check:fix, dev, format, lint, lint:fix, prepare, preview, test, test:debug, test:ui
- pyproject.toml: not found
- requirements.txt: not found
- README signal: # 漢字練習プリント [![GitHub Pages](https://img.shields.io/badge/Demo-GitHub%20Pages-blue?logo=github)](https://knishioka.github.io/kanji-practice/) [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://…

## Architecture / Patterns

- Client-side printable worksheet generator
- Multiple exercise modes with furigana-aware rendering
- Print/PDF oriented UX for elementary study sheets

## Competitive Landscape (notes)

- [2026-04-03] Similar worksheet generators / practice resources:
  - Kakikata Generator (かきかたプリントメーカー): printable Japanese writing practice PDFs (ref: https://kakikata.maripo.org/)
  - Kanji.sh: free printable kanji practice sheets, filtering by JLPT/grade/etc (ref: https://kanji.sh/write)
  - MichiKanji: JLPT kanji practice PDFs incl. stroke order diagrams (ref: https://www.michikanji.com/free-resources)
  - TestMaker (漢字テストメーカー): furigana +穴埋め等のプリント作成/配布 (ref: https://www.test-maker.app/lp/kanji-test)
  - Canva: ふりがな（ルビ）機能で教材をデザインできる（プリント生成は別途） (ref: https://www.canva.com/ja_jp/features/furigana/)

Potential feature candidates for this repo:
- Custom vocabulary import (user word list) + shareable URLs per set.
- Optional JLPT/漢検タグでの出題フィルタ（学年以外の切り口）。
- 「間違えた漢字だけ再生成」など復習導線（弱点ベース）を追加。

## Tech Decisions (from PRs/commits)

- [2026-03-22] fix: ふりがなフォールバックの送りがな・熟語コンテキスト改善 -- ## Summary - フォールバック時に辞書形の送りがな込み読みがそのまま付く問題を修正（例: 速く→速(はやい)を速(はや)に） - `okuriganaExamples` の語幹データを活用して送りがな部分を除去 - 隣接する未割り当て漢字がある場合、音読みを優先する熟語コンテキスト判定を追加 - 不足していた例語データ（気持ち、試合、田植え）を追加 ### 修正前後の比較 | 文 | 修正前 | 修正後 | |---|---|---| | 速く走る。 | 速(はやい… (source: PR #19)
- [2026-03-09] fix: 3モードの問題間マージン最適化で問題数増加 -- ## Summary - sentence(例文写経)、homophone(同音異字)、readingWriting(読み書き統合)の3モードで問題間マージンを最適化 - 各モード+1問/ページ: sentence 4→5問、homophone 5→6問、readingWriting 5→6問 - A4ページ内の余白(22〜30mm)を有効活用し、印刷効率を向上 ## 変更内容 | モード | 変更前 | 変更後 | 余り | | -------------- | -----… (source: PR #18)
- [2026-03-08] fix: ふりがな生成の3つの問題を修正し回帰テスト追加 -- ## Summary - ひらがな接頭辞の除去（「お寺」→寺(てら)に修正、「おてら」がスパンしていた） - 非連続漢字の読み分割（「買い物」→買(か)+物(もの)、「思い出」→思(おも)+出(で)等） - フォールバック読みのカタカナ→ひらがな変換（190件のカタカナ表示問題を解消） - 全2052例文で問題ゼロを確認する回帰テスト13件を追加 ## 修正内容 ### 1. `getKanjiReading`: 接頭辞除去の追加 「お寺(おてら)」のような単語で、先頭の「お… (source: PR #17)
- [2026-03-08] feat: sentenceモードを穴埋め形式に改善（ふりがな付き・漢字空欄化） -- ## Summary - 手本行に各漢字のふりがな（訓読み優先）を表示 - 練習行で対象漢字を空欄（グリッドライン付き書き取りマス）に置換 - ひらがな・カタカナ・句読点は練習行でもそのまま表示 Closes #9 ## Changes | File | Change | |------|--------| | `src/components/WritingGrid.tsx` | `SentenceGrid` に `targetKanji`/`furiganaMap`/`gr… (source: PR #16)
- [2026-03-08] feat: strokeOrderモードにふりがな・読み・例語を追加 -- ## Summary - 書き順モードのSVG横に音読み・訓読み・例語（ふりがな付き）を表示 - 既存のレイアウト計算（`cellSize + 6`）内に収まるコンパクトな表示 - biome-ignoreコメントの不正確な記述（DOMPurify→信頼済みソース）を修正 Closes #10 ## Changes - `src/components/print/StrokeOrderQuestion.tsx`: 画数表示エリアを拡張し、読み・例語情報を追加 - `e2e/`… (source: PR #15)
- [2026-03-08] feat: 読み書き統合モード（readingWriting）を新設 -- ## Summary - 1問の中で「読み→書き」を連続して行う新モード `readingWriting` を追加 - 上段に読み問題（漢字→読み）、下段に書き問題（ふりがな→漢字）を配置 - 既存の `ReadingQuestion` / `WritingQuestion` のパターンを組み合わせた `ReadingWritingQuestion` コンポーネントを新規作成 ## Changes | ファイル | 変更内容 | |---------|---------| |… (source: PR #14)
