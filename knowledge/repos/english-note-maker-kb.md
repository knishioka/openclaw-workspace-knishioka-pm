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
- Updated: 2026-05-04
- Collected: 2026-05-08

## Tech Stack

- package.json: present
- Dependencies (sample): puppeteer
- Dev dependencies (sample): @eslint/js, @playwright/test, @types/jsdom, @types/node, @vitejs/plugin-legacy, @vitest/ui, eslint, html-validate, http-server, husky, jsdom, lint-staged
- npm scripts (keys): build, build:prod, clean, debug:layout, debug:open, debug:stats, dev, dev:legacy, format, lint, lint:fix, prepare, preview, server:check, test, test:content, test:coverage, test:e2e, test:headed, test:layout, test:ui, typecheck, validate
- pyproject.toml: not found
- requirements.txt: not found
- README signal: # 英語罫線ノート作成ツール 英語の4本線ノートをブラウザ上で作成・印刷できる静的Webアプリケーションです。インターナショナルスクールに通う子どもたちが実用的な語彙とフレーズを学べるよう、豊富なコンテンツと自動レイアウト機能を備えています。 ## ライブデモとステータス - ライブデモ: [https://knishioka.github.io/english-note-maker/](https://knishioka.github.io/english-note-maker/) - ![GitHub Actions Status](https://

## Architecture / Patterns

- Preset/config-driven content generation with browser preview before export
- Learning-content rendering that balances pedagogy, layout density, and accessibility
- Typed frontend/tooling workflow with npm-based build/test scripts

## Competitive Landscape (notes)

No competitive research captured yet.

Potential feature candidates for this repo:
- No candidates captured yet.

## Tech Decisions (from PRs/commits)

- [2026-05-04] fix(alphabet): use bundled tracing font -- 公開サイト https://knishioka.github.io/english-note-maker/ を Playwright で直接確認したところ、PR #33 は反映済みでしたが、OS フォントの Comic Sans MS 由来で大文字・単語の右傾きが残っていました。 (source: PR #34)
- [2026-05-04] fix(alphabet): refine lowercase tracing baseline position -- 公開後のスクリーンショット確認で、小文字なぞり書きの形は改善されている一方、a/apple/ant/b の薄字ガイドが4本線の基準線に対して少し低く、さらにフォント字形由来の右傾きも少し目立っていました。罫線高さやページ密度は変えず、小文字系ガイドの縦位置と、なぞり文字・英字ラベルの傾きを微調整します。 (source: PR #33)
- [2026-05-04] fix(alphabet): align tracing guides with handwriting lines -- アルファベットなぞり書きで、小文字や例示単語の薄字ガイドが手書き練習用の4本線に対してやや合っていなかったため、実表示を Playwright で確認しながら小文字・単語・罫線高さ別に調整しました。 (source: PR #32)
- [2026-05-04] fix(build): restore Vite and typecheck pipeline -- なぞり書きモードの小文字を手書き練習向けの字形に近づけ、あわせて npm run build を止めていた TypeScript / Vite 設定の問題を修正しました。 (source: PR #31)
- [2026-05-02] feat(alphabet): beginner-friendly tracing — non-italic, full-line, repeated horizontally -- Alphabet Practice のなぞり書きモードを初学者向けに改善します。実スクショで複数回イテレーションして仕上げました。 (source: PR #30)
- [2026-05-02] feat(alphabet): expand vocabulary and add tracing mode -- Alphabet Practice の余白問題と語彙不足を解消し、なぞり書き（トレース）モードを追加します。 (source: PR #29)
- [2026-04-25] feat(practice): apply paged dedup and difficulty presets to word/phrase/sentence -- Generalizes the cloze-mode improvements from #26 (within-page deduplication + age-driven difficulty presets) to the **word**, **phrase**, and **sentence** practice modes. (source: PR #28)
- [2026-04-25] fix(data): resolve near-duplicate phrases in classroom_english -- ループとほぼ同義のフレーズが含まれており、穴埋め演習で「同じ問題を 2 回解いている」感覚を与えていた 重複の強い 2 フレーズを差し替え、How / Why 疑問文を新規追加して文型バリエーションを拡充 7-9 のシンプル版は年齢相応として残し、10-12 側だけを置換 Closes #24 | Age Group | Before | After | 理由 | |-----------|--------|-------|------| | 10-12 | Could you explain that again? (source: PR #27)
