# freee-mcp Knowledge Base

## Overview

- Repo: knishioka/freee-mcp
- Description: MCP server for freee accounting API integration
- Primary language (GitHub): TypeScript
- Category / Priority: mcp / high
- Status: active
- License: MIT
- Default branch: main
- Created: 2025-05-26
- Updated: 2026-05-06
- Collected: 2026-05-08

## Tech Stack

- package.json: present
- Dependencies (sample): @modelcontextprotocol/sdk, axios, debug, dotenv, zod
- Dev dependencies (sample): @types/debug, @types/node, @typescript-eslint/eslint-plugin, @typescript-eslint/parser, @vitest/coverage-v8, eslint, husky, lint-staged, tsx, typescript, vitest
- npm scripts (keys): build, dev, gitleaks, gitleaks:ci, lint, prepare, setup-auth, start, test, test:coverage, typecheck
- pyproject.toml: not found
- requirements.txt: not found
- README signal: # MCP Server for freee Accounting API [![CI](https://github.com/knishioka/freee-mcp/actions/workflows/ci.yml/badge.svg)](https://github.com/knishioka/freee-mcp/actions/workflows/ci.yml) [![codecov](https://codecov.io/gh/knishioka/freee-mcp/branch/main/graph/badge.svg)](https://co

## Architecture / Patterns

- MCP server with tool-per-capability interface and schema-validated inputs
- Upstream API/client layer isolated from MCP presentation surface
- Risk-aware workflow design around external system access, auth, and long-running tasks

## Competitive Landscape (notes)

[2026-05-01] MCP TypeScript SDK pre-release (1.30+) adds **Standard Schema support** (Zod v4, Valibot, ArkType) + **TaskManager** for long-running async tasks. freee-mcp already uses Zod v4 so inputSchema will work unchanged. TaskManager is the next adoption candidate for slow report-generation flows.
[2026-04-17] MCP TypeScript SDK latest stable is **1.29.0** (`npm view @modelcontextprotocol/sdk version`). The repo just migrated its tool-registration layer to Zod 4, so the next leverage point is not core SDK churn but adopting newer protocol features on top of the stable SDK surface. (refs: npm view @modelcontextprotocol/sdk version, https://github.com/modelcontextprotocol/typescript-sdk)
[2026-04-17] MCP spec 2025-06-18 adds **structured tool output**, **resource links**, **elicitation**, OAuth resource-server metadata, and stricter HTTP protocol-version signaling. For a finance/accounting MCP server, that points toward richer machine-readable report payloads and safer auth / clarification flows instead of only plain text responses. (ref: https://modelcontextprotocol.io/specification/2025-06-18/changelog)

Potential feature candidates for this repo:
- Add **TaskManager-based long-running report generation** (MCP SDK 1.30 pre-release): financial reports like multi-year comparison or general ledger can take time; async task + polling fits the pattern.
- Add **structured-content responses** for ledger, KPI, aging, and comparison tools so clients can render tables/charts without reparsing text.
- Add **resource links + elicitation** for follow-up workflows, for example linking related reports and asking for missing `companyId` / fiscal period before returning hard errors.

## Tech Decisions (from PRs/commits)

- [2026-05-05] test: migrate Jest suite to Vitest -- Jest + ts-jest のテスト実行環境を Vitest 3 に移行し、ESM/TypeScript 向けの設定を簡素化しました。既存テストの振る舞いは維持しつつ、テストスクリプトとカバレッジ生成を Vitest ベースに更新しています。 (source: PR #180)
- [2026-04-29] feat(kpi): add structured dashboard output -- Upgrade @modelcontextprotocol/sdk to ^1.29.0. (source: PR #178)
- [2026-04-16] refactor(schema): migrate tool registration to Zod 4 -- upgrade zod from ^3.25.28 to ^4.3.6 and refresh the lockfile replace the any-based registerTool shim with a typed generic wrapper while keeping tool names and input argument names unchanged update focused regression tests for the new Zod v4 package version and (source: PR #176)
- [2026-03-31] fix(security): pin axios to 1.14.0 to avoid compromised 1.14.1 -- sed-on-npm-malicious-versions-drop-remote-access-trojan)) This project previously used "axios": "^1.9.0" which could auto-resolve to the compromised 1.14.1 Pins axios to exact version 1.14.0 (last known safe release) by removing the caret range package.json:... (source: PR #173)
- [2026-03-06] feat(analysis): add freee_partner_analysis tool -- re %, monthly breakdown, and concentration risk levels (low/medium/high) Resolves #150 | File | Change | |---|---| | src/schemas.ts | Add PartnerAnalysisSchema | | src/types/freee.ts | Add PartnerAnalysisResult, PartnerAnalysisItem, ConcentrationRisk types |... (source: PR #172)
- [2026-03-06] feat(tools): add freee_kpi_dashboard tool -- ency (receivable/payable turnover days), and liquidity (cash balance, working capital) metrics Includes health status indicators (healthy/caution/warning) with configurable thresholds Closes #149 src/types/freee.ts: Add KpiMetric, KpiDashboardResult, `KpiSta... (source: PR #171)
- [2026-03-06] feat(advisory): add freee_cost_analysis tool -- ies expense items as fixed or variable costs based on Japanese account name patterns Supports monthly or cumulative year-to-date analysis Closes #151 src/schemas.ts: Add CostAnalysisSchema with companyId, fiscalYear, month, threshold fields `src/types/freee.... (source: PR #170)
- [2026-03-06] feat(advisory): add freee_journal_consistency_check tool -- x category inconsistencies within same partner+account combination Results sorted by severity with actionable recommendations Closes #147 | File | Change | |------|--------| | src/types/freee.ts | Add AccountItemInconsistency, TaxCategoryInconsistency, `Jour... (source: PR #169)
