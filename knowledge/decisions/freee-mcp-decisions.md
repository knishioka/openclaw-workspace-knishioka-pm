# freee-mcp Design Decisions

## 2026-03-06: feat(analysis): add freee_partner_analysis tool

- **What**: feat(analysis): add freee_partner_analysis tool
- **Why**: - Add `freee_partner_analysis` MCP tool for partner-level revenue/expense analysis with concentration risk assessment - Aggregates deals by partner using auto-pagination, computes top N rankings with share %, monthly breakdown, and concentr 
- **Source**: PR #172

## 2026-03-06: feat(tools): add freee_kpi_dashboard tool

- **What**: feat(tools): add freee_kpi_dashboard tool
- **Why**: ## Summary - Add `freee_kpi_dashboard` MCP tool that aggregates KPI data from PL, BS, and walletables in a single call - Computes profitability (operating/ordinary profit margins), safety (current/equity ratios), efficiency (receivable/paya 
- **Source**: PR #171

## 2026-03-06: feat(advisory): add freee_cost_analysis tool

- **What**: feat(advisory): add freee_cost_analysis tool
- **Why**: ## Summary - Add `freee_cost_analysis` tool for expense structure analysis (費用構造分析) - Compares current vs previous year P/L data to detect YoY anomalies exceeding a configurable threshold (default 50%) - Classifies expense items as fixed or 
- **Source**: PR #170

## 2026-03-06: feat(advisory): add freee_journal_consistency_check tool

- **What**: feat(advisory): add freee_journal_consistency_check tool
- **Why**: - Add `freee_journal_consistency_check` tool that detects journal entry inconsistencies across deals - Detects account item inconsistencies per partner (same partner using multiple account items) - Detects tax category inconsistencies withi 
- **Source**: PR #169

## 2026-03-06: feat(analysis): add freee_ar_aging tool (#148)

- **What**: feat(analysis): add freee_ar_aging tool (#148)
- **Why**: - Add `freee_ar_aging` tool for accounts receivable aging analysis (売掛金エイジング分析) - Classifies unsettled income deals into aging buckets (0-30, 31-60, 61-90, 90+ days) - Aggregates by partner with oldest-days tracking for collection prioritiz 
- **Source**: PR #168

## 2026-03-06: feat(advisory): add freee_tagging_consistency_check tool

- **What**: feat(advisory): add freee_tagging_consistency_check tool
- **Why**: Implements #144 - タグ付け一貫性チェックツール 
- **Source**: PR #167
