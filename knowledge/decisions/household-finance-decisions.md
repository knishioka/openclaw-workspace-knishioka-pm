# household-finance Design Decisions

## 2026-03-09: feat: add local JSONL data source and anomaly detection to monthly report

- **What**: feat: add local JSONL data source and anomaly detection to monthly report
- **Why**: - Add `--source local` option to generate monthly reports from local `transactions.jsonl` file (offline, no Notion API needed) - Add category-level anomaly detection: warns when a category's monthly total exceeds 2x the 3-month average - Ad
- **Source**: PR #27

## 2026-03-08: feat: add transactions.jsonl and import_log.jsonl persistence

- **What**: feat: add transactions.jsonl and import_log.jsonl persistence
- **Why**: - Add `data/processed/transactions.jsonl` persistence with `source_id` deduplication - Add `data/processed/import_log.jsonl` to track Notion import history - Integrate import log-based dedup into `--output` flow with `--force` bypass - Add  
- **Source**: PR #26

## 2026-03-08: feature: add unit tests for categorize + import loaders (#20)

- **What**: feature: add unit tests for categorize + import loaders (#20)
- **Why**: - Add comprehensive unit tests for `categorize.py` rule matching (41 tests) and `import_to_notion.py` loader functions (27 tests) - 36-payee snapshot regression tests against production `rules.yaml` to detect regressions on rule changes - S
- **Source**: PR #24

## 2026-03-08: feature: add categorization rules and unified import pipeline

- **What**: feature: add categorization rules and unified import pipeline
- **Why**: - **仕分けルール拡充**: `rules.yaml` を6ルール→45+ルールに拡張。CLAUDE.mdの全カテゴリ体系（住居/教育/食費/交通/日用品/医療/保険/行政/エンタメ/衣類 + 除外項目）を網羅 - **Import スクリプト統合**: `import_to_notion.py` を Revolut/Wise/TNG 全ソース対応の統一パイプラインに書き換え。rules.yaml ベースの自動仕分け + Notion MCP 形式 JSON 出力 - **
- **Source**: PR #19

## 2026-01-04: feature: add finance import workflow

- **What**: feature: add finance import workflow
- **Why**: Resolves #15. Adds a /finance:import workflow script that scans Downloads, moves statement files into data/raw, updates sources.yaml, validates data, and runs categorization plus Notion import when configured. Includes skill docs and tests  
- **Source**: PR #18

## 2026-01-04: feat: complete notion import pipeline

- **What**: feat: complete notion import pipeline
- **Why**: This PR completes the Notion import pipeline by integrating Revolut/Wise parsing alongside TNG and implementing full Notion batch uploads. It adds categorization, FX conversion, and source_id deduplication so imports can run end-to-end from
- **Source**: PR #17
