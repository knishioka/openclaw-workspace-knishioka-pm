# household-finance Design Decisions

Updated: 2026-05-15

## 2026-03-09: feat: add local JSONL data source and anomaly detection to monthly report

- **What**: ## Summary - Add `--source local` option to generate monthly reports from local `transactions.jsonl` file (offline, no Notion API needed) - Add category-level anomaly detection:...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #27

## 2026-03-08: feat: add transactions.jsonl and import_log.jsonl persistence

- **What**: ## Summary - Add `data/processed/transactions.jsonl` persistence with `source_id` deduplication - Add `data/processed/import_log.jsonl` to track Notion import history -...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #26

## 2026-03-08: feature: add amount_jpy auto-conversion to import pipeline

- **What**: ## Summary - Integrate `exchange_rates.convert_to_jpy()` into the import pipeline to auto-calculate `amount_jpy` for every transaction - Add `--offline` flag for cached-rates-...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #25

## 2026-03-08: feature: add unit tests for categorize + import loaders (#20)

- **What**: ## Summary - Add comprehensive unit tests for `categorize.py` rule matching (41 tests) and `import_to_notion.py` loader functions (27 tests) - 36-payee snapshot regression tests...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #24

## 2026-03-08: feature: add categorization rules and unified import pipeline

- **What**: ## Summary - **仕分けルール拡充**: `rules.yaml` を6ルール→45+ルールに拡張。CLAUDE.mdの全カテゴリ体系（住居/教育/食費/交通/日用品/医療/保険/行政/エンタメ/衣類 + 除外項目）を網羅 - **Import スクリプト統合**: `import_to_notion.py` を...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #19

## 2026-01-04: feature: add finance import workflow

- **What**: ## Summary Resolves #15. Adds a /finance:import workflow script that scans Downloads, moves statement files into data/raw, updates sources.yaml, validates data, and runs...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #18

## 2026-01-04: feat: complete notion import pipeline

- **What**: ## Summary Resolves #16 This PR completes the Notion import pipeline by integrating Revolut/Wise parsing alongside TNG and implementing full Notion batch uploads. It adds...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #17

## 2026-01-04: feature: add automated statement file detection and import

- **What**: ## Summary Resolves #5. This adds a configurable watcher/import script that detects new statement files, moves them into `data/raw/`, and runs incremental imports with summaries...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #14

## 2026-01-04: feature: add data validation and anomaly detection

- **What**: ## Summary Resolves #7 This PR adds a pre-import validation and anomaly detection pass that surfaces data quality issues before Notion import. It integrates validation into the...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #13

## 2026-01-04: feature: add uncategorized review CLI

- **What**: ## Summary Resolves #4. Adds an interactive CLI for reviewing uncategorized transactions with category shortcuts, batch updates, rule preview/creation, and session resume...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #12
