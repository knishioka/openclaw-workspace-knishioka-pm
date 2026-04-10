# freee-mcp Knowledge Base

## Overview

- Repo: knishioka/freee-mcp
- Description: MCP server for freee accounting API integration
- Primary language (GitHub): TypeScript
- Category / Priority: mcp / high
- License: MIT
- Default branch: main
- Created: 2025-05-26
- Updated: 2026-03-31
- Collected: 2026-04-10

## Tech Stack

- package.json: present
- Dependencies (sample): @modelcontextprotocol/sdk, axios, debug, dotenv, zod
- Dev dependencies (sample): @types/debug, @types/jest, @types/node, @typescript-eslint/eslint-plugin, @typescript-eslint/parser, eslint, husky, jest, lint-staged, ts-jest, tsx, typescript
- npm scripts (keys): build, dev, gitleaks, gitleaks:ci, lint, prepare, setup-auth, start, test, test:coverage, typecheck
- pyproject.toml: not found
- requirements.txt: not found
- README signal: # MCP Server for freee Accounting API [![CI](https://github.com/knishioka/freee-mcp/actions/workflows/ci.yml/badge.svg)](https://github.com/knishioka/freee-mcp/actions/workflows/ci.yml) [![codecov](https://codecov.io/gh/…

## Architecture / Patterns

- TypeScript MCP server for freee accounting APIs
- Tool-per-use-case design with schema validation
- Advisory / analytics surface on top of accounting data

## Competitive Landscape (notes)

- [2026-04-03] MCP TypeScript SDK: `@modelcontextprotocol/sdk` latest is **1.29.0** (source: `npm view @modelcontextprotocol/sdk version`). Consider tracking v2 migration notes when they become stable. (ref: https://github.com/modelcontextprotocol/typescript-sdk)
- [2026-04-03] MCP spec changelog highlights include OAuth2.1-based auth framework + Streamable HTTP transport + metadata enhancements (icons/annotations/tasks). (ref: https://modelcontextprotocol.io/specification/2025-11-25/changelog)

Potential feature candidates for this repo:
- Add **Streamable HTTP transport** option (in addition to stdio) for easier remote hosting.
- Ensure auth flows align with recent spec guidance (discovery / incremental consent).

## Tech Decisions (from PRs/commits)

- [2026-03-31] fix(security): pin axios to 1.14.0 to avoid compromised 1.14.1 -- ## Summary - **axios 1.14.1** was published as a malicious version containing a remote access trojan (RAT) via the `plain-crypto-js` dependency ([StepSecurity advisory](https://www.stepsecurity.io/blog/axios-compromised-on-npm-malicious-ver… (source: PR #173)
- [2026-03-06] feat(analysis): add freee_partner_analysis tool -- ## Summary - Add `freee_partner_analysis` MCP tool for partner-level revenue/expense analysis with concentration risk assessment - Aggregates deals by partner using auto-pagination, computes top N rankings with share %, monthly breakdown, a… (source: PR #172)
- [2026-03-06] feat(tools): add freee_kpi_dashboard tool -- ## Summary - Add `freee_kpi_dashboard` MCP tool that aggregates KPI data from PL, BS, and walletables in a single call - Computes profitability (operating/ordinary profit margins), safety (current/equity ratios), efficiency (receivable/paya… (source: PR #171)
- [2026-03-06] feat(advisory): add freee_cost_analysis tool -- ## Summary - Add `freee_cost_analysis` tool for expense structure analysis (費用構造分析) - Compares current vs previous year P/L data to detect YoY anomalies exceeding a configurable threshold (default 50%) - Classifies expense items as fixed or… (source: PR #170)
- [2026-03-06] feat(advisory): add freee_journal_consistency_check tool -- ## Summary - Add `freee_journal_consistency_check` tool that detects journal entry inconsistencies across deals - Detects account item inconsistencies per partner (same partner using multiple account items) - Detects tax category inconsiste… (source: PR #169)
- [2026-03-06] feat(analysis): add freee_ar_aging tool (#148) -- ## Summary - Add `freee_ar_aging` tool for accounts receivable aging analysis (売掛金エイジング分析) - Classifies unsettled income deals into aging buckets (0-30, 31-60, 61-90, 90+ days) - Aggregates by partner with oldest-days tracking for collectio… (source: PR #168)
