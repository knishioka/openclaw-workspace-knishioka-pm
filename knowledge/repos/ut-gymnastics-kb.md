# ut-gymnastics Knowledge Base

## Overview

- Repo: knishioka/ut-gymnastics
- Description: 東大体操部OBホームページ
- Primary language (GitHub): TypeScript
- License: none
- Default branch: main
- Created: 2019-12-16
- Updated: 2026-06-04
- Collected: 2026-06-12

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

- [2026-06-04] fix(images): 本番イメージで最適化済み画像が 404 になる問題を修正（#186） -- 本番イメージで `/images/optimized/<name>_<size>.webp` が **404** になる問題を修正します。 (source: PR #189)
- [2026-06-04] refactor(api): news ドメインを API 標準パターンへ移行（zod+service+guard+wrapper / 422規約） -- posts（#172, マージ済み）で確立した **API 標準パターン**を **news ドメイン**へ横展開するリファクタリング。基盤（`with-handler` / `guards` / `errors`）は再利用し、新規作成していません。挙動は保持しつつ、各ルートを「検証 → ガード → サービス → successResponse」の薄いハンドラへ移行しました。 (source: PR #178)
- [2026-06-04] refactor(api): albums ドメインを API 標準パターンへ移行（zod+service+guard+wrapper / 422規約） -- posts（PoC #172, マージ済み）で確立した **API 標準パターン**を **albums ドメイン**へ横展開しました。基盤（共通ラッパー / 認可ガード / エラー / ロガー）は **再利用** し、新規作成していません。 (source: PR #177)
- [2026-06-04] refactor(api): tags ドメインを API 標準パターンへ移行（zod+service+guard+wrapper / 422規約） -- posts で確立した API 標準パターン（PoC #172, マージ済み）を **tags ドメイン**へ横展開しました。基盤（`with-handler` / `guards` / `errors` / `api-logger`）は既存のものを**再利用**し、新規基盤は作成していません。 (source: PR #176)
- [2026-06-03] docs(architecture): ARCHITECTURE.md とオンボーディング導線を整備 (#166) -- 新規開発者がディレクトリ構成・API層設計・ログ/認証の指針を1枚で俯瞰できる `docs/ARCHITECTURE.md` を新規作成し、オンボーディング導線（最初に読む順序）と相互リンクを整備しました。**追加ドキュメントのみでコード影響はありません。** (source: PR #169)
- [2026-06-03] feat(error-handling): app セグメント別の error.tsx / loading.tsx 境界を整備 (#158) -- 主要セグメントに局所的な `error.tsx` / `loading.tsx` 境界を追加し、1箇所のエラーがページ全体へ波及するのを防ぎます。UX と運用安定性の改善。 (source: PR #162)
