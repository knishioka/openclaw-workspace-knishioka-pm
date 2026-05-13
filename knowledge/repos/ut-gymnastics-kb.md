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
- Collected: 2026-05-08

## Tech Stack

- package.json: present
- Dependencies (sample): @prisma/client, @sentry/nextjs, @tailwindcss/postcss, @tailwindcss/typography, @types/bcryptjs, @types/nodemailer, @uiw/react-md-editor, autoprefixer, bcryptjs, date-fns, jose, next
- Dev dependencies (sample): @babel/preset-env, @babel/preset-react, @babel/preset-typescript, @playwright/test, @swc/core, @swc/jest, @testing-library/jest-dom, @testing-library/react, @types/jest, @types/node, @types/react, @types/react-dom
- npm scripts (keys): build, dev, dev:local, lint, lint:fix, prepare, prisma:generate, prisma:migrate, prisma:pull, prisma:push, prisma:reset, prisma:studio, seed, seed:full, seed:users, start, test, test:build, test:clean, test:e2e, test:unit, test:unit:coverage, test:unit:watch
- pyproject.toml: not found
- requirements.txt: not found
- README signal: # 東大体操部OB・OG会 Webサイト 東京大学体操部OB・OG会の公式ウェブサイトです。Next.js 14とTypeScriptで構築されています。 ## 🚀 クイックスタート ### 開発環境のセットアップ ```bash # 1. リポジトリのクローン git clone git@github.com:knishioka/ut-gymnastics.git cd ut-gymnastics # 2. 依存関係のインストール npm install # 3. 環境変数の設定 cp .env.example .env # プロジェクト共通の設定を

## Architecture / Patterns

- Content/site-oriented web app with deployable frontend surface
- UI-first architecture with reusable page/section components
- Operational patterns around hosting, certificates, and user-facing reliability

## Competitive Landscape (notes)

No fresh competitive research in this run.

Potential feature candidates for this repo:

- No candidates captured yet.

## Tech Decisions (from PRs/commits)

- [2026-04-15] fix(nginx): server_name 修正 + ACME challenge 追加（証明書失効対応） -- e your-domain.com www.your-domain.com; ← 未置換 HTTP block に /.well-known/acme-challenge/ の location がなく、webroot 検証が全リクエストを proxy に流して 502 これが scripts/production/deploy-nginx-config.sh 経由で /etc/nginx/sites-available/ut-gymnastics に配布されていた。listen 443 ssl がこの 1 b... (source: PR #148)
- [2026-04-15] fix(security): npm audit fix で high 脆弱性を解消 (#146) -- | パッケージ | Severity | Advisory | |---|---|---| | minimatch | high | GHSA-3ppc-4f35-3m26 / 7r86-cg39-jmmj / 23c5-xmqv-rm74 | | rollup | high | GHSA-mw96-cpmx-2vgc (Path Traversal) | | serialize-javascript (via terser-webpack-plugin) | high | GHSA-5c6j-r48x-rm... (source: PR #147)
- [2026-03-08] chore: Node.jsバージョンを22 LTSに統一 -- | >=20.0.0 | >=22.0.0 | | docker/Dockerfile | node:20-slim | node:22-slim | | docker/Dockerfile.production | node:20-alpine | node:22-alpine | | .github/workflows/ci.yml | 25 | 22 | | .github/workflows/security.yml | 20 | 22 | | .pre-commit-config.yaml | 20... (source: PR #145)
- [2026-02-17] fix(news): HTMLレンダリング修正と作成者変更機能を追加 -- インデント付き生HTMLコンテンツがMarkdownのコードブロックとして表示される問題を修正（/news/OBOG2024 等） ニュース記事の作成者(author)を編集・作成フォームから変更できるドロップダウンを追加 PUT/POST APIに author_id パラメータを追加 [ ] /news/OBOG2024 記事でHTMLが正常にレンダリングされることを確認 [ ] 通常のMarkdown記事が影響を受けないことを確認 [ ] 編集画面で作成者ドロップダウンが表示され、現在の作成者がデフォルト選択 (source: PR #144)
- [2026-02-17] docs: CLAUDE.md スリム化と .claude/rules/ 分離 -- --------|---------|------| | nextjs.md | app/**, components/** | Server/Client Component、Date型、Edge Runtime | | prisma.md | prisma/**, lib/prisma.ts | マイグレーションワークフロー、ポート番号 | | deployment.md | scripts/production/**, docker/**, nginx/** | デプロイ参照先、Docker/jqゴッチャ... (source: PR #143)
- [2026-02-17] feat(security): nginxレート制限の実装（DDoS対策） -- d_reset, upload, search, static の7ゾーン **認証エンドポイント保護**: /api/auth/login: 1r/m burst=2（ブルートフォース防止、遅延あり） /api/auth/signup: 1r/m burst=3（スパム登録防止） /api/auth/send-confirmation: 1r/m burst=2（メール濫用防止） /api/auth/password-reset: 1r/m burst=3（不正リセット防止） **リソース保護**: `/ap... (source: PR #142)
- [2026-02-17] security(nginx): セキュリティヘッダーの強化 -- リックジャッキング完全防止 X-Content-Type-Options: nosniff - MIMEスニッフィング防止 X-XSS-Protection: 1; mode=block - XSSフィルター有効化 Strict-Transport-Security: max-age=31536000; includeSubDomains; preload - HTTPS強制 Referrer-Policy: strict-origin-when-cross-origin `Permissions-Policy... (source: PR #141)
- [2026-02-17] test: 既存データの互換性テスト(Markdownエディタ移行) -- --|------| | lib/sanitize.ts | HTML sanitization（XSS防止、コンテンツタイプ検出） | | components/content/MarkdownRenderer.tsx | 統一コンテンツレンダラー（プレーンテキスト/HTML/Markdown） | | **tests**/lib/sanitize.test.ts | サニタイズテスト（XSS攻撃ベクター14種、コンテンツ検出） | | `**tests**/components/MarkdownRender... (source: PR #140)
