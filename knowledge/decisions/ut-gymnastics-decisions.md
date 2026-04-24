# ut-gymnastics Design Decisions

## 2026-04-15: fix(nginx): server_name 修正 + ACME challenge 追加（証明書失効対応）

- **What**: fix(nginx): server_name 修正 + ACME challenge 追加（証明書失効対応）
- **Why**: Problem
- **Source**: PR #148

## 2026-04-15: fix(security): npm audit fix で high 脆弱性を解消 (#146)

- **What**: fix(security): npm audit fix で high 脆弱性を解消 (#146)
- **Why**: No summary captured.
- **Source**: PR #147

## 2026-03-08: chore: Node.jsバージョンを22 LTSに統一

- **What**: chore: Node.jsバージョンを22 LTSに統一
- **Why**: - Node.jsバージョンを全箇所で22 LTS (Active LTS) に統一 - 変更前: .nvmrc=20, Dockerfile=20, CI=25, security.yml=20, pre-commit=20 - 変更後: すべて22に統一
- **Source**: PR #145

## 2026-02-17: fix(news): HTMLレンダリング修正と作成者変更機能を追加

- **What**: fix(news): HTMLレンダリング修正と作成者変更機能を追加
- **Why**: No summary captured.
- **Source**: PR #144

## 2026-02-17: docs: CLAUDE.md スリム化と .claude/rules/ 分離

- **What**: docs: CLAUDE.md スリム化と .claude/rules/ 分離
- **Why**: No summary captured.
- **Source**: PR #143

## 2026-02-17: feat(security): nginxレート制限の実装（DDoS対策）

- **What**: feat(security): nginxレート制限の実装（DDoS対策）
- **Why**: No summary captured.
- **Source**: PR #142

## 2026-02-17: security(nginx): セキュリティヘッダーの強化

- **What**: security(nginx): セキュリティヘッダーの強化
- **Why**: No summary captured.
- **Source**: PR #141

## 2026-02-17: test: 既存データの互換性テスト(Markdownエディタ移行)

- **What**: test: 既存データの互換性テスト(Markdownエディタ移行)
- **Why**: - MarkdownRendererコンポーネントとHTMLサニタイズユーティリティを作成し、既存データの互換性テストスイートを実装 - ユニットテスト56件（XSS防止14ベクター含む）、E2Eテスト7シナリオ、Admin検証ページを追加 - `sanitize-html`, `marked` 依存追加、pre-commit ESLint hook修正
- **Source**: PR #140
