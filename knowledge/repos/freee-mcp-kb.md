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
- Updated: 2026-04-16
- Collected: 2026-04-24

## Tech Stack

- package.json: present
- Dependencies (sample): @modelcontextprotocol/sdk, axios, debug, dotenv, zod
- Dev dependencies (sample): @types/debug, @types/jest, @types/node, @typescript-eslint/eslint-plugin, @typescript-eslint/parser, eslint, husky, jest, lint-staged, ts-jest, tsx, typescript
- npm scripts (keys): build, dev, gitleaks, gitleaks:ci, lint, prepare, setup-auth, start, test, test:coverage, typecheck
- pyproject.toml: not found
- requirements.txt: not found
- README signal: MCP Server for freee Accounting API A Model Context Protocol (MCP) server that provides integration with freee accounting software API, enabling AI assistants to interact with accounting data. Features - OAuth 2.0 authentication flow support - Company management - Transaction (Deal) operations - Account items managemen…

## Architecture / Patterns

- TypeScript MCP server with tool-per-capability surface and schema-validated inputs
- TypeScript tool registration + typed domain model around external APIs
- Accounting advisory/reporting layer built on top of freee API primitives

## Competitive Landscape (notes)

[2026-04-17] MCP TypeScript SDK latest is still **1.29.0** (`npm view @modelcontextprotocol/sdk version`). The repo just migrated its tool-registration layer to Zod 4, so the next leverage point is not core SDK churn but adopting newer protocol features on top of the stable SDK surface. (refs: npm view @modelcontextprotocol/sdk version, https://github.com/modelcontextprotocol/typescript-sdk)
[2026-04-17] MCP spec 2025-06-18 adds **structured tool output**, **resource links**, **elicitation**, OAuth resource-server metadata, and stricter HTTP protocol-version signaling. For a finance/accounting MCP server, that points toward richer machine-readable report payloads and safer auth / clarification flows instead of only plain text responses. (ref: https://modelcontextprotocol.io/specification/2025-06-18/changelog)

Potential feature candidates for this repo:
- Add **structured-content responses** for ledger, KPI, aging, and comparison tools so clients can render tables/charts without reparsing text.
- Add **resource links + elicitation** for follow-up workflows, for example linking related reports and asking for missing `companyId` / fiscal period before returning hard errors.

## Tech Decisions (from PRs/commits)

- [2026-04-16] refactor(schema): migrate tool registration to Zod 4 -- - upgrade `zod` from `^3.25.28` to `^4.3.6` and refresh the lockfile - replace the `any`-based `registerTool` shim with a typed generic wrapper while keeping tool names and input argument names unchanged - update focused regression tests for the new Zod v4 package version and raw schema shape typing Verification - `npm… (source: PR #176)
- [2026-03-31] fix(security): pin axios to 1.14.0 to avoid compromised 1.14.1 -- - **axios 1.14.1** was published as a malicious version containing a remote access trojan (RAT) via the `plain-crypto-js` dependency ( ) - This project previously used `"axios": "^1.9.0"` which could auto-resolve to the compromised 1.14.1 - Pins axios to exact version `1.14.0` (last known safe release) by removing the… (source: PR #173)
- [2026-03-06] feat(analysis): add freee_partner_analysis tool -- - Add `freee_partner_analysis` MCP tool for partner-level revenue/expense analysis with concentration risk assessment - Aggregates deals by partner using auto-pagination, computes top N rankings with share %, monthly breakdown, and concentration risk levels (low/medium/high) - Resolves #150 Changes File Change --- ---… (source: PR #172)
- [2026-03-06] feat(tools): add freee_kpi_dashboard tool -- - Add `freee_kpi_dashboard` MCP tool that aggregates KPI data from PL, BS, and walletables in a single call - Computes profitability (operating/ordinary profit margins), safety (current/equity ratios), efficiency (receivable/payable turnover days), and liquidity (cash balance, working capital) metrics - Includes health… (source: PR #171)
- [2026-03-06] feat(advisory): add freee_cost_analysis tool -- - Add `freee_cost_analysis` tool for expense structure analysis (費用構造分析) - Compares current vs previous year P/L data to detect YoY anomalies exceeding a configurable threshold (default 50%) - Classifies expense items as fixed or variable costs based on Japanese account name patterns - Supports monthly or cumulative ye… (source: PR #170)
- [2026-03-06] feat(advisory): add freee_journal_consistency_check tool -- - Add `freee_journal_consistency_check` tool that detects journal entry inconsistencies across deals - Detects account item inconsistencies per partner (same partner using multiple account items) - Detects tax category inconsistencies within same partner+account combination - Results sorted by severity with actionable… (source: PR #169)
- [2026-03-06] feat(analysis): add freee_ar_aging tool (#148) -- - Add `freee_ar_aging` tool for accounts receivable aging analysis (売掛金エイジング分析) - Classifies unsettled income deals into aging buckets (0-30, 31-60, 61-90, 90+ days) - Aggregates by partner with oldest-days tracking for collection prioritization - Highlights long-overdue (61+ days) receivables in summary Changes File C… (source: PR #168)
- [2026-03-06] feat(advisory): add freee_tagging_consistency_check tool -- Implements #144 - タグ付け一貫性チェックツール 取引のタグ・セグメント付与の一貫性を分析し、揺れ・漏れを検出するツール。 - **取引先別タグ不統一検出**: 同一取引先で異なるタグパターン、タグ未付与を検出 - **セグメント未設定検出**: 部門(section_id)が未設定の取引明細を検出 - **勘定科目別タグ逸脱検出**: 各勘定科目の多数派タグパターンからの逸脱を検出 Changes File Change ------ -------- `src/types/freee.ts` Add `TaggingConsistencyResult` and related types `src/schemas… (source: PR #167)
