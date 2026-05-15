# freee-mcp Design Decisions

Updated: 2026-05-15

## 2026-05-05: test: migrate Jest suite to Vitest

- **What**: ## 概要 Jest + ts-jest のテスト実行環境を Vitest 3 に移行し、ESM/TypeScript 向けの設定を簡素化しました。既存テストの振る舞いは維持しつつ、テストスクリプトとカバレッジ生成を Vitest ベースに更新しています。 Closes #179 ## 変更内容 - `package.json` / `package-...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #180

## 2026-04-29: feat(kpi): add structured dashboard output

- **What**: ## Summary - Upgrade @modelcontextprotocol/sdk to ^1.29.0. - Return structuredContent from freee_kpi_dashboard with company_id, period, and profitability / safety / efficiency /...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #178

## 2026-04-16: refactor(schema): migrate tool registration to Zod 4

- **What**: ## Summary - upgrade `zod` from `^3.25.28` to `^4.3.6` and refresh the lockfile - replace the `any`-based `registerTool` shim with a typed generic wrapper while keeping tool...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #176

## 2026-03-31: fix(security): pin axios to 1.14.0 to avoid compromised 1.14.1

- **What**: ## Summary - **axios 1.14.1** was published as a malicious version containing a remote access trojan (RAT) via the `plain-crypto-js` dependency ([StepSecurity...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #173

## 2026-03-06: feat(analysis): add freee_partner_analysis tool

- **What**: ## Summary - Add `freee_partner_analysis` MCP tool for partner-level revenue/expense analysis with concentration risk assessment - Aggregates deals by partner using auto-...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #172

## 2026-03-06: feat(tools): add freee_kpi_dashboard tool

- **What**: ## Summary - Add `freee_kpi_dashboard` MCP tool that aggregates KPI data from PL, BS, and walletables in a single call - Computes profitability (operating/ordinary profit...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #171

## 2026-03-06: feat(advisory): add freee_cost_analysis tool

- **What**: ## Summary - Add `freee_cost_analysis` tool for expense structure analysis (費用構造分析) - Compares current vs previous year P/L data to detect YoY anomalies exceeding a configurable...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #170

## 2026-03-06: feat(advisory): add freee_journal_consistency_check tool

- **What**: ## Summary - Add `freee_journal_consistency_check` tool that detects journal entry inconsistencies across deals - Detects account item inconsistencies per partner (same partner...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #169

## 2026-03-06: feat(analysis): add freee_ar_aging tool (#148)

- **What**: ## Summary - Add `freee_ar_aging` tool for accounts receivable aging analysis (売掛金エイジング分析) - Classifies unsettled income deals into aging buckets (0-30, 31-60, 61-90, 90+ days)...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #168

## 2026-03-06: feat(advisory): add freee_tagging_consistency_check tool

- **What**: ## Summary Implements #144 - タグ付け一貫性チェックツール 取引のタグ・セグメント付与の一貫性を分析し、揺れ・漏れを検出するツール。 - **取引先別タグ不統一検出**: 同一取引先で異なるタグパターン、タグ未付与を検出 - **セグメント未設定検出**: 部門(section_id)が未設定の取引明細を検出 -...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #167
