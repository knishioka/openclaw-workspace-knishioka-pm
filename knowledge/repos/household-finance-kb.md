# household-finance Knowledge Base

## Overview

- Repo: knishioka/household-finance
- Description: 家計管理・支出分析用リポジトリ
- Primary language (GitHub): Python
- Category / Priority: fintech / medium
- Status: active
- License: none
- Default branch: main
- Created: 2026-01-01
- Updated: 2026-03-09
- Collected: 2026-05-08

## Tech Stack

- package.json: not found (or not accessible via GitHub contents API)
- Dependencies (sample): not found
- Dev dependencies (sample): not found
- npm scripts (keys): not found
- pyproject.toml: present
- requirements.txt: present
- README signal: # Household Finance Management マレーシア在住日本人家族（夫婦＋子供3人）の家計管理・支出分析用リポジトリ。 ## Overview 複数の金融サービス（Revolut、Wise、TNG eWallet）から取引データを収集し、 月次の生活費を把握・分析することを目的としています。 **月間生活費**: 約 ¥823,000（旅行・大型購入・投資除く） - 固定費: ¥512,650（家賃、光熱費、教育費） - 変動費: ¥310,000（食費、交通費、日用品） ## Directory Structure ``` hous

## Architecture / Patterns

- Domain-model-heavy app around financial records, ledgers, or reporting flows
- Validation and transformation boundaries between raw inputs and accounting views
- Workflow emphasis on correctness, auditability, and repeatable exports/reports

## Competitive Landscape (notes)

No fresh competitive research in this run.

Potential feature candidates for this repo:
- No candidates captured yet.

## Tech Decisions (from PRs/commits)

- [2026-03-09] feat: add local JSONL data source and anomaly detection to monthly report -- exceeds 2x the 3-month average Add transaction-level anomaly detection: flags individual transactions exceeding 3x the category average Closes #21 scripts/monthly_report.py: Added load_jsonl_transactions(), detect_anomalies(), detect_transaction_anomalies()... (source: PR #27)
- [2026-03-08] feat: add transactions.jsonl and import_log.jsonl persistence -- o --output flow with --force bypass Add amount_jpy optional field and to_dict() serialization to ImportTransaction Closes #22 [x] to_dict() serialization includes all fields and is JSON-compatible [x] transactions.jsonl created on first run, deduplicates on ... (source: PR #26)
- [2026-03-08] feature: add amount_jpy auto-conversion to import pipeline -- JPY conversion summary in --dry-run output Graceful degradation: rate fetch failures set amount_jpy to None without aborting **ImportTransaction**: Add amount_jpy: Optional[float] = None field **_convert_amount_jpy()**: New helper wrapping convert_to_jpy() w... (source: PR #25)
- [2026-03-08] feature: add unit tests for categorize + import loaders (#20) -- on tests against production rules.yaml to detect regressions on rule changes Structural validation of rules.yaml (regex validity, 3-tier categories, pattern presence) **Match types**: exact, contains, regex, fuzzy (with rapidfuzz skip guard) **Field propagat... (source: PR #24)
- [2026-03-08] feature: add categorization rules and unified import pipeline -- on MCP 形式 JSON 出力 **uv run 対応**: pyproject.toml 追加。uv run python -m scripts.import_to_notion --source all --dry-run で即実行可能 **Claude Code Skill**: /import-transactions スキルを追加（ファイル検出→配置→仕分け→Notion登録） **新規データ**: Revolut (2025-12~2026-03, 177件新規) + TNG (2025-12~... (source: PR #19)
- [2026-01-04] feature: add finance import workflow -- Resolves #15. (source: PR #18)
- [2026-01-04] feat: complete notion import pipeline -- Resolves #16 This PR completes the Notion import pipeline by integrating Revolut/Wise parsing alongside TNG and implementing full Notion batch uploads. (source: PR #17)
- [2026-01-04] feature: add automated statement file detection and import -- Resolves #5. (source: PR #14)
