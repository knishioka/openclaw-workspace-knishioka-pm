# household-finance Design Decisions

## 2026-03-09: add local JSONL data source and anomaly detection to monthly report

- **What**: add local JSONL data source and anomaly detection to monthly report
- **Why**: exceeds 2x the 3-month average Add transaction-level anomaly detection: flags individual transactions exceeding 3x the category average Closes #21 scripts/monthly_report.py: Added load_jsonl_transactions(), detect_anomalies(), detect_transaction_anomalies()...
- **Source**: PR #27

## 2026-03-08: add transactions.jsonl and import_log.jsonl persistence

- **What**: add transactions.jsonl and import_log.jsonl persistence
- **Why**: o --output flow with --force bypass Add amount_jpy optional field and to_dict() serialization to ImportTransaction Closes #22 [x] to_dict() serialization includes all fields and is JSON-compatible [x] transactions.jsonl created on first run, deduplicates on ...
- **Source**: PR #26

## 2026-03-08: feature: add amount_jpy auto-conversion to import pipeline

- **What**: feature: add amount_jpy auto-conversion to import pipeline
- **Why**: JPY conversion summary in --dry-run output Graceful degradation: rate fetch failures set amount_jpy to None without aborting **ImportTransaction**: Add amount_jpy: Optional[float] = None field **_convert_amount_jpy()**: New helper wrapping convert_to_jpy() w...
- **Source**: PR #25

## 2026-03-08: feature: add unit tests for categorize + import loaders (#20)

- **What**: feature: add unit tests for categorize + import loaders (#20)
- **Why**: on tests against production rules.yaml to detect regressions on rule changes Structural validation of rules.yaml (regex validity, 3-tier categories, pattern presence) **Match types**: exact, contains, regex, fuzzy (with rapidfuzz skip guard) **Field propagat...
- **Source**: PR #24

## 2026-03-08: feature: add categorization rules and unified import pipeline

- **What**: feature: add categorization rules and unified import pipeline
- **Why**: on MCP 形式 JSON 出力 **uv run 対応**: pyproject.toml 追加。uv run python -m scripts.import_to_notion --source all --dry-run で即実行可能 **Claude Code Skill**: /import-transactions スキルを追加（ファイル検出→配置→仕分け→Notion登録） **新規データ**: Revolut (2025-12~2026-03, 177件新規) + TNG (2025-12~...
- **Source**: PR #19

## 2026-01-04: feature: add finance import workflow

- **What**: feature: add finance import workflow
- **Why**: Resolves #15.
- **Source**: PR #18

## 2026-01-04: complete notion import pipeline

- **What**: complete notion import pipeline
- **Why**: Resolves #16 This PR completes the Notion import pipeline by integrating Revolut/Wise parsing alongside TNG and implementing full Notion batch uploads.
- **Source**: PR #17

## 2026-01-04: feature: add automated statement file detection and import

- **What**: feature: add automated statement file detection and import
- **Why**: Resolves #5.
- **Source**: PR #14

## 2026-01-04: feature: add data validation and anomaly detection

- **What**: feature: add data validation and anomaly detection
- **Why**: Resolves #7 This PR adds a pre-import validation and anomaly detection pass that surfaces data quality issues before Notion import.
- **Source**: PR #13

## 2026-01-04: feature: add uncategorized review CLI

- **What**: feature: add uncategorized review CLI
- **Why**: Resolves #4.
- **Source**: PR #12
