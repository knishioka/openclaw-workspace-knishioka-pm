# kanji-practice Knowledge Base

## Overview

- Repo: knishioka/kanji-practice
- Description: 小学1〜6年生向け漢字練習プリント作成ツール（A4印刷対応、PDF出力）
- Primary language (GitHub): TypeScript
- License: none
- Default branch: main
- Created: 2025-12-30
- Updated: 2026-05-14
- Collected: 2026-06-12

## Tech Stack

- package.json: present
- Dependencies (sample): @radix-ui/react-checkbox, @radix-ui/react-select, @radix-ui/react-slider, clsx, dompurify, html2canvas, jspdf, react, react-dom, react-to-print, zustand
- Dev dependencies (sample): @biomejs/biome, @playwright/test, @tailwindcss/vite, @types/dompurify, @types/node, @types/react, @types/react-dom, @vitejs/plugin-react, @vitest/ui, husky, lint-staged, tailwindcss
- npm scripts (keys): build, check, check:fix, dev, format, lint, lint:fix, prepare, preview, test, test:debug, test:ui, test:unit, test:unit:ui, test:unit:watch
- pyproject.toml: not found
- requirements.txt: not found

## Architecture / Patterns

- React/Next.js UI

## Tech Decisions (from PRs/commits)

- [2026-04-20] feat: 学習プリセット（9級読み・9級書き取り・8級先取り）を追加 -- ## Summary - add learning preset definitions plus pure apply/match helpers for the three learner flows - add a learning preset selector to the settings panel while keeping existing manual controls intact - add unit tests covering preset def (source: PR #26)
- [2026-04-12] fix: 写経モードのふりがなをルビ注釈方式でゼロフォールバック化 -- 写経モードの例文ふりがなが「フォールバック」推測に依存しており、活用形・音訓選択を誤った読み（例: `何の用？` → `なにのもちいる`）が大量に出ていた問題を根本解決。 (source: PR #24)
- [2026-04-11] feat: a11y改善（lang=ja / slider aria-label / 選択状態 / skip link） -- - `<html lang="en">` → `<html lang="ja">` に修正（日本語UIに適切な言語属性） - ページ数・練習マス数・マスサイズの各rangeスライダーに `aria-label` を付与 - 学年選択・プリント種類・ガイドラインのトグルボタンに `aria-pressed` 属性を追加 - Skip link（設定へスキップ / プレビューへスキップ）を追加し、キーボードユーザーの操作性を向上 (source: PR #23)
- [2026-04-11] fix: ページ数が問題生成後にリセットされる問題を修正 -- ## Summary - 問題生成ロジックが`App.tsx`と`SettingsPanel`に重複していた構造を一元化 - `App.tsx`の重複ロジック（`excludedKanji`未対応）を削除し、storeの`regenerate`アクション経由に変更 - `partialize`で一時的データ（`questions`, `generationCounter`）の永続化を除外 (source: PR #22)
- [2026-03-22] fix: ふりがなフォールバックの送りがな・熟語コンテキスト改善 -- - フォールバック時に辞書形の送りがな込み読みがそのまま付く問題を修正（例: 速く→速(はやい)を速(はや)に） - `okuriganaExamples` の語幹データを活用して送りがな部分を除去 - 隣接する未割り当て漢字がある場合、音読みを優先する熟語コンテキスト判定を追加 - 不足していた例語データ（気持ち、試合、田植え）を追加 (source: PR #19)
- [2026-03-09] fix: 3モードの問題間マージン最適化で問題数増加 -- - sentence(例文写経)、homophone(同音異字)、readingWriting(読み書き統合)の3モードで問題間マージンを最適化 - 各モード+1問/ページ: sentence 4→5問、homophone 5→6問、readingWriting 5→6問 - A4ページ内の余白(22〜30mm)を有効活用し、印刷効率を向上 (source: PR #18)

## Competitive Landscape

- [2026-06-12] Kanji learning products continue to split between SRS-first study systems and writing-first practice. Ringotan positions itself around handwriting detection plus SRS, while Kanji Study combines SRS, flashcards, quizzes, writing challenges, and custom sets. Feature candidate: keep the printable worksheet strength, but add optional SRS export/import metadata so generated sheets can follow a review schedule instead of being one-off PDFs. Sources: Google Play Ringotan (updated 2025-11-17), Google Play Kanji Study (accessed 2026-06-12).
- [2026-06-12] Recent Japanese-learning app roundups emphasize tool rotation by skill bottleneck rather than one app for everything, with Renshuu-style customizable paths and WaniKani/Bunpro-style specialized flows still prominent. Feature candidate: learner presets should evolve into named study paths with clear bottlenecks (write, read, homophones, sentence copywork) rather than generic grade selectors only. Sources: Class Central Japanese apps report (2026-06-10), Clozemaster Japanese apps report (2026-03).
