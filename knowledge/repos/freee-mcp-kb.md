# freee-mcp Knowledge Base

## Overview

- Repo: knishioka/freee-mcp
- Description: MCP server for freee accounting API integration
- Primary language (GitHub): TypeScript
- License: MIT
- Default branch: main
- Created: 2025-05-26
- Updated: 2026-03-06
- Collected: 2026-03-27

## Tech Stack

- package.json: present
- Dependencies (sample): @modelcontextprotocol/sdk, axios, debug, dotenv, zod
- Dev dependencies (sample): @types/debug, @types/jest, @types/node, @typescript-eslint/eslint-plugin, @typescript-eslint/parser, eslint, husky, jest, lint-staged, ts-jest, tsx, typescript
- npm scripts (keys): build, dev, gitleaks, gitleaks:ci, lint, prepare, setup-auth, start, test, test:coverage, typecheck
- pyproject.toml: not found
- requirements.txt: not found

## Architecture / Patterns

- MCP server / tool integration
- Runtime schema validation
- CLI-style usage

## Tech Decisions (from PRs/commits)

- [2026-03-06] feat(analysis): add freee_partner_analysis tool -- - Add `freee_partner_analysis` MCP tool for partner-level revenue/expense analysis with concentration risk assessment - Aggregates deals by partner using auto-pagination, computes top N rankings with share %, monthly breakdown, and concentr (source: PR #172)
- [2026-03-06] feat(tools): add freee_kpi_dashboard tool -- ## Summary - Add `freee_kpi_dashboard` MCP tool that aggregates KPI data from PL, BS, and walletables in a single call - Computes profitability (operating/ordinary profit margins), safety (current/equity ratios), efficiency (receivable/paya (source: PR #171)
- [2026-03-06] feat(advisory): add freee_cost_analysis tool -- ## Summary - Add `freee_cost_analysis` tool for expense structure analysis (費用構造分析) - Compares current vs previous year P/L data to detect YoY anomalies exceeding a configurable threshold (default 50%) - Classifies expense items as fixed or (source: PR #170)
- [2026-03-06] feat(advisory): add freee_journal_consistency_check tool -- - Add `freee_journal_consistency_check` tool that detects journal entry inconsistencies across deals - Detects account item inconsistencies per partner (same partner using multiple account items) - Detects tax category inconsistencies withi (source: PR #169)
- [2026-03-06] feat(analysis): add freee_ar_aging tool (#148) -- - Add `freee_ar_aging` tool for accounts receivable aging analysis (売掛金エイジング分析) - Classifies unsettled income deals into aging buckets (0-30, 31-60, 61-90, 90+ days) - Aggregates by partner with oldest-days tracking for collection prioritiz (source: PR #168)
- [2026-03-06] feat(advisory): add freee_tagging_consistency_check tool -- Implements #144 - タグ付け一貫性チェックツール (source: PR #167)
