# kanji-practice Knowledge Base

## Overview

- Repo: knishioka/kanji-practice
- Description: 小学1〜6年生向け漢字練習プリント作成ツール（A4印刷対応、PDF出力）
- Primary language (GitHub): TypeScript
- License: none
- Default branch: main
- Created: 2025-12-30
- Updated: 2026-05-14
- Collected: 2026-05-29

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

- [2026-05-14] feat(print): customize first page header fields -- 1ページ目ヘッダーの名前欄・日付欄について、表示/非表示とラベル文言を設定パネルから変更できるようにしました。既存設定ロード時はデフォルト値を migration で補完し、2ページ目以降のヘッダー表示は従来どおり維持しています。 (source: PR #34)
- [2026-05-02] feat: harness pack (AGENTS.md / verify.sh / PR template) — Phase B PoC -- knishioka/openclaw-workspace-knishioka-pm#21 (Phase B PoC) の harness pack を kanji-practice に配備する。 workspace 側で整備した SSOT テンプレ (AGENTS.md / PR template / verify.sh) を本リポに写し、 Codex auto-resolve の振る舞い検証用に最初の運用リポにする。 (source: PR #32)
- [2026-04-25] feat: 例文写経の練習行を全マス書き取り対象に -- 例文写経モードの練習行はこれまで「ターゲット漢字のセルだけ書き取り用の白マス、それ以外は薄字の固定文字を表示（読む対象）」という構成だった。 しかし例文には対象漢字以外にも漢字・ひらがな・カタカナが含まれており、これらもついでに書写練習できれば、1問あたりの運筆練習量を大幅に増やせる。 (source: PR #30)
- [2026-04-25] feat: 例文写経モードの練習行数を可変化（デフォルト2行・最大3行） -- 例文写経モード（PrintMode='sentence'）は従来「お手本1行 + 練習1行」の固定構成で、同じ例文を 1 回しか書写できなかった。学習理論上、写経による定着には 2〜3 回の反復が効果的（`.claude/rules/education/learning-theory.md`）。本 PR は A4 1 ページに最低 2 問が収まる制約を保ったまま、例文の繰り返し書写を可能にする。 (source: PR #29)
- [2026-04-24] fix: Klee Oneフォントをindex.htmlのlinkタグで読み込む（#27の修正） -- PR #27 で `src/index.css` に `@import url(...)` で Klee One を読み込んだが、CSS 仕様上 `@import` は他のすべてのルールより前に配置されている必要があり、`@import "tailwindcss"` の後ろに書かれていたため**本番で無効化**されていた。 (source: PR #28)
- [2026-04-24] fix: 教科書体フォント(Klee One)をWebフォントとして読み込む -- 漢字練習プリントの漢字がゴシック体で表示される問題を修正。`.font-textbook` クラスは Klee One を `local()` のみで指定していたため、フォント未インストール環境（多くの macOS 標準環境含む）では `serif` フォールバックや OS 標準フォントに落ち、教科書体になっていなかった。 (source: PR #27)
