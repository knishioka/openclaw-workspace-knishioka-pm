# simple-bookkeeping Design Decisions

## 2025-11-07: fix: create select-organization page and improve login error handling (#541)

- **What**: fix: create select-organization page and improve login error handling (#541)
- **Why**: Fixes #541 - Login error when users have no organization
- **Source**: PR #542

## 2025-11-06: fix: use serviceClient for organization creation during signup (#538)

- **What**: fix: use serviceClient for organization creation during signup (#538)
- **Why**: 新規ユーザー登録時に「組織の作成に失敗しました」エラーが発生する問題を修正しました。
- **Source**: PR #539

## 2025-11-06: feat: Claude Codeからのデータベース操作機能を追加

- **What**: feat: Claude Codeからのデータベース操作機能を追加
- **Why**: Claude Codeがローカル/本番Supabaseデータベースに対して安全にクエリを実行できる機能とドキュメントを整備しました。
- **Source**: PR #537

## 2025-11-03: test: stabilize auth action flow

- **What**: test: stabilize auth action flow
- **Why**: ## Summary - update auth server action tests to mock the action client, cookies API, and Next.js redirects so the suite reflects the redirect-driven control flow - adjust sign-in expectations to assert redirects and service interactions ins
- **Source**: PR #536

## 2025-10-12: feat: add strict pre-push review to resolve-gh-issue workflow

- **What**: feat: add strict pre-push review to resolve-gh-issue workflow
- **Why**: Enhance the `/resolve-gh-issue` workflow with a new Step 7.5 that performs strict code review before pushing, preventing unnecessary files and scope creep in PRs.
- **Source**: PR #524

## 2025-10-11: fix: production login infinite redirect loop (#522)

- **What**: fix: production login infinite redirect loop (#522)
- **Why**: ## 🎯 Summary 本番環境でログイン時に発生していた無限リダイレクトループ（ERR_TOO_MANY_REDIRECTS）を修正しました。
- **Source**: PR #523
