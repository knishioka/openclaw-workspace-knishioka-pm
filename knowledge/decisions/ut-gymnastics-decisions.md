# ut-gymnastics Design Decisions

## 2026-04-15: server_name 修正 + ACME challenge 追加（証明書失効対応）

- **What**: server_name 修正 + ACME challenge 追加（証明書失効対応）
- **Why**: e your-domain.com www.your-domain.com; ← 未置換 HTTP block に /.well-known/acme-challenge/ の location がなく、webroot 検証が全リクエストを proxy に流して 502 これが scripts/production/deploy-nginx-config.sh 経由で /etc/nginx/sites-available/ut-gymnastics に配布されていた。listen 443 ssl がこの 1 b...
- **Source**: PR #148

## 2026-04-15: npm audit fix で high 脆弱性を解消 (#146)

- **What**: npm audit fix で high 脆弱性を解消 (#146)
- **Why**: | パッケージ | Severity | Advisory | |---|---|---| | minimatch | high | GHSA-3ppc-4f35-3m26 / 7r86-cg39-jmmj / 23c5-xmqv-rm74 | | rollup | high | GHSA-mw96-cpmx-2vgc (Path Traversal) | | serialize-javascript (via terser-webpack-plugin) | high | GHSA-5c6j-r48x-rm...
- **Source**: PR #147

## 2026-03-08: Node.jsバージョンを22 LTSに統一

- **What**: Node.jsバージョンを22 LTSに統一
- **Why**: | >=20.0.0 | >=22.0.0 | | docker/Dockerfile | node:20-slim | node:22-slim | | docker/Dockerfile.production | node:20-alpine | node:22-alpine | | .github/workflows/ci.yml | 25 | 22 | | .github/workflows/security.yml | 20 | 22 | | .pre-commit-config.yaml | 20...
- **Source**: PR #145

## 2026-02-17: HTMLレンダリング修正と作成者変更機能を追加

- **What**: HTMLレンダリング修正と作成者変更機能を追加
- **Why**: インデント付き生HTMLコンテンツがMarkdownのコードブロックとして表示される問題を修正（/news/OBOG2024 等） ニュース記事の作成者(author)を編集・作成フォームから変更できるドロップダウンを追加 PUT/POST APIに author_id パラメータを追加 [ ] /news/OBOG2024 記事でHTMLが正常にレンダリングされることを確認 [ ] 通常のMarkdown記事が影響を受けないことを確認 [ ] 編集画面で作成者ドロップダウンが表示され、現在の作成者がデフォルト選択
- **Source**: PR #144

## 2026-02-17: CLAUDE.md スリム化と .claude/rules/ 分離

- **What**: CLAUDE.md スリム化と .claude/rules/ 分離
- **Why**: --------|---------|------| | nextjs.md | app/**, components/** | Server/Client Component、Date型、Edge Runtime | | prisma.md | prisma/**, lib/prisma.ts | マイグレーションワークフロー、ポート番号 | | deployment.md | scripts/production/**, docker/**, nginx/** | デプロイ参照先、Docker/jqゴッチャ...
- **Source**: PR #143

## 2026-02-17: nginxレート制限の実装（DDoS対策）

- **What**: nginxレート制限の実装（DDoS対策）
- **Why**: d_reset, upload, search, static の7ゾーン **認証エンドポイント保護**: /api/auth/login: 1r/m burst=2（ブルートフォース防止、遅延あり） /api/auth/signup: 1r/m burst=3（スパム登録防止） /api/auth/send-confirmation: 1r/m burst=2（メール濫用防止） /api/auth/password-reset: 1r/m burst=3（不正リセット防止） **リソース保護**: `/ap...
- **Source**: PR #142

## 2026-02-17: security(nginx): セキュリティヘッダーの強化

- **What**: security(nginx): セキュリティヘッダーの強化
- **Why**: リックジャッキング完全防止 X-Content-Type-Options: nosniff - MIMEスニッフィング防止 X-XSS-Protection: 1; mode=block - XSSフィルター有効化 Strict-Transport-Security: max-age=31536000; includeSubDomains; preload - HTTPS強制 Referrer-Policy: strict-origin-when-cross-origin `Permissions-Policy...
- **Source**: PR #141

## 2026-02-17: 既存データの互換性テスト(Markdownエディタ移行)

- **What**: 既存データの互換性テスト(Markdownエディタ移行)
- **Why**: --|------| | lib/sanitize.ts | HTML sanitization（XSS防止、コンテンツタイプ検出） | | components/content/MarkdownRenderer.tsx | 統一コンテンツレンダラー（プレーンテキスト/HTML/Markdown） | | __tests__/lib/sanitize.test.ts | サニタイズテスト（XSS攻撃ベクター14種、コンテンツ検出） | | `__tests__/components/MarkdownRender...
- **Source**: PR #140

## 2026-02-16: nginxで機密ファイルへのアクセスをブロック

- **What**: nginxで機密ファイルへのアクセスをブロック
- **Why**: s.conf | 新規: .env, .git/, 隠しファイルのブロックルール | | nginx/nginx.conf | include追加 + proxy_Set_headerタイポ修正 | | scripts/production/deploy-nginx-config.sh | 新規: nginx設定デプロイスクリプト | | scripts/production/deploy-production.sh | nginx設定デプロイステップ統合 | | nginx/README.md | 新規: n...
- **Source**: PR #139

## 2026-02-16: security(nginx): 悪意のあるパスパターンのブロック設定追加

- **What**: security(nginx): 悪意のあるパスパターンのブロック設定追加
- **Why**: ル: | カテゴリ | パターン例 | 理由 | |---------|-----------|------| | PHP/ASP/JSP拡張子 | .php, .asp, .jsp | Next.jsサイトでPHP未使用 | | WordPress | /wp-admin, /wp-login, /xmlrpc.php | WordPress未使用 | | PHPMyAdmin | /phpmyadmin, /pma | DB管理ツール未使用 | | 暗号通貨API | /ws-fapi, `/api/v1/...
- **Source**: PR #138
