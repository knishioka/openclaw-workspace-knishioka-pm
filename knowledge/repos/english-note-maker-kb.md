# english-note-maker Knowledge Base

## Overview

- Repo: knishioka/english-note-maker
- Description: 英語罫線ノート作成ウェブアプリ - 美しいアルファベット練習用の4本線ノートを作成できるツール
- Primary language (GitHub): JavaScript
- Category / Priority: education / low
- Status: active
- License: none
- Default branch: main
- Created: 2025-06-18
- Updated: 2026-04-16
- Collected: 2026-04-17

## Tech Stack

- package.json: present
- Dependencies (sample): puppeteer
- Dev dependencies (sample): @eslint/js, @playwright/test, @types/jsdom, @types/node, @vitejs/plugin-legacy, @vitest/ui, eslint, html-validate, http-server, husky, jsdom, lint-staged
- npm scripts (keys): build, build:prod, clean, debug:layout, debug:open, debug:stats, dev, dev:legacy, format, lint, lint:fix, prepare
- pyproject.toml: not found
- requirements.txt: not found
- README signal: # 英語罫線ノート作成ツール 英語の4本線ノートをブラウザ上で作成・印刷できる静的Webアプリケーションです。インターナショナルスクールに通う子どもたちが実用的な語彙とフレーズを学べるよう、豊富なコンテンツと自動レイアウト機能を備えています。 ## ライブデモとステータス - ライブデモ: [https://knishioka.github.io/english-note-maker/](https://knishioka.github.io/english-note-maker/) - ![GitHub Act…

## Architecture / Patterns

- Print-first worksheet generator optimized for A4 browser output
- Client-side generation flow with browser preview and printable layout calculations
- Lightweight browser app focused on printable learning artifacts

## Competitive Landscape (notes)

- No dedicated competitive / trend note recorded this week.

## Tech Decisions (from PRs/commits)

- [2026-04-16] feat: add phonics word-family practice mode -- Closes #22 ## Summary - add a phonics practice mode with selectable word-family patterns - render traceable baseline rows and pattern-aware word sequencing - add content, layout, and phonics data tests for the new mode (source: PR #23)
- [2026-04-11] fix(cloze): increase questions per page and hide notice from print -- ## Summary - 穴埋め問題の1ページあたりの問題数を増加（上限4→10、練習行を2行→1行に削減、CSS gapを縮小） - `getClozeCapacity()` の計算を正確なレイアウト高さに基づくように修正 - 自動調整通知（`.auto-layout-notice`）が印刷時に表示されてA4からはみ出す問題を修正 ## Test plan - [x] ユニットテスト 118件パス - [x] E2Eテスト（cloze） 30件パス - [ ] ブラウザで穴埋めモードを選択し、問題数が増えている… (source: PR #21)
- [2026-04-11] feat(cloze): add fill-in-the-blank phrase practice mode -- ## Summary - Add new "穴埋めフレーズ練習" (cloze/fill-in-the-blank) practice mode with sight words and phonics support - Support two blank granularities: word-level (replace sight words) and character-level (phonics-targeted letter blanking) - Include answer key with … (source: PR #20)
- [2025-11-12] Allow printing up to 20 pages -- - Update page count max from 5 to 20 in index.html - Update README.md to reflect new page limit 🤖 Generated with [Claude Code](https://claude.ai/code) (source: PR #18)
- [2025-11-12] Add more math problem types --  (source: PR #17)
- [2025-11-11] Set up Claude Code Web development -- - Add SessionStart hook for automatic dependency installation - Configure npm install with PUPPETEER_SKIP_DOWNLOAD for remote env - Install Playwright browsers for e2e testing - Only run hook in remote environment (Claude Code on the Web) - Add .claude/settin… (source: PR #16)
- [2025-11-05] fix: keep phrase practice print within a4 --  (source: PR #15)
- [2025-11-05] fix: auto-adjust layouts to fit a4 output -- ## 背景 - 既存の警告表示だけでは実際のPDF出力でA4外にはみ出すケースが解消されず、利用者が都度ページ数や項目数を手動調整する必要があった - レイアウト診断で検出した問題をフロー内で即座に解消し、印刷プレビューの段階で安定したA4収まりを保証する仕組みが求められていた - HTML の構造不備がCIでのみ検知される状態だったため、ローカル段階で同じ品質チェックを実施できるよう整備したい ## 対応内容 - プレビュー生成処理を再構成し、各モードの最大行数・項目数を共通的に算出 → A4高さを超えている場… (source: PR #14)
