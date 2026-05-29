# ut-gymnastics Design Decisions

## 2026-04-15: fix(nginx): server_name 修正 + ACME challenge 追加（証明書失効対応）

- **What**: fix(nginx): server_name 修正 + ACME challenge 追加（証明書失効対応）
- **Why**: 本番サイト https://ob.todai-kunstturnen.net が Chrome で `NET::ERR_CERT_DATE_INVALID`。Let's Encrypt 証明書が 2026-03-19 に失効していた。certbot renew も 502 で失敗。 
- **Source**: PR #148

## 2026-04-15: fix(security): npm audit fix で high 脆弱性を解消 (#146)

- **What**: fix(security): npm audit fix で high 脆弱性を解消 (#146)
- **Why**: - `npm audit fix` により依存ツリー内の high 脆弱性をすべて解消 - Security Scan workflow (`npm audit --audit-level high`) が green になる見込み - `package.json` は変更なし、`package-lock.json` のみ更新（非破壊） 
- **Source**: PR #147

## 2026-02-17: fix(news): HTMLレンダリング修正と作成者変更機能を追加

- **What**: fix(news): HTMLレンダリング修正と作成者変更機能を追加
- **Why**: - インデント付き生HTMLコンテンツがMarkdownのコードブロックとして表示される問題を修正（`/news/OBOG2024` 等） - ニュース記事の作成者(author)を編集・作成フォームから変更できるドロップダウンを追加 - PUT/POST APIに `author_id` パラメータを追加 
- **Source**: PR #144

## 2026-02-17: feat(security): nginxレート制限の実装（DDoS対策）

- **What**: feat(security): nginxレート制限の実装（DDoS対策）
- **Why**: - Issue #56 に基づき、nginxレート制限によるDDoS・ブルートフォース対策を実装 - 7つのレート制限ゾーンをエンドポイント種別ごとに定義 - 認証系エンドポイントに厳格な制限（1r/m）、一般APIに適切な制限（5r/s） 
- **Source**: PR #142

## 2026-02-17: security(nginx): セキュリティヘッダーの強化

- **What**: security(nginx): セキュリティヘッダーの強化
- **Why**: - nginxセキュリティヘッダーを強化し、OWASP推奨に準拠 - `nginx/security-headers.conf`に設定を分離してメンテナンス性向上 - Next.js側にも同等のヘッダーを設定（バックアップ層） - E2Eテストでヘッダー設定を検証 
- **Source**: PR #141

## 2026-02-16: feat(security): nginxで機密ファイルへのアクセスをブロック

- **What**: feat(security): nginxで機密ファイルへのアクセスをブロック
- **Why**: - `.env`, `.git/config` などの機密ファイルへのアクセスをnginxレベルで404ブロック - セキュリティブロック設定を分離ファイル（`security-blocks.conf`）で管理 - デプロイスクリプトにバックアップ・テスト・自動ロールバック機能を実装 
- **Source**: PR #139
