# english-note-maker Knowledge Base

## Overview

- Repo: knishioka/english-note-maker
- Description: 英語罫線ノート作成ウェブアプリ - 美しいアルファベット練習用の4本線ノートを作成できるツール
- Primary language (GitHub): JavaScript
- License: none
- Default branch: main
- Created: 2025-06-18
- Updated: 2026-05-04
- Collected: 2026-05-22

## Tech Stack

- package.json: present
- Dependencies (sample): puppeteer
- Dev dependencies (sample): @eslint/js, @playwright/test, @types/jsdom, @types/node, @vitejs/plugin-legacy, @vitest/ui, eslint, html-validate, http-server, husky, jsdom, lint-staged
- npm scripts (keys): build, build:prod, clean, debug:layout, debug:open, debug:stats, dev, dev:legacy, format, lint, lint:fix, prepare, preview, server:check, test
- pyproject.toml: not found
- requirements.txt: not found

## Architecture / Patterns

- Document/PDF generation

## Tech Decisions (from PRs/commits)

- [2026-04-11] fix(cloze): increase questions per page and hide notice from print -- ## Summary - 穴埋め問題の1ページあたりの問題数を増加（上限4→10、練習行を2行→1行に削減、CSS gapを縮小） - `getClozeCapacity()` の計算を正確なレイアウト高さに基づくように修正 - 自動調整通知（`.auto-layout-notice`）が印刷時に表示されてA4からはみ出す問題を修正 (source: PR #21)
- [2026-04-11] feat(cloze): add fill-in-the-blank phrase practice mode -- ## Summary - Add new "穴埋めフレーズ練習" (cloze/fill-in-the-blank) practice mode with sight words and phonics support - Support two blank granularities: word-level (replace sight words) and character-level (phonics-targeted letter blanking) - Inclu (source: PR #20)
- [2025-11-12] Allow printing up to 20 pages -- - Update page count max from 5 to 20 in index.html - Update README.md to reflect new page limit (source: PR #18)
- [2025-11-12] Add more math problem types -- (Why not stated in PR/commit body) (source: PR #17)
- [2025-11-11] Set up Claude Code Web development -- - Add SessionStart hook for automatic dependency installation - Configure npm install with PUPPETEER_SKIP_DOWNLOAD for remote env - Install Playwright browsers for e2e testing - Only run hook in remote environment (Claude Code on the Web) - (source: PR #16)
- [2025-11-05] fix: keep phrase practice print within a4 -- (Why not stated in PR/commit body) (source: PR #15)
