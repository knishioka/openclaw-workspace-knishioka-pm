# freee-mcp Design Decisions

## 2026-05-05: migrate Jest suite to Vitest

- **What**: migrate Jest suite to Vitest
- **Why**: Jest + ts-jest のテスト実行環境を Vitest 3 に移行し、ESM/TypeScript 向けの設定を簡素化しました。既存テストの振る舞いは維持しつつ、テストスクリプトとカバレッジ生成を Vitest ベースに更新しています。
- **Source**: PR #180

## 2026-04-29: add structured dashboard output

- **What**: add structured dashboard output
- **Why**: Upgrade @modelcontextprotocol/sdk to ^1.29.0.
- **Source**: PR #178

## 2026-04-16: migrate tool registration to Zod 4

- **What**: migrate tool registration to Zod 4
- **Why**: upgrade zod from ^3.25.28 to ^4.3.6 and refresh the lockfile replace the any-based registerTool shim with a typed generic wrapper while keeping tool names and input argument names unchanged update focused regression tests for the new Zod v4 package version and
- **Source**: PR #176

## 2026-03-31: pin axios to 1.14.0 to avoid compromised 1.14.1

- **What**: pin axios to 1.14.0 to avoid compromised 1.14.1
- **Why**: sed-on-npm-malicious-versions-drop-remote-access-trojan)) This project previously used "axios": "^1.9.0" which could auto-resolve to the compromised 1.14.1 Pins axios to exact version 1.14.0 (last known safe release) by removing the caret range package.json:...
- **Source**: PR #173

## 2026-03-06: add freee_partner_analysis tool

- **What**: add freee_partner_analysis tool
- **Why**: re %, monthly breakdown, and concentration risk levels (low/medium/high) Resolves #150 | File | Change | |---|---| | src/schemas.ts | Add PartnerAnalysisSchema | | src/types/freee.ts | Add PartnerAnalysisResult, PartnerAnalysisItem, ConcentrationRisk types |...
- **Source**: PR #172

## 2026-03-06: add freee_kpi_dashboard tool

- **What**: add freee_kpi_dashboard tool
- **Why**: ency (receivable/payable turnover days), and liquidity (cash balance, working capital) metrics Includes health status indicators (healthy/caution/warning) with configurable thresholds Closes #149 src/types/freee.ts: Add KpiMetric, KpiDashboardResult, `KpiSta...
- **Source**: PR #171

## 2026-03-06: add freee_cost_analysis tool

- **What**: add freee_cost_analysis tool
- **Why**: ies expense items as fixed or variable costs based on Japanese account name patterns Supports monthly or cumulative year-to-date analysis Closes #151 src/schemas.ts: Add CostAnalysisSchema with companyId, fiscalYear, month, threshold fields `src/types/freee....
- **Source**: PR #170

## 2026-03-06: add freee_journal_consistency_check tool

- **What**: add freee_journal_consistency_check tool
- **Why**: x category inconsistencies within same partner+account combination Results sorted by severity with actionable recommendations Closes #147 | File | Change | |------|--------| | src/types/freee.ts | Add AccountItemInconsistency, TaxCategoryInconsistency, `Jour...
- **Source**: PR #169

## 2026-03-06: add freee_ar_aging tool (#148)

- **What**: add freee_ar_aging tool (#148)
- **Why**: ays tracking for collection prioritization Highlights long-overdue (61+ days) receivables in summary | File | Change | |------|--------| | src/types/freee.ts | Add ArAgingBucket, ArAgingPartner, ArAgingResult types | | src/schemas.ts | Add ArAgingSchema with...
- **Source**: PR #168

## 2026-03-06: add freee_tagging_consistency_check tool

- **What**: add freee_tagging_consistency_check tool
- **Why**: Implements #144 - タグ付け一貫性チェックツール 取引のタグ・セグメント付与の一貫性を分析し、揺れ・漏れを検出するツール。
- **Source**: PR #167
