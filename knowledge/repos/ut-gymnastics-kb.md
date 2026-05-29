# ut-gymnastics Knowledge Base

## Overview

- Repo: knishioka/ut-gymnastics
- Description: 東大体操部OBホームページ
- Primary language (GitHub): TypeScript
- License: none
- Default branch: main
- Created: 2019-12-16
- Updated: 2026-04-15
- Collected: 2026-05-29

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

- [2026-04-15] fix(nginx): server_name 修正 + ACME challenge 追加（証明書失効対応） -- 本番サイト https://ob.todai-kunstturnen.net が Chrome で `NET::ERR_CERT_DATE_INVALID`。Let's Encrypt 証明書が 2026-03-19 に失効していた。certbot renew も 502 で失敗。 (source: PR #148)
- [2026-04-15] fix(security): npm audit fix で high 脆弱性を解消 (#146) -- - `npm audit fix` により依存ツリー内の high 脆弱性をすべて解消 - Security Scan workflow (`npm audit --audit-level high`) が green になる見込み - `package.json` は変更なし、`package-lock.json` のみ更新（非破壊） (source: PR #147)
- [2026-02-17] fix(news): HTMLレンダリング修正と作成者変更機能を追加 -- - インデント付き生HTMLコンテンツがMarkdownのコードブロックとして表示される問題を修正（`/news/OBOG2024` 等） - ニュース記事の作成者(author)を編集・作成フォームから変更できるドロップダウンを追加 - PUT/POST APIに `author_id` パラメータを追加 (source: PR #144)
- [2026-02-17] feat(security): nginxレート制限の実装（DDoS対策） -- - Issue #56 に基づき、nginxレート制限によるDDoS・ブルートフォース対策を実装 - 7つのレート制限ゾーンをエンドポイント種別ごとに定義 - 認証系エンドポイントに厳格な制限（1r/m）、一般APIに適切な制限（5r/s） (source: PR #142)
- [2026-02-17] security(nginx): セキュリティヘッダーの強化 -- - nginxセキュリティヘッダーを強化し、OWASP推奨に準拠 - `nginx/security-headers.conf`に設定を分離してメンテナンス性向上 - Next.js側にも同等のヘッダーを設定（バックアップ層） - E2Eテストでヘッダー設定を検証 (source: PR #141)
- [2026-02-16] feat(security): nginxで機密ファイルへのアクセスをブロック -- - `.env`, `.git/config` などの機密ファイルへのアクセスをnginxレベルで404ブロック - セキュリティブロック設定を分離ファイル（`security-blocks.conf`）で管理 - デプロイスクリプトにバックアップ・テスト・自動ロールバック機能を実装 (source: PR #139)
