# ut-gymnastics Design Decisions

## 2026-04-15: fix(nginx): server_name 修正 + ACME challenge 追加（証明書失効対応）

- **What**: fix(nginx): server_name 修正 + ACME challenge 追加（証明書失効対応）
- **Why**: ## Problem 本番サイト https://ob.todai-kunstturnen.net が Chrome で `NET::ERR_CERT_DATE_INVALID`。Let's Encrypt 証明書が 2026-03-19 に失効していた。certbot renew も 502 で失敗。 ## Root cause `nginx/nginx.conf` がテンプレートのプレースホルダのまま運用されていた: - `server_name your-domain.com www.your-domain.com;` ← 未置換 - HTTP block に `/.well-known/acme-challenge/` の location がなく、webroot 検証が全リクエストを proxy に流して 502 これが `scripts/production/deploy-nginx-config.sh` 経由で …
- **Source**: PR #148

## 2026-04-15: fix(security): npm audit fix で high 脆弱性を解消 (#146)

- **What**: fix(security): npm audit fix で high 脆弱性を解消 (#146)
- **Why**: ## Summary - `npm audit fix` により依存ツリー内の high 脆弱性をすべて解消 - Security Scan workflow (`npm audit --audit-level high`) が green になる見込み - `package.json` は変更なし、`package-lock.json` のみ更新（非破壊） Closes #146 ## 修正内容 `npm audit fix` (非 `--force`) のみで解消: | パッケージ | Severity | Advisory | |---|---|---| | minimatch | high | GHSA-3ppc-4f35-3m26 / 7r86-cg39-jmmj / 23c5-xmqv-rm74 | | rollup | high | GHSA-mw96-cpmx-2vgc (Path Traversal) | |…
- **Source**: PR #147

## 2026-03-08: chore: Node.jsバージョンを22 LTSに統一

- **What**: chore: Node.jsバージョンを22 LTSに統一
- **Why**: ## Summary - Node.jsバージョンを全箇所で22 LTS (Active LTS) に統一 - 変更前: .nvmrc=20, Dockerfile=20, CI=25, security.yml=20, pre-commit=20 - 変更後: すべて22に統一 ## 変更箇所 | ファイル | 変更前 | 変更後 | |---|---|---| | `.nvmrc` | 20 | 22 | | `package.json` engines | >=20.0.0 | >=22.0.0 | | `docker/Dockerfile` | node:20-slim | node:22-slim | | `docker/Dockerfile.production` | node:20-alpine | node:22-alpine | | `.github/workflows/ci.yml` | 25 | 22 |…
- **Source**: PR #145

## 2026-02-17: fix(news): HTMLレンダリング修正と作成者変更機能を追加

- **What**: fix(news): HTMLレンダリング修正と作成者変更機能を追加
- **Why**: ## Summary - インデント付き生HTMLコンテンツがMarkdownのコードブロックとして表示される問題を修正（`/news/OBOG2024` 等） - ニュース記事の作成者(author)を編集・作成フォームから変更できるドロップダウンを追加 - PUT/POST APIに `author_id` パラメータを追加 ## Test plan - [ ] `/news/OBOG2024` 記事でHTMLが正常にレンダリングされることを確認 - [ ] 通常のMarkdown記事が影響を受けないことを確認 - [ ] 編集画面で作成者ドロップダウンが表示され、現在の作成者がデフォルト選択されていることを確認 - [ ] 作成者を変更して保存後、変更が反映されることを確認 - [ ] 新規作成画面で作成者ドロップダウンが表示されることを確認 - [ ] 作成者未選択時はログインユーザーが作成者になることを確認 🤖 Ge…
- **Source**: PR #144

## 2026-02-17: docs: CLAUDE.md スリム化と .claude/rules/ 分離

- **What**: docs: CLAUDE.md スリム化と .claude/rules/ 分離
- **Why**: ## Summary - CLAUDE.md が235行に肥大化し AI向けルール・人間向け手順・ゴッチャが混在していたのを整理 - Claude Code ベストプラクティスに従い、パス固有のドメイン知識を `.claude/rules/` に分離 - 古い一回限りドキュメントを削除し、壊れたリンクを修正 ## 変更内容 ### 新規: `.claude/rules/` (4ファイル) | ファイル | 対象パス | 内容 | |---------|---------|------| | `nextjs.md` | `app/**`, `components/**` | Server/Client Component、Date型、Edge Runtime | | `prisma.md` | `prisma/**`, `lib/prisma.ts` | マイグレーションワークフロー、ポート番号 | | `deployment.…
- **Source**: PR #143

## 2026-02-17: feat(security): nginxレート制限の実装（DDoS対策）

- **What**: feat(security): nginxレート制限の実装（DDoS対策）
- **Why**: ## Summary - Issue #56 に基づき、nginxレート制限によるDDoS・ブルートフォース対策を実装 - 7つのレート制限ゾーンをエンドポイント種別ごとに定義 - 認証系エンドポイントに厳格な制限（1r/m）、一般APIに適切な制限（5r/s） ## 変更内容 ### nginx/nginx.conf - **レート制限ゾーン定義**: general, api, login, password_reset, upload, search, static の7ゾーン - **認証エンドポイント保護**: - `/api/auth/login`: 1r/m burst=2（ブルートフォース防止、遅延あり） - `/api/auth/signup`: 1r/m burst=3（スパム登録防止） - `/api/auth/send-confirmation`: 1r/m burst=2（メール濫用防止） - `/a…
- **Source**: PR #142

## 2026-02-17: security(nginx): セキュリティヘッダーの強化

- **What**: security(nginx): セキュリティヘッダーの強化
- **Why**: ## Summary - nginxセキュリティヘッダーを強化し、OWASP推奨に準拠 - `nginx/security-headers.conf`に設定を分離してメンテナンス性向上 - Next.js側にも同等のヘッダーを設定（バックアップ層） - E2Eテストでヘッダー設定を検証 ## Changes ### nginx/security-headers.conf (新規) - `X-Frame-Options: DENY` - クリックジャッキング完全防止 - `X-Content-Type-Options: nosniff` - MIMEスニッフィング防止 - `X-XSS-Protection: 1; mode=block` - XSSフィルター有効化 - `Strict-Transport-Security: max-age=31536000; includeSubDomains; preload` - HTTP…
- **Source**: PR #141

## 2026-02-17: test: 既存データの互換性テスト(Markdownエディタ移行)

- **What**: test: 既存データの互換性テスト(Markdownエディタ移行)
- **Why**: ## Summary - MarkdownRendererコンポーネントとHTMLサニタイズユーティリティを作成し、既存データの互換性テストスイートを実装 - ユニットテスト56件（XSS防止14ベクター含む）、E2Eテスト7シナリオ、Admin検証ページを追加 - `sanitize-html`, `marked` 依存追加、pre-commit ESLint hook修正 ## Changes ### 新規ファイル | ファイル | 内容 | |---------|------| | `lib/sanitize.ts` | HTML sanitization（XSS防止、コンテンツタイプ検出） | | `components/content/MarkdownRenderer.tsx` | 統一コンテンツレンダラー（プレーンテキスト/HTML/Markdown） | | `__tests__/lib/sanitize.tes…
- **Source**: PR #140
