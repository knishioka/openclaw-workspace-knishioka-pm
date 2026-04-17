# freee-mcp Design Decisions

## 2026-04-16: refactor(schema): migrate tool registration to Zod 4

- **What**: refactor(schema): migrate tool registration to Zod 4
- **Why**: ## Summary - upgrade `zod` from `^3.25.28` to `^4.3.6` and refresh the lockfile - replace the `any`-based `registerTool` shim with a typed generic wrapper while keeping tool names and input argument names unchanged - update focused regression tests for the new Zod v4 package version and raw schema shape typing ## Verification - `npm test` ✅ - `npm run build` ✅ - `npm run lint` ✅ (existing warning-only `no-explicit-a…
- **Source**: PR #176

## 2026-03-31: fix(security): pin axios to 1.14.0 to avoid compromised 1.14.1

- **What**: fix(security): pin axios to 1.14.0 to avoid compromised 1.14.1
- **Why**: ## Summary - **axios 1.14.1** was published as a malicious version containing a remote access trojan (RAT) via the `plain-crypto-js` dependency ([StepSecurity advisory](https://www.stepsecurity.io/blog/axios-compromised-on-npm-malicious-versions-drop-remote-access-trojan)) - This project previously used `"axios": "^1.9.0"` which could auto-resolve to the compromised 1.14.1 - Pins axios to exact version `1.14.0` (las…
- **Source**: PR #173

## 2026-03-06: feat(analysis): add freee_partner_analysis tool

- **What**: feat(analysis): add freee_partner_analysis tool
- **Why**: ## Summary - Add `freee_partner_analysis` MCP tool for partner-level revenue/expense analysis with concentration risk assessment - Aggregates deals by partner using auto-pagination, computes top N rankings with share %, monthly breakdown, and concentration risk levels (low/medium/high) - Resolves #150 ## Changes | File | Change | |---|---| | `src/schemas.ts` | Add `PartnerAnalysisSchema` | | `src/types/freee.ts` | A…
- **Source**: PR #172

## 2026-03-06: feat(tools): add freee_kpi_dashboard tool

- **What**: feat(tools): add freee_kpi_dashboard tool
- **Why**: ## Summary - Add `freee_kpi_dashboard` MCP tool that aggregates KPI data from PL, BS, and walletables in a single call - Computes profitability (operating/ordinary profit margins), safety (current/equity ratios), efficiency (receivable/payable turnover days), and liquidity (cash balance, working capital) metrics - Includes health status indicators (healthy/caution/warning) with configurable thresholds Closes #149 ##…
- **Source**: PR #171

## 2026-03-06: feat(advisory): add freee_cost_analysis tool

- **What**: feat(advisory): add freee_cost_analysis tool
- **Why**: ## Summary - Add `freee_cost_analysis` tool for expense structure analysis (費用構造分析) - Compares current vs previous year P/L data to detect YoY anomalies exceeding a configurable threshold (default 50%) - Classifies expense items as fixed or variable costs based on Japanese account name patterns - Supports monthly or cumulative year-to-date analysis Closes #151 ## Changes - `src/schemas.ts`: Add `CostAnalysisSchema` …
- **Source**: PR #170

## 2026-03-06: feat(advisory): add freee_journal_consistency_check tool

- **What**: feat(advisory): add freee_journal_consistency_check tool
- **Why**: ## Summary - Add `freee_journal_consistency_check` tool that detects journal entry inconsistencies across deals - Detects account item inconsistencies per partner (same partner using multiple account items) - Detects tax category inconsistencies within same partner+account combination - Results sorted by severity with actionable recommendations Closes #147 ## Changes | File | Change | |------|--------| | `src/types/…
- **Source**: PR #169

## 2026-03-06: feat(analysis): add freee_ar_aging tool (#148)

- **What**: feat(analysis): add freee_ar_aging tool (#148)
- **Why**: ## Summary - Add `freee_ar_aging` tool for accounts receivable aging analysis (売掛金エイジング分析) - Classifies unsettled income deals into aging buckets (0-30, 31-60, 61-90, 90+ days) - Aggregates by partner with oldest-days tracking for collection prioritization - Highlights long-overdue (61+ days) receivables in summary ## Changes | File | Change | |------|--------| | `src/types/freee.ts` | Add `ArAgingBucket`, `ArAgingP…
- **Source**: PR #168

## 2026-03-06: feat(advisory): add freee_tagging_consistency_check tool

- **What**: feat(advisory): add freee_tagging_consistency_check tool
- **Why**: ## Summary Implements #144 - タグ付け一貫性チェックツール 取引のタグ・セグメント付与の一貫性を分析し、揺れ・漏れを検出するツール。 - **取引先別タグ不統一検出**: 同一取引先で異なるタグパターン、タグ未付与を検出 - **セグメント未設定検出**: 部門(section_id)が未設定の取引明細を検出 - **勘定科目別タグ逸脱検出**: 各勘定科目の多数派タグパターンからの逸脱を検出 ### Changes | File | Change | |------|--------| | `src/types/freee.ts` | Add `TaggingConsistencyResult` and related types | | `src/schemas.ts` | Add `TaggingConsistencyCheckSchema` | | `src/api/freeeClient.…
- **Source**: PR #167
