# english-note-maker Knowledge Base

## Overview

- Repo: knishioka/english-note-maker
- Description: English lined notebook creator web app
- Primary language (GitHub): JavaScript
- Category / Priority: education / low
- Status: active
- License: none
- Default branch: main
- Created: 2025-06-18
- Updated: 2026-05-04
- Collected: 2026-05-15

## Tech Stack

- Runtime dependencies: puppeteer
- Dev dependencies: @eslint/js, @playwright/test, @types/jsdom, @types/node, @vitejs/plugin-legacy, @vitest/ui, eslint, html-validate, http-server, husky, jsdom, lint-staged, live-server, prettier, typescript, vite, vitest
- npm scripts: build, build:prod, clean, debug:layout, debug:open, debug:stats, dev, dev:legacy, format, lint, lint:fix, prepare, preview, server:check, test, test:content, test:coverage, test:e2e, test:headed, test:layout
- pyproject.toml: not found
- requirements.txt: not found
- README signal: # 英語罫線ノート作成ツール 英語の4本線ノートをブラウザ上で作成・印刷できる静的Webアプリケーションです。インターナショナルスクールに通う子どもたちが実用的な語彙とフレーズを学べるよう、豊富なコンテンツと自動レイアウト機能を備えています。 ## ライブデモとステータス - ライブデモ: [https://knishioka.github.io/english-note-...

## Architecture / Patterns

- Browser/app code uses package-managed TypeScript/JavaScript workflow with explicit build/test scripts.
- Learning-content rendering balances pedagogy, layout density, and printable output constraints.
- Worksheet/problem generation is configuration-driven, with preview/verification loops used to catch A4 overflow.

## Competitive Landscape (notes)

No competitive research captured in this weekly rotation.

## Tech Decisions (from recent PRs/commits)

- [2026-05-04] fix(alphabet): use bundled tracing font -- ## 背景 公開サイト `https://knishioka.github.io/english-note-maker/` を Playwright で直接確認したところ、PR #33 は反映済みでしたが、OS フォントの `Comic Sans MS` 由来で大文字・単語の右傾きが残っていました。 また、PR #34 初版の `Chalkboard... (source: PR #34)
- [2026-05-04] fix(alphabet): refine lowercase tracing baseline position -- ## Summary 公開後のスクリーンショット確認で、小文字なぞり書きの形は改善されている一方、`a/apple/ant/b` の薄字ガイドが4本線の基準線に対して少し低く、さらにフォント字形由来の右傾きも少し目立っていました。罫線高さやページ密度は変えず、小文字系ガイドの縦位置と、なぞり文字・英字ラベルの傾きを微調整します。 ## Related... (source: PR #33)
- [2026-05-04] fix(alphabet): align tracing guides with handwriting lines -- ## Summary アルファベットなぞり書きで、小文字や例示単語の薄字ガイドが手書き練習用の4本線に対してやや合っていなかったため、実表示を Playwright で確認しながら小文字・単語・罫線高さ別に調整しました。 ## Related Issue Relates to #31... (source: PR #32)
- [2026-05-04] fix(build): restore Vite and typecheck pipeline -- ## Summary なぞり書きモードの小文字を手書き練習向けの字形に近づけ、あわせて `npm run build` を止めていた TypeScript / Vite 設定の問題を修正しました。 ## Related Issue 関連 Issue はありません。ユーザーからの直接依頼に基づく修正です。 ## Changes Made -... (source: PR #31)
- [2026-05-02] feat(alphabet): beginner-friendly tracing — non-italic, full-line, repeated horizontally -- ## Summary Alphabet Practice のなぞり書きモードを初学者向けに改善します。実スクショで複数回イテレーションして仕上げました。 ### 1. 薄字ガイドのフォント刷新 - `font-style: italic → normal` (Century Schoolbook 斜体は子供には読みづらかった) - `font-... (source: PR #30)
- [2026-05-02] feat(alphabet): expand vocabulary and add tracing mode -- ## Summary Alphabet Practice の余白問題と語彙不足を解消し、なぞり書き（トレース）モードを追加します。 - **データ拡張**: `ALPHABET_DATA` を `{ letter, words: [{english, japanese}, ...] }` 形式に変更し、各文字 3 語登録（合計 156 語）。 -... (source: PR #29)
- [2026-04-25] feat(practice): apply paged dedup and difficulty presets to word/phrase/sentence -- ## Summary Generalizes the cloze-mode improvements from #26 (within-page deduplication + age-driven difficulty presets) to the **word**, **phrase**, and **sentence** practice... (source: PR #28)
- [2026-04-25] fix(data): resolve near-duplicate phrases in classroom_english -- ## Summary - `classroom_english` カテゴリの 10-12 グループに、7-9 グループとほぼ同義のフレーズが含まれており、穴埋め演習で「同じ問題を 2 回解いている」感覚を与えていた - 重複の強い 2 フレーズを差し替え、`How` / `Why` 疑問文を新規追加して文型バリエーションを拡充 - 7-9... (source: PR #27)
