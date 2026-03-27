# math-worksheet Knowledge Base

## Overview

- Repo: knishioka/math-worksheet
- Primary language (GitHub): TypeScript
- License: none
- Default branch: main
- Created: 2025-06-09
- Updated: 2026-03-22
- Collected: 2026-03-27

## Tech Stack

- package.json: present
- Dependencies (sample): pdfmake, react, react-dom, react-to-print, zustand
- Dev dependencies (sample): @eslint/js, @playwright/test, @testing-library/jest-dom, @testing-library/react, @testing-library/user-event, @types/node, @types/pdfmake, @types/react, @types/react-dom, @vitejs/plugin-react, @vitest/ui, autoprefixer
- npm scripts (keys): build, check:layout, check:layout:local, deploy, dev, format, format:check, lint, preview, test, test:coverage, test:ui, typecheck
- pyproject.toml: not found
- requirements.txt: not found

## Architecture / Patterns

- React/Next.js UI

## Tech Decisions (from PRs/commits)

- [2026-03-22] feat: 1年生向け入門計算パターン5種を追加 -- ## Summary - 小さい子向けのより簡単な計算問題パターン5種を1年生に追加 - **+1のたし算** / **+2のたし算**: 固定値を足すシンプルな計算 - **かずをかぞえよう**: ○や★などのシンボルを数える問題 - **○をつかったたし算**: 2グループのシンボルを合わせる - **○をつかったひき算**: シンボルから取り除いた残りを答える - シンボルは20px・5個ごとに改行で視認性を確保 - `PATTERN_COUNT_OVERRIDES`で (source: PR #46)
- [2026-03-07] refactor: pattern-generators.ts を学年・カテゴリ別ファイルに分割 -- - `src/lib/generators/pattern-generators.ts` (2,776行) を10ファイルに分割 - `src/lib/generators/patterns/` ディレクトリを新設 - 公開インターフェースは変更なし（`index.ts` の import 2行のみ変更） (source: PR #44)
- [2026-03-07] chore: Playwright MCPを復活させ playwright-cli の使い分けを整理する -- - Playwright MCP は `.mcp.json` に既に設定済みであることを確認 - `scripts/check-print-layout.mjs` は CI/ローカル向け自動チェックとして維持 - CLAUDE.md の「Playwright CLIによるレイアウト確認」セクションを「レイアウト確認」に改名し、2ツールの使い分けを明記 (source: PR #43)
- [2026-03-07] feat(url): URLで問題設定を直接指定できるようにする -- - URLクエリパラメータで問題設定を直接指定可能に（`?grade=4&type=basic&pattern=add-single-digit&cols=2&count=10`） - Zustand `persist` ミドルウェア（localStorage）を削除し、URLを唯一の状態源に変更 - 不正なURLパラメータはデフォルト値にフォールバック、`problemCount`はテンプレート上限でクランプ (source: PR #38)
- [2026-03-06] fix(anzan): add anzan print template to prevent PDF overflow -- - **Root cause**: `anzan-pair-sum` and other anzan patterns used the `basic` template (`minProblemHeight: 40px`), causing PDFs to render as 2 pages (measured 1489px vs A4's 1123px) - Add `'anzan'` ProblemType with dedicated print template ( (source: PR #34)
- [2026-03-06] feat(anzan): implement sequential calculation and mixed mental math patterns -- ## Summary - Implement 3 new anzan (mental math) patterns: pair-sum, reorder, and mixed - Extend `BasicProblem` type with multi-operand support - Update rendering for multi-operand expressions (source: PR #33)
