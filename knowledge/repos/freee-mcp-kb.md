# freee-mcp Knowledge Base

## Overview

- Repo: knishioka/freee-mcp
- Description: MCP server for freee accounting API integration
- Primary language (GitHub): TypeScript
- License: MIT
- Default branch: main
- Created: 2025-05-26
- Updated: 2026-05-06
- Collected: 2026-05-22

## Tech Stack

- package.json: present
- Dependencies (sample): @modelcontextprotocol/sdk, axios, debug, dotenv, zod
- Dev dependencies (sample): @types/debug, @types/node, @typescript-eslint/eslint-plugin, @typescript-eslint/parser, @vitest/coverage-v8, eslint, husky, lint-staged, tsx, typescript, vitest
- npm scripts (keys): build, dev, gitleaks, gitleaks:ci, lint, prepare, setup-auth, start, test, test:coverage, typecheck
- pyproject.toml: not found
- requirements.txt: not found

## Architecture / Patterns

- MCP server / tool integration
- Runtime schema validation
- CLI-style usage

## Tech Decisions (from PRs/commits)

- [2026-03-06] feat(tools): add freee_account_item_context tool -- ## Summary - Add `freee_account_item_context` MCP tool that provides account item (勘定科目) recommendation context for transactions - Analyzes past deal patterns by partner, aggregates usage frequency, finds similar amounts, and enriches with  (source: PR #166)
- [2026-03-06] feat(advisory): add freee_accounting_policy_context tool -- - Add `freee_accounting_policy_context` MCP tool that provides accounting policy context for decision support (#146) - Returns similar past journal patterns from general ledger, fixed asset capitalization patterns, and relevant account item (source: PR #165)
- [2026-03-06] feat(advisory): add freee_item_suggestion_context tool -- - Add `freee_item_suggestion_context` MCP tool that provides item (品目) suggestion context based on partner transaction history - Fetches item master list and aggregates item usage from past deals with a specified partner - Returns recommend (source: PR #164)
- [2026-03-06] feat(advisory): add freee_master_context tool for bulk master data retrieval -- - Add `freee_master_context` tool that bulk-fetches all master/reference data (account items, tags, sections, segments, items, partners) in a single call using `Promise.all` with caching - Supports optional `include` parameter to fetch only (source: PR #163)
- [2026-03-06] feat(reports): add freee_multiyear_comparison tool -- - Add `freee_multiyear_comparison` MCP tool that leverages freee's native multi-year trial balance APIs (`trial_pl_two_years`, `trial_pl_three_years`, `trial_bs_two_years`, `trial_bs_three_years`) - Supports 2-year and 3-year comparisons fo (source: PR #162)
- [2026-03-06] feat(reports): add freee_get_general_ledger tool for 総勘定元帳 -- - Add `freee_get_general_ledger` MCP tool to retrieve general ledger (総勘定元帳) data from freee API endpoint `GET /api/1/reports/general_ledgers` - Support filtering by `account_item_id` to reduce response size - Support `compact` mode that re (source: PR #161)
