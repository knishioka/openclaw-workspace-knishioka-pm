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
- Updated: 2026-05-02
- Collected: 2026-05-08

## Tech Stack

- package.json: present
- Dependencies (sample): @radix-ui/react-checkbox, @radix-ui/react-select, @radix-ui/react-slider, clsx, dompurify, html2canvas, jspdf, react, react-dom, react-to-print, zustand
- Dev dependencies (sample): @biomejs/biome, @playwright/test, @tailwindcss/vite, @types/dompurify, @types/node, @types/react, @types/react-dom, @vitejs/plugin-react, @vitest/ui, husky, lint-staged, tailwindcss
- npm scripts (keys): build, check, check:fix, dev, format, lint, lint:fix, prepare, preview, test, test:debug, test:ui, test:unit, test:unit:ui, test:unit:watch
- pyproject.toml: not found
- requirements.txt: not found
- README signal: # 漢字練習プリント [![GitHub Pages](https://img.shields.io/badge/Demo-GitHub%20Pages-blue?logo=github)](https://knishioka.github.io/kanji-practice/) [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT) 小学1〜6年生向け（漢検10級〜5級対応）の漢字練習プリント作

## Architecture / Patterns

- Print-first worksheet generator optimized for A4/PDF browser output
- Preset/config-driven content generation with browser preview before export
- Learning-content rendering that balances pedagogy, layout density, and accessibility

## Competitive Landscape (notes)

[2026-04-24] 教育トレンド: spaced / interleaved / retrieval practice は、短い確認を時間差で繰り返す設計が定着に効くと整理されている。漢字プリントでは単発生成だけでなく、前回学習を混ぜた復習プリセットの価値が高い。 (refs: https://www.mathematicshub.edu.au/plan-teach-and-assess/teaching/teaching-strategies/spaced-interleaved-and-retrieval-practice/ , https://www.carnegielearning.com/blog/retrieval-practice-guide-download)
[2026-04-24] 直近の実装で学習プリセットが入ったため、次の差別化ポイントは「習熟の流れ」をプリセットに閉じ込めること。9級読み→9級書き取り→8級先取りの固定選択だけでなく、日次の cumulative review を自動構成できると教材として一段強くなる。 (source: repo PR #26 + refs above)
[2026-05-08] Education trend: Khan Academy's Khanmigo Interests emphasizes learner-specific personalization based on saved interests, reinforcing that engagement is shifting from static practice sheets to context-aware practice experiences. kanji-practice is print-first today, but even lightweight personalization like student goal presets or favorite-theme sentence pools would align with the direction without abandoning printable UX. (source: Khan Academy, "New! Personalized AI Learning with Khanmigo Interests", 2025-03-21; fetched 2026-05-08)
[2026-05-08] Competitive implication: worksheet tools increasingly need a bridge between reusable teacher defaults and learner-level personalization. A strong next step is shareable study profiles that bundle grade, target set, review cadence, and sentence difficulty into one printable link. (source: Khan Academy personalization article above + existing repo preset/link-sharing direction)

Potential feature candidates for this repo:
- Add **shareable study profiles** that package grade, preset, review cadence, and sentence difficulty into one reusable printable link.
- Add **student-interest sentence packs** so the same kanji set can be practiced with context that matches the learner's hobbies or current topic.
- Add **cumulative review presets** that automatically mix current-grade kanji with recently learned items for spaced retrieval.

## Tech Decisions (from PRs/commits)

- [2026-05-02] feat: harness pack (AGENTS.md / verify.sh / PR template) — Phase B PoC -- knishioka/openclaw-workspace-knishioka-pm#21 (Phase B PoC) の harness pack を kanji-practice に配備する。 (source: PR #32)
- [2026-04-25] feat: 例文写経の練習行を全マス書き取り対象に -- 例文写経モードの練習行はこれまで「ターゲット漢字のセルだけ書き取り用の白マス、それ以外は薄字の固定文字を表示（読む対象）」という構成だった。 (source: PR #30)
- [2026-04-25] feat: 例文写経モードの練習行数を可変化（デフォルト2行・最大3行） -- 例文写経モード（PrintMode='sentence'）は従来「お手本1行 + 練習1行」の固定構成で、同じ例文を 1 回しか書写できなかった。学習理論上、写経による定着には 2〜3 回の反復が効果的（.claude/rules/education/learning-theory.md）。本 PR は A4 1 ページに最低 2 問が収まる制約を保ったまま、例文の繰り返し書写を可能にする。 (source: PR #29)
- [2026-04-24] fix: Klee Oneフォントをindex.htmlのlinkタグで読み込む（#27の修正） -- PR #27 で src/index.css に @import url(...) で Klee One を読み込んだが、CSS 仕様上 @import は他のすべてのルールより前に配置されている必要があり、@import "tailwindcss" の後ろに書かれていたため**本番で無効化**されていた。 (source: PR #28)
- [2026-04-24] fix: 教科書体フォント(Klee One)をWebフォントとして読み込む -- 漢字練習プリントの漢字がゴシック体で表示される問題を修正。.font-textbook クラスは Klee One を local() のみで指定していたため、フォント未インストール環境（多くの macOS 標準環境含む）では serif フォールバックや OS 標準フォントに落ち、教科書体になっていなかった。 (source: PR #27)
- [2026-04-20] feat: 学習プリセット（9級読み・9級書き取り・8級先取り）を追加 -- add learning preset definitions plus pure apply/match helpers for the three learner flows add a learning preset selector to the settings panel while keeping existing manual controls intact add unit tests covering preset defaults, active-state detection, and ex (source: PR #26)
- [2026-04-12] fix: 写経モードのふりがなをルビ注釈方式でゼロフォールバック化 -- 写経モードの例文ふりがなが「フォールバック」推測に依存しており、活用形・音訓選択を誤った読み（例: 何の用？ → なにのもちいる）が大量に出ていた問題を根本解決。 (source: PR #24)
- [2026-04-11] feat: a11y改善（lang=ja / slider aria-label / 選択状態 / skip link） -- 、キーボードユーザーの操作性を向上 Closes #21 [x] TypeScript型チェック通過 [x] Biome lint/format チェック通過 [x] ユニットテスト 256件全パス [ ] ブラウザでTabキー操作を確認し、Skip linkが表示されることを検証 [ ] スクリーンリーダーでスライダーのラベルが読み上げられることを確認 [ ] 学年/モード変更時に aria-pressed の値が正しく切り替わることを確認 [ ] 印刷プレビュー/PDF生成に影響がないことを確認 🤖 Gen... (source: PR #23)
