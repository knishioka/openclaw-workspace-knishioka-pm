# ut-gymnastics Knowledge Base

## Overview

- Repo: knishioka/ut-gymnastics
- Description: 東大体操部OBホームページ
- Primary language (GitHub): TypeScript
- License: none
- Default branch: main
- Created: 2019-12-16
- Updated: 2026-04-15
- Collected: 2026-05-22

## Tech Stack

- package.json: present
- Dependencies (sample): @prisma/client, @sentry/nextjs, @tailwindcss/postcss, @tailwindcss/typography, @types/bcryptjs, @types/nodemailer, @uiw/react-md-editor, autoprefixer, bcryptjs, date-fns, jose, next
- Dev dependencies (sample): @babel/preset-env, @babel/preset-react, @babel/preset-typescript, @playwright/test, @swc/core, @swc/jest, @testing-library/jest-dom, @testing-library/react, @types/jest, @types/node, @types/react, @types/react-dom
- npm scripts (keys): build, dev, dev:local, lint, lint:fix, prepare, prisma:generate, prisma:migrate, prisma:pull, prisma:push, prisma:reset, prisma:studio, seed, seed:full, seed:users
- pyproject.toml: not found
- requirements.txt: not found

## Architecture / Patterns

- Runtime schema validation
- ORM-based persistence
- React/Next.js UI

## Tech Decisions (from PRs/commits)

- [2026-02-16] feat(news): ニュース記事にMarkdownエディタを統合 -- - ニュース詳細ページの `dangerouslySetInnerHTML` を `MarkdownRenderer` に置換し、XSS脆弱性(#125)を部分的に解消 - ニュース編集・新規作成フォームの `textarea` を `MarkdownEditor` に置換し、Markdownプレビュー・ツールバー・画像アップロード機能を提供 - CSSプロパティホワイトリストを実装し、既存HTML記事の `style` 属性との後方互換性を安全に確保 (source: PR #137)
- [2026-02-16] feat(boards): 掲示板にMarkdownエディタを統合 -- - 掲示板の投稿作成・編集・表示をプレーンテキストからMarkdownエディタ/レンダラーに移行 - MarkdownRendererに検索キーワードハイライト機能を追加（rehypeプラグイン方式） - 既存のプレーンテキスト投稿（28件）の改行をremark-breaksで完全保持 (source: PR #136)
- [2026-02-16] feat: コンテンツ画像アップロードAPI（Markdownエディタ用） -- - Markdownエディタ用のコンテンツ画像アップロードAPIを実装 - `POST /api/content/images` で画像アップロード、WebP変換、3サイズ生成 - `GET /api/images/content/{filename}` で画像配信（既存エンドポイント拡張） - pre-commitのESLint hookをESLint 9.x互換に修正 (source: PR #135)
- [2026-02-16] feat(ui): 安全なMarkdownRendererコンポーネントの作成 -- - `react-markdown` ベースの安全なMarkdownRendererコンポーネントを作成 - `rehype-sanitize` によるallowlistベースのXSS対策（script, iframe, event handler, javascript: URL等をブロック） - 既存HTMLコンテンツ（ニュース記事11件）、プレーンテキスト（改行保持）、Markdown（GFMテーブル含む）の3形式をサポート - 外部リンクの `target="_bla (source: PR #134)
- [2026-02-16] feat(ui): MarkdownEditorコンポーネントの作成 -- - `@uiw/react-md-editor` v4.xを使用したMarkdownエディタコンポーネントを新規作成 - dynamic importによるSSRエラー回避・バンドルサイズ最適化 - Error Boundary、画像アップロードハンドラー、ローディングスケルトン等を実装 (source: PR #133)
- [2026-02-15] refactor(performance): optimize Prisma queries and suspense boundaries -- ## Summary This PR resolves Issue #115 by reducing redundant database access and expanding Suspense/cache boundaries on performance-sensitive pages and API routes. It removes repeated Prisma role lookups by reusing `session.role`, optimizes (source: PR #126)
