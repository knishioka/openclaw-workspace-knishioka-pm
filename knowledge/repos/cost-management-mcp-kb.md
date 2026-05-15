# cost-management-mcp Knowledge Base

## Overview

- Repo: knishioka/cost-management-mcp
- Description: Unified cloud cost management MCP server
- Primary language (GitHub): TypeScript
- Category / Priority: mcp / medium
- Status: active
- License: MIT
- Default branch: main
- Created: 2025-06-13
- Updated: 2026-05-12
- Collected: 2026-05-15

## Tech Stack

- Runtime dependencies: @aws-sdk/client-cost-explorer, dotenv, node-cache, openai, zod
- Dev dependencies: @modelcontextprotocol/sdk, @types/jest, @types/node, @typescript-eslint/eslint-plugin, @typescript-eslint/parser, eslint, husky, jest, lint-staged, prettier, ts-jest, tsx, typescript
- npm scripts: build, clean, dev, lint, lint:fix, prepare, start, test, test:coverage, test:watch, typecheck
- pyproject.toml: not found
- requirements.txt: not found
- README signal: # Cost Management MCP [![CI](https://github.com/knishioka/cost-management-mcp/actions/workflows/ci.yml/badge.svg)](https://github.com/knishioka/cost-management-mcp/actions/workflows/ci.yml) [![Security...

## Architecture / Patterns

- Browser/app code uses package-managed TypeScript/JavaScript workflow with explicit build/test scripts.
- MCP server surface should keep tool schemas explicit and API errors predictable for agent callers.
- Auth/token handling and API quota/error translation are core architecture risks.

## Competitive Landscape (notes)

No competitive research captured in this weekly rotation.

## Tech Decisions (from recent PRs/commits)

- [2026-05-12] fix(ci): make TruffleHog scan refs robust -- ## 概要 Security Scan workflow の TruffleHog diff scan が main push で default branch 名と `HEAD` を比較して同一 commit 扱いになり、`BASE and HEAD commits are the same` で失敗する問題を修正しました。push /... (source: PR #152)
- [2026-05-04] fix(security): resolve fast-xml-parser audit finding -- ## 概要 `@aws-sdk/xml-builder` 経由で解決されていた脆弱な `fast-xml-parser` を npm `overrides` で安全版へ固定し、Security Scan の `npm audit --production` 失敗を解消します。AWS SDK 本体の広範な更新は行わず、Node.js >=18... (source: PR #150)
- [2026-05-02] chore: adopt knishioka/openclaw-workspace-ds-pm baseline -- ## Summary First adoption of the cross-repo Claude Code / GitHub baseline maintained at `knishioka/openclaw-workspace-ds-pm:templates/repo-baseline`. Applied via: \`\`\`sh bash... (source: PR #148)
- [2026-03-28] fix(ci): fix schedule workflows (close-stale-dependency-prs / trufflehog) -- ## Summary - **close-stale-dependency-prs.yml**: Remove duplicate `const core = require('@actions/core')` declaration that caused `SyntaxError: Identifier 'core' has already... (source: PR #147)
- [2025-11-04] Upgrade Zod to v4 and update schema handling -- ## Summary - bump the Zod dependency to v4.1.12 and refresh the lockfile - adjust environment and tool schemas for the Zod v4 API changes - tighten Anthropic usage handling by... (source: PR #140)
- [2025-11-03] docs: add AGENTS handbook for repository operations -- ## Summary - add repository-wide AGENTS guide outlining project overview, setup, operational commands, and governance rules for future agents ## Testing - not run (documentation... (source: PR #136)
- [2025-11-01] Add protocol-level MCP handler tests -- ## Summary - add coverage for the MCP ListTools handler to confirm exported metadata is returned - verify CallTool requests invoke registered tool handlers with the provider... (source: PR #135)
- [2025-11-01] Centralize provider definitions and tool routing -- ## Summary - add a shared SUPPORTED_PROVIDERS constant and reuse it across configuration and provider listing - refactor the MCP server to pull tool metadata and handlers from a... (source: PR #134)
