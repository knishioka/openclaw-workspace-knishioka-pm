# freee-mcp Design Decisions

## 2026-04-16: refactor(schema): migrate tool registration to Zod 4

- **What**: refactor(schema): migrate tool registration to Zod 4
- **Why**: - upgrade `zod` from `^3.25.28` to `^4.3.6` and refresh the lockfile - replace the `any`-based `registerTool` shim with a typed generic wrapper while keeping tool names and input argument names unchanged - update focused regression tests for the new Zod v4 pac…
- **Source**: PR #176

## 2026-03-31: fix(security): pin axios to 1.14.0 to avoid compromised 1.14.1

- **What**: fix(security): pin axios to 1.14.0 to avoid compromised 1.14.1
- **Why**: No summary captured.
- **Source**: PR #173

## 2026-03-06: feat(analysis): add freee_partner_analysis tool

- **What**: feat(analysis): add freee_partner_analysis tool
- **Why**: No summary captured.
- **Source**: PR #172

## 2026-03-06: feat(tools): add freee_kpi_dashboard tool

- **What**: feat(tools): add freee_kpi_dashboard tool
- **Why**: - Add `freee_kpi_dashboard` MCP tool that aggregates KPI data from PL, BS, and walletables in a single call - Computes profitability (operating/ordinary profit margins), safety (current/equity ratios), efficiency (receivable/payable turnover days), and liquidi…
- **Source**: PR #171

## 2026-03-06: feat(advisory): add freee_cost_analysis tool

- **What**: feat(advisory): add freee_cost_analysis tool
- **Why**: - Add `freee_cost_analysis` tool for expense structure analysis (費用構造分析) - Compares current vs previous year P/L data to detect YoY anomalies exceeding a configurable threshold (default 50%) - Classifies expense items as fixed or variable costs based on Japane…
- **Source**: PR #170

## 2026-03-06: feat(advisory): add freee_journal_consistency_check tool

- **What**: feat(advisory): add freee_journal_consistency_check tool
- **Why**: No summary captured.
- **Source**: PR #169

## 2026-03-06: feat(analysis): add freee_ar_aging tool (#148)

- **What**: feat(analysis): add freee_ar_aging tool (#148)
- **Why**: No summary captured.
- **Source**: PR #168

## 2026-03-06: feat(advisory): add freee_tagging_consistency_check tool

- **What**: feat(advisory): add freee_tagging_consistency_check tool
- **Why**: No summary captured.
- **Source**: PR #167
