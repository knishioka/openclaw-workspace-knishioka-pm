# ut-gymnastics Knowledge Base

## Overview

- Repo: knishioka/ut-gymnastics
- Description: 東大体操部OBホームページ
- Primary language (GitHub): TypeScript
- Category / Priority: web / low
- Status: active
- License: none
- Default branch: main
- Created: 2019-12-16
- Updated: 2026-04-15
- Collected: 2026-04-17

## Tech Stack

- package.json: present
- Dependencies (sample): @prisma/client, @sentry/nextjs, @tailwindcss/postcss, @tailwindcss/typography, @types/bcryptjs, @types/nodemailer, @uiw/react-md-editor, autoprefixer, bcryptjs, date-fns, jose, next
- Dev dependencies (sample): @babel/preset-env, @babel/preset-react, @babel/preset-typescript, @playwright/test, @swc/core, @swc/jest, @testing-library/jest-dom, @testing-library/react, @types/jest, @types/node, @types/react, @types/react-dom
- npm scripts (keys): build, dev, dev:local, lint, lint:fix, prepare, prisma:generate, prisma:migrate, prisma:pull, prisma:push, prisma:reset, prisma:studio
- pyproject.toml: not found
- requirements.txt: not found
- README signal: # 東大体操部OB・OG会 Webサイト 東京大学体操部OB・OG会の公式ウェブサイトです。Next.js 14とTypeScriptで構築されています。 ## 🚀 クイックスタート ### 開発環境のセットアップ ```bash # 1. リポジトリのクローン git clone git@github.com:knishioka/ut-gymnastics.git cd ut-gymnastics # 2. 依存関係のインストール npm install # 3. 環境変数の設定 cp .env.example…

## Architecture / Patterns

- TypeScript application with repo-specific automation around its core domain
- Incremental automation-oriented architecture inferred from recent commits and README

## Competitive Landscape (notes)

No fresh competitive research in this run.

## Tech Decisions (from PRs/commits)

- [2026-04-15] fix(nginx): server_name 修正 + ACME challenge 追加（証明書失効対応） -- ## Problem 本番サイト https://ob.todai-kunstturnen.net が Chrome で `NET::ERR_CERT_DATE_INVALID`。Let's Encrypt 証明書が 2026-03-19 に失効していた。certbot renew も 502 で失敗。 ## Root cause `nginx/nginx.conf` がテンプレートのプレースホルダのまま運用されていた: - `server_name your-domain.com www.your-domain… (source: PR #148)
- [2026-04-15] fix(security): npm audit fix で high 脆弱性を解消 (#146) -- ## Summary - `npm audit fix` により依存ツリー内の high 脆弱性をすべて解消 - Security Scan workflow (`npm audit --audit-level high`) が green になる見込み - `package.json` は変更なし、`package-lock.json` のみ更新（非破壊） Closes #146 ## 修正内容 `npm audit fix` (非 `--force`) のみで解消: | パッケージ | Severity | … (source: PR #147)
- [2026-03-08] chore: Node.jsバージョンを22 LTSに統一 -- ## Summary - Node.jsバージョンを全箇所で22 LTS (Active LTS) に統一 - 変更前: .nvmrc=20, Dockerfile=20, CI=25, security.yml=20, pre-commit=20 - 変更後: すべて22に統一 ## 変更箇所 | ファイル | 変更前 | 変更後 | |---|---|---| | `.nvmrc` | 20 | 22 | | `package.json` engines | >=20.0.0 | >=22.0.0 | | `… (source: PR #145)
- [2026-02-17] fix(news): HTMLレンダリング修正と作成者変更機能を追加 -- ## Summary - インデント付き生HTMLコンテンツがMarkdownのコードブロックとして表示される問題を修正（`/news/OBOG2024` 等） - ニュース記事の作成者(author)を編集・作成フォームから変更できるドロップダウンを追加 - PUT/POST APIに `author_id` パラメータを追加 ## Test plan - [ ] `/news/OBOG2024` 記事でHTMLが正常にレンダリングされることを確認 - [ ] 通常のMarkdown記事が影響を受けないことを確… (source: PR #144)
- [2026-02-17] docs: CLAUDE.md スリム化と .claude/rules/ 分離 -- ## Summary - CLAUDE.md が235行に肥大化し AI向けルール・人間向け手順・ゴッチャが混在していたのを整理 - Claude Code ベストプラクティスに従い、パス固有のドメイン知識を `.claude/rules/` に分離 - 古い一回限りドキュメントを削除し、壊れたリンクを修正 ## 変更内容 ### 新規: `.claude/rules/` (4ファイル) | ファイル | 対象パス | 内容 | |---------|---------|------| | `nextjs.md`… (source: PR #143)
- [2026-02-17] feat(security): nginxレート制限の実装（DDoS対策） -- ## Summary - Issue #56 に基づき、nginxレート制限によるDDoS・ブルートフォース対策を実装 - 7つのレート制限ゾーンをエンドポイント種別ごとに定義 - 認証系エンドポイントに厳格な制限（1r/m）、一般APIに適切な制限（5r/s） ## 変更内容 ### nginx/nginx.conf - **レート制限ゾーン定義**: general, api, login, password_reset, upload, search, static の7ゾーン - **認証エンドポイント保… (source: PR #142)
- [2026-02-17] security(nginx): セキュリティヘッダーの強化 -- ## Summary - nginxセキュリティヘッダーを強化し、OWASP推奨に準拠 - `nginx/security-headers.conf`に設定を分離してメンテナンス性向上 - Next.js側にも同等のヘッダーを設定（バックアップ層） - E2Eテストでヘッダー設定を検証 ## Changes ### nginx/security-headers.conf (新規) - `X-Frame-Options: DENY` - クリックジャッキング完全防止 - `X-Content-Type-Option… (source: PR #141)
- [2026-02-17] test: 既存データの互換性テスト(Markdownエディタ移行) -- ## Summary - MarkdownRendererコンポーネントとHTMLサニタイズユーティリティを作成し、既存データの互換性テストスイートを実装 - ユニットテスト56件（XSS防止14ベクター含む）、E2Eテスト7シナリオ、Admin検証ページを追加 - `sanitize-html`, `marked` 依存追加、pre-commit ESLint hook修正 ## Changes ### 新規ファイル | ファイル | 内容 | |---------|------| | `lib/sanitiz… (source: PR #140)
