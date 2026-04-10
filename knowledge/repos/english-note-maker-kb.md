# english-note-maker Knowledge Base

## Overview

- Repo: knishioka/english-note-maker
- Description: 英語罫線ノート作成ウェブアプリ - 美しいアルファベット練習用の4本線ノートを作成できるツール
- Primary language (GitHub): JavaScript
- Category / Priority: education / low
- License: none
- Default branch: main
- Created: 2025-06-18
- Updated: 2026-01-01
- Collected: 2026-04-10

## Tech Stack

- package.json: present
- Dependencies (sample): puppeteer
- Dev dependencies (sample): @eslint/js, @playwright/test, @types/jsdom, @types/node, @vitejs/plugin-legacy, @vitest/ui, eslint, html-validate, http-server, husky, jsdom, lint-staged
- npm scripts (keys): build, build:prod, clean, debug:layout, debug:open, debug:stats, dev, dev:legacy, format, lint, lint:fix, prepare
- pyproject.toml: not found
- requirements.txt: not found
- README signal: # 英語罫線ノート作成ツール 英語の4本線ノートをブラウザ上で作成・印刷できる静的Webアプリケーションです。インターナショナルスクールに通う子どもたちが実用的な語彙とフレーズを学べるよう、豊富なコンテンツと自動レイアウト機能を備えています。 ## ライブデモとステータス - ライブデモ: [https://knishioka.github.io/english-note-maker/](https://knishioka.github…

## Architecture / Patterns

- Client-side printable practice sheet generator
- Layout-tuned print rendering with page-fit constraints
- Simple single-purpose web app architecture

## Competitive Landscape (notes)

- No dedicated competitive / trend note recorded this week.

## Tech Decisions (from PRs/commits)

- [2025-11-12] Allow printing up to 20 pages -- - Update page count max from 5 to 20 in index.html - Update README.md to reflect new page limit 🤖 Generated with [Claude Code](https://claude.ai/code) (source: PR #18)
- [2025-11-12] Add more math problem types (source: PR #17)
- [2025-11-11] Set up Claude Code Web development -- - Add SessionStart hook for automatic dependency installation - Configure npm install with PUPPETEER_SKIP_DOWNLOAD for remote env - Install Playwright browsers for e2e testing - Only run hook in remote environment (Claude Code on the Web) -… (source: PR #16)
- [2025-11-05] fix: keep phrase practice print within a4 (source: PR #15)
- [2025-11-05] fix: auto-adjust layouts to fit a4 output -- ## 背景 - 既存の警告表示だけでは実際のPDF出力でA4外にはみ出すケースが解消されず、利用者が都度ページ数や項目数を手動調整する必要があった - レイアウト診断で検出した問題をフロー内で即座に解消し、印刷プレビューの段階で安定したA4収まりを保証する仕組みが求められていた - HTML の構造不備がCIでのみ検知される状態だったため、ローカル段階で同じ品質チェックを実施できるよう整備したい ## 対応内容 - プレビュー生成処理を再構成し、各モードの最大行数・項目数を共… (source: PR #14)
- [2025-11-05] [fix] 印刷レイアウトの復旧と問題ページングの改善 -- ## 概要 - 印刷用CSSを統一設定に合わせて修正し、不要な要素が印刷される不具合を解消 - 例文・単語・フレーズのページングロジックを拡張し、複数ページ印刷時に各ページがA4サイズ内でユニークな内容になるよう調整 - フレーズ練習の表示件数を行高に応じて制限し、キャッシュをリセットするイベント処理を追加 ## テスト - `npm run test` - `npm run lint` ------ https://chatgpt.com/codex/tasks/task_… (source: PR #13)
