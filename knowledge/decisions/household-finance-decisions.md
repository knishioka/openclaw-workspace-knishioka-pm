# household-finance Design Decisions

## 2026-03-09: feat: add local JSONL data source and anomaly detection to monthly report

- **What**: feat: add local JSONL data source and anomaly detection to monthly report
- **Why**: ## Summary - Add `--source local` option to generate monthly reports from local `transactions.jsonl` file (offline, no Notion API needed) - Add category-level anomaly detection: warns when a category's monthly total exceeds 2x the 3-month average - Add transaction-level anomaly detection: flags individual transactions exceeding 3x the category average Closes #21 ## Changes - `scripts/monthly_report.py`: Added `load_…
- **Source**: PR #27

## 2026-03-08: feat: add transactions.jsonl and import_log.jsonl persistence

- **What**: feat: add transactions.jsonl and import_log.jsonl persistence
- **Why**: ## Summary - Add `data/processed/transactions.jsonl` persistence with `source_id` deduplication - Add `data/processed/import_log.jsonl` to track Notion import history - Integrate import log-based dedup into `--output` flow with `--force` bypass - Add `amount_jpy` optional field and `to_dict()` serialization to `ImportTransaction` Closes #22 ## Test plan - [x] `to_dict()` serialization includes all fields and is JSON…
- **Source**: PR #26

## 2026-03-08: feature: add amount_jpy auto-conversion to import pipeline

- **What**: feature: add amount_jpy auto-conversion to import pipeline
- **Why**: ## Summary - Integrate `exchange_rates.convert_to_jpy()` into the import pipeline to auto-calculate `amount_jpy` for every transaction - Add `--offline` flag for cached-rates-only mode - Display per-currency JPY conversion summary in `--dry-run` output - Graceful degradation: rate fetch failures set `amount_jpy` to `None` without aborting ## Changes - **`ImportTransaction`**: Add `amount_jpy: Optional[float] = None`…
- **Source**: PR #25

## 2026-03-08: feature: add unit tests for categorize + import loaders (#20)

- **What**: feature: add unit tests for categorize + import loaders (#20)
- **Why**: ## Summary - Add comprehensive unit tests for `categorize.py` rule matching (41 tests) and `import_to_notion.py` loader functions (27 tests) - 36-payee snapshot regression tests against production `rules.yaml` to detect regressions on rule changes - Structural validation of `rules.yaml` (regex validity, 3-tier categories, pattern presence) ## Test Coverage ### `tests/test_categorize.py` (41 tests) - **Match types**:…
- **Source**: PR #24

## 2026-03-08: feature: add categorization rules and unified import pipeline

- **What**: feature: add categorization rules and unified import pipeline
- **Why**: ## Summary - **仕分けルール拡充**: `rules.yaml` を6ルール→45+ルールに拡張。CLAUDE.mdの全カテゴリ体系（住居/教育/食費/交通/日用品/医療/保険/行政/エンタメ/衣類 + 除外項目）を網羅 - **Import スクリプト統合**: `import_to_notion.py` を Revolut/Wise/TNG 全ソース対応の統一パイプラインに書き換え。rules.yaml ベースの自動仕分け + Notion MCP 形式 JSON 出力 - **uv run 対応**: `pyproject.toml` 追加。`uv run python -m scripts.import_to_notion --source all --dry-run` で即実行可能 - **Claude Code Skill**: `/import-transactions` スキルを追加（ファイル検出…
- **Source**: PR #19

## 2026-01-04: feature: add finance import workflow

- **What**: feature: add finance import workflow
- **Why**: ## Summary Resolves #15. Adds a /finance:import workflow script that scans Downloads, moves statement files into data/raw, updates sources.yaml, validates data, and runs categorization plus Notion import when configured. Includes skill docs and tests to cover sources.yaml updates. ## Background The current import workflow requires multiple manual steps to identify files, move them to the right directory, run validat…
- **Source**: PR #18

## 2026-01-04: feat: complete notion import pipeline

- **What**: feat: complete notion import pipeline
- **Why**: ## Summary Resolves #16 This PR completes the Notion import pipeline by integrating Revolut/Wise parsing alongside TNG and implementing full Notion batch uploads. It adds categorization, FX conversion, and source_id deduplication so imports can run end-to-end from `import_to_notion.py`. ## Background `import_to_notion.py` previously only parsed TNG and stopped at a stub message, leaving Revolut/Wise support split in…
- **Source**: PR #17

## 2026-01-04: feature: add automated statement file detection and import

- **What**: feature: add automated statement file detection and import
- **Why**: ## Summary Resolves #5. This adds a configurable watcher/import script that detects new statement files, moves them into `data/raw/`, and runs incremental imports with summaries and notifications. It reduces the manual steps in the current download-to-import workflow and provides optional Notion import hooks when configured. ## Background The current workflow requires manually moving downloaded statements into the c…
- **Source**: PR #14
