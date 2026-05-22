# ut-gymnastics Design Decisions

## 2026-02-16: feat(news): ニュース記事にMarkdownエディタを統合

- **What**: feat(news): ニュース記事にMarkdownエディタを統合
- **Why**: - ニュース詳細ページの `dangerouslySetInnerHTML` を `MarkdownRenderer` に置換し、XSS脆弱性(#125)を部分的に解消 - ニュース編集・新規作成フォームの `textarea` を `MarkdownEditor` に置換し、Markdownプレビュー・ツールバー・画像アップロード機能を提供 - CSSプロパティホワイトリストを実装し、既存HTML記事の `style` 属性との後方互換性を安全に確保
- **Source**: PR #137

## 2026-02-16: feat(boards): 掲示板にMarkdownエディタを統合

- **What**: feat(boards): 掲示板にMarkdownエディタを統合
- **Why**: - 掲示板の投稿作成・編集・表示をプレーンテキストからMarkdownエディタ/レンダラーに移行 - MarkdownRendererに検索キーワードハイライト機能を追加（rehypeプラグイン方式） - 既存のプレーンテキスト投稿（28件）の改行をremark-breaksで完全保持
- **Source**: PR #136

## 2026-02-16: feat: コンテンツ画像アップロードAPI（Markdownエディタ用）

- **What**: feat: コンテンツ画像アップロードAPI（Markdownエディタ用）
- **Why**: - Markdownエディタ用のコンテンツ画像アップロードAPIを実装 - `POST /api/content/images` で画像アップロード、WebP変換、3サイズ生成 - `GET /api/images/content/{filename}` で画像配信（既存エンドポイント拡張） - pre-commitのESLint hookをESLint 9.x互換に修正
- **Source**: PR #135

## 2026-02-16: feat(ui): 安全なMarkdownRendererコンポーネントの作成

- **What**: feat(ui): 安全なMarkdownRendererコンポーネントの作成
- **Why**: - `react-markdown` ベースの安全なMarkdownRendererコンポーネントを作成 - `rehype-sanitize` によるallowlistベースのXSS対策（script, iframe, event handler, javascript: URL等をブロック） - 既存HTMLコンテンツ（ニュース記事11件）、プレーンテキスト（改行保持）、Markdown（GFMテーブル含む）の3形式をサポート - 外部リンクの `target="_bla
- **Source**: PR #134

## 2026-02-16: feat(ui): MarkdownEditorコンポーネントの作成

- **What**: feat(ui): MarkdownEditorコンポーネントの作成
- **Why**: - `@uiw/react-md-editor` v4.xを使用したMarkdownエディタコンポーネントを新規作成 - dynamic importによるSSRエラー回避・バンドルサイズ最適化 - Error Boundary、画像アップロードハンドラー、ローディングスケルトン等を実装
- **Source**: PR #133

## 2026-02-15: refactor(performance): optimize Prisma queries and suspense boundaries

- **What**: refactor(performance): optimize Prisma queries and suspense boundaries
- **Why**: ## Summary This PR resolves Issue #115 by reducing redundant database access and expanding Suspense/cache boundaries on performance-sensitive pages and API routes. It removes repeated Prisma role lookups by reusing `session.role`, optimizes
- **Source**: PR #126
