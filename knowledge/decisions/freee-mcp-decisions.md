# freee-mcp Design Decisions

## 2026-03-06: feat(tools): add freee_account_item_context tool

- **What**: feat(tools): add freee_account_item_context tool
- **Why**: ## Summary - Add `freee_account_item_context` MCP tool that provides account item (勘定科目) recommendation context for transactions - Analyzes past deal patterns by partner, aggregates usage frequency, finds similar amounts, and enriches with
- **Source**: PR #166

## 2026-03-06: feat(advisory): add freee_accounting_policy_context tool

- **What**: feat(advisory): add freee_accounting_policy_context tool
- **Why**: - Add `freee_accounting_policy_context` MCP tool that provides accounting policy context for decision support (#146) - Returns similar past journal patterns from general ledger, fixed asset capitalization patterns, and relevant account item
- **Source**: PR #165

## 2026-03-06: feat(advisory): add freee_item_suggestion_context tool

- **What**: feat(advisory): add freee_item_suggestion_context tool
- **Why**: - Add `freee_item_suggestion_context` MCP tool that provides item (品目) suggestion context based on partner transaction history - Fetches item master list and aggregates item usage from past deals with a specified partner - Returns recommend
- **Source**: PR #164

## 2026-03-06: feat(advisory): add freee_master_context tool for bulk master data retrieval

- **What**: feat(advisory): add freee_master_context tool for bulk master data retrieval
- **Why**: - Add `freee_master_context` tool that bulk-fetches all master/reference data (account items, tags, sections, segments, items, partners) in a single call using `Promise.all` with caching - Supports optional `include` parameter to fetch only
- **Source**: PR #163

## 2026-03-06: feat(reports): add freee_multiyear_comparison tool

- **What**: feat(reports): add freee_multiyear_comparison tool
- **Why**: - Add `freee_multiyear_comparison` MCP tool that leverages freee's native multi-year trial balance APIs (`trial_pl_two_years`, `trial_pl_three_years`, `trial_bs_two_years`, `trial_bs_three_years`) - Supports 2-year and 3-year comparisons fo
- **Source**: PR #162

## 2026-03-06: feat(reports): add freee_get_general_ledger tool for 総勘定元帳

- **What**: feat(reports): add freee_get_general_ledger tool for 総勘定元帳
- **Why**: - Add `freee_get_general_ledger` MCP tool to retrieve general ledger (総勘定元帳) data from freee API endpoint `GET /api/1/reports/general_ledgers` - Support filtering by `account_item_id` to reduce response size - Support `compact` mode that re
- **Source**: PR #161
