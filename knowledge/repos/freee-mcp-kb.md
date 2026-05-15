# freee-mcp Knowledge Base

## Overview

- Repo: knishioka/freee-mcp
- Description: MCP server for freee accounting API
- Primary language (GitHub): TypeScript
- Category / Priority: mcp / high
- Status: active
- License: MIT
- Default branch: main
- Created: 2025-05-26
- Updated: 2026-05-06
- Collected: 2026-05-15

## Tech Stack

- Runtime dependencies: @modelcontextprotocol/sdk, axios, debug, dotenv, zod
- Dev dependencies: @types/debug, @types/node, @typescript-eslint/eslint-plugin, @typescript-eslint/parser, @vitest/coverage-v8, eslint, husky, lint-staged, tsx, typescript, vitest
- npm scripts: build, dev, gitleaks, gitleaks:ci, lint, prepare, setup-auth, start, test, test:coverage, typecheck
- pyproject.toml: not found
- requirements.txt: not found
- README signal: # MCP Server for freee Accounting API [![CI](https://github.com/knishioka/freee-mcp/actions/workflows/ci.yml/badge.svg)](https://github.com/knishioka/freee-mcp/actions/workflows/ci.yml)...

## Architecture / Patterns

- Browser/app code uses package-managed TypeScript/JavaScript workflow with explicit build/test scripts.
- MCP server surface should keep tool schemas explicit and API errors predictable for agent callers.
- Auth/token handling and API quota/error translation are core architecture risks.

## Competitive Landscape (source: 2026-05-15 web research)

- freee accounting API raised the deal detail-line cap from 40 to 100 for POST/PUT /api/1/deals; non-breaking change announced 2026-04-27 and released 2026-04-23. Feature candidate: validate local schemas/tests against 100-line deal payloads. (source: freee Developers Community, 2026-04-27)
- Money Forward launched a remote MCP server for Money Forward Cloud Accounting on 2026-03-26, across all plans, with journal entry, ledger search, data verification, and report creation through major AI tools. Feature candidate: remote MCP/OAuth deployment path for freee-mcp, not only local token usage. (source: Money Forward release, 2026-03-26)
- MCP TypeScript SDK April 2026 pre-release changed unknown tool/resource errors and added Standard Schema support; servers should catch rejected promises and avoid Zod-only assumptions. Feature candidate: compatibility audit before upgrading SDK. (source: modelcontextprotocol/typescript-sdk releases, 2026-04-01)

## Tech Decisions (from recent PRs/commits)

- [2026-05-05] test: migrate Jest suite to Vitest -- ## 概要 Jest + ts-jest のテスト実行環境を Vitest 3 に移行し、ESM/TypeScript 向けの設定を簡素化しました。既存テストの振る舞いは維持しつつ、テストスクリプトとカバレッジ生成を Vitest ベースに更新しています。 Closes #179 ## 変更内容 - `package.json` / `package-... (source: PR #180)
- [2026-04-29] feat(kpi): add structured dashboard output -- ## Summary - Upgrade @modelcontextprotocol/sdk to ^1.29.0. - Return structuredContent from freee_kpi_dashboard with company_id, period, and profitability / safety / efficiency /... (source: PR #178)
- [2026-04-16] refactor(schema): migrate tool registration to Zod 4 -- ## Summary - upgrade `zod` from `^3.25.28` to `^4.3.6` and refresh the lockfile - replace the `any`-based `registerTool` shim with a typed generic wrapper while keeping tool... (source: PR #176)
- [2026-03-31] fix(security): pin axios to 1.14.0 to avoid compromised 1.14.1 -- ## Summary - **axios 1.14.1** was published as a malicious version containing a remote access trojan (RAT) via the `plain-crypto-js` dependency ([StepSecurity... (source: PR #173)
- [2026-03-06] feat(analysis): add freee_partner_analysis tool -- ## Summary - Add `freee_partner_analysis` MCP tool for partner-level revenue/expense analysis with concentration risk assessment - Aggregates deals by partner using auto-... (source: PR #172)
- [2026-03-06] feat(tools): add freee_kpi_dashboard tool -- ## Summary - Add `freee_kpi_dashboard` MCP tool that aggregates KPI data from PL, BS, and walletables in a single call - Computes profitability (operating/ordinary profit... (source: PR #171)
- [2026-03-06] feat(advisory): add freee_cost_analysis tool -- ## Summary - Add `freee_cost_analysis` tool for expense structure analysis (費用構造分析) - Compares current vs previous year P/L data to detect YoY anomalies exceeding a configurable... (source: PR #170)
- [2026-03-06] feat(advisory): add freee_journal_consistency_check tool -- ## Summary - Add `freee_journal_consistency_check` tool that detects journal entry inconsistencies across deals - Detects account item inconsistencies per partner (same partner... (source: PR #169)
