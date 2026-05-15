# ut-gymnastics Design Decisions

Updated: 2026-05-15

## 2026-04-15: fix(nginx): server_name 修正 + ACME challenge 追加（証明書失効対応）

- **What**: ## Problem 本番サイト https://ob.todai-kunstturnen.net が Chrome で `NET::ERR_CERT_DATE_INVALID`。Let's Encrypt 証明書が 2026-03-19 に失効していた。certbot renew も 502 で失敗。 ## Root cause...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #148

## 2026-04-15: fix(security): npm audit fix で high 脆弱性を解消 (#146)

- **What**: ## Summary - `npm audit fix` により依存ツリー内の high 脆弱性をすべて解消 - Security Scan workflow (`npm audit --audit-level high`) が green になる見込み - `package.json` は変更なし、`package-lock.json`...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #147

## 2026-03-08: chore: Node.jsバージョンを22 LTSに統一

- **What**: ## Summary - Node.jsバージョンを全箇所で22 LTS (Active LTS) に統一 - 変更前: .nvmrc=20, Dockerfile=20, CI=25, security.yml=20, pre-commit=20 - 変更後: すべて22に統一 ## 変更箇所 | ファイル | 変更前 | 変更後 |...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #145

## 2026-02-17: fix(news): HTMLレンダリング修正と作成者変更機能を追加

- **What**: ## Summary - インデント付き生HTMLコンテンツがMarkdownのコードブロックとして表示される問題を修正（`/news/OBOG2024` 等） - ニュース記事の作成者(author)を編集・作成フォームから変更できるドロップダウンを追加 - PUT/POST APIに `author_id` パラメータを追加 ## Test...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #144

## 2026-02-17: docs: CLAUDE.md スリム化と .claude/rules/ 分離

- **What**: ## Summary - CLAUDE.md が235行に肥大化し AI向けルール・人間向け手順・ゴッチャが混在していたのを整理 - Claude Code ベストプラクティスに従い、パス固有のドメイン知識を `.claude/rules/` に分離 - 古い一回限りドキュメントを削除し、壊れたリンクを修正 ## 変更内容 ### 新規:...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #143

## 2026-02-17: feat(security): nginxレート制限の実装（DDoS対策）

- **What**: ## Summary - Issue #56 に基づき、nginxレート制限によるDDoS・ブルートフォース対策を実装 - 7つのレート制限ゾーンをエンドポイント種別ごとに定義 - 認証系エンドポイントに厳格な制限（1r/m）、一般APIに適切な制限（5r/s） ## 変更内容 ### nginx/nginx.conf -...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #142

## 2026-02-17: security(nginx): セキュリティヘッダーの強化

- **What**: ## Summary - nginxセキュリティヘッダーを強化し、OWASP推奨に準拠 - `nginx/security-headers.conf`に設定を分離してメンテナンス性向上 - Next.js側にも同等のヘッダーを設定（バックアップ層） - E2Eテストでヘッダー設定を検証 ## Changes ### nginx/security-...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #141

## 2026-02-17: test: 既存データの互換性テスト(Markdownエディタ移行)

- **What**: ## Summary - MarkdownRendererコンポーネントとHTMLサニタイズユーティリティを作成し、既存データの互換性テストスイートを実装 - ユニットテスト56件（XSS防止14ベクター含む）、E2Eテスト7シナリオ、Admin検証ページを追加 - `sanitize-html`, `marked` 依存追加、pre-commit...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #140

## 2026-02-16: feat(security): nginxで機密ファイルへのアクセスをブロック

- **What**: ## Summary Closes #52 - `.env`, `.git/config` などの機密ファイルへのアクセスをnginxレベルで404ブロック - セキュリティブロック設定を分離ファイル（`security-blocks.conf`）で管理 - デプロイスクリプトにバックアップ・テスト・自動ロールバック機能を実装 ## 変更内容 |...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #139

## 2026-02-16: security(nginx): 悪意のあるパスパターンのブロック設定追加

- **What**: ## Summary - Sentryログで検知された攻撃パターンをnginxレベルでブロックする設定を追加 - PHP/WordPress/暗号通貨API偽装/ステージング環境探索等の6カテゴリをカバー - `proxy_Set_header` タイポも修正 ## Changes ### 新規: `nginx/malicious-path-...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #138
