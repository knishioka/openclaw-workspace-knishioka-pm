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
- Collected: 2026-04-24

## Tech Stack

- package.json: not found (or not accessible via GitHub contents API)
- Dependencies (sample): not found
- Dev dependencies (sample): not found
- npm scripts (keys): not found
- pyproject.toml: present
- requirements.txt: present
- README signal: Household Finance Management マレーシア在住日本人家族（夫婦＋子供3人）の家計管理・支出分析用リポジトリ。 Overview 複数の金融サービス（Revolut、Wise、TNG eWallet）から取引データを収集し、 月次の生活費を把握・分析することを目的としています。 **月間生活費**: 約 ¥823,000（旅行・大型購入・投資除く） - 固定費: ¥512,650（家賃、光熱費、教育費） - 変動費: ¥310,000（食費、交通費、日用品） Directory Structure Data Sources

## Architecture / Patterns

- Domain logic over financial/accounting records with report-oriented output
- Emphasis on reproducible calculations and auditability over generic CRUD

## Competitive Landscape (notes)

No fresh competitive research in this run.

## Tech Decisions (from PRs/commits)

- [2026-03-09] feat: add local JSONL data source and anomaly detection to monthly report -- - Add `--source local` option to generate monthly reports from local `transactions.jsonl` file (offline, no Notion API needed) - Add category-level anomaly detection: warns when a category's monthly total exceeds 2x the 3-month average - Add transaction-level anomaly detection: flags individual transactions exceeding 3… (source: PR #27)
- [2026-03-08] feat: add transactions.jsonl and import_log.jsonl persistence -- - Add `data/processed/transactions.jsonl` persistence with `source_id` deduplication - Add `data/processed/import_log.jsonl` to track Notion import history - Integrate import log-based dedup into `--output` flow with `--force` bypass - Add `amount_jpy` optional field and `to_dict()` serialization to `ImportTransaction`… (source: PR #26)
- [2026-03-08] feature: add amount_jpy auto-conversion to import pipeline -- - Integrate `exchange_rates.convert_to_jpy()` into the import pipeline to auto-calculate `amount_jpy` for every transaction - Add `--offline` flag for cached-rates-only mode - Display per-currency JPY conversion summary in `--dry-run` output - Graceful degradation: rate fetch failures set `amount_jpy` to `None` without… (source: PR #25)
- [2026-03-08] feature: add unit tests for categorize + import loaders (#20) -- - Add comprehensive unit tests for `categorize.py` rule matching (41 tests) and `import_to_notion.py` loader functions (27 tests) - 36-payee snapshot regression tests against production `rules.yaml` to detect regressions on rule changes - Structural validation of `rules.yaml` (regex validity, 3-tier categories, pattern… (source: PR #24)
- [2026-03-08] feature: add categorization rules and unified import pipeline -- - **仕分けルール拡充**: `rules.yaml` を6ルール→45+ルールに拡張。CLAUDE.mdの全カテゴリ体系（住居/教育/食費/交通/日用品/医療/保険/行政/エンタメ/衣類 + 除外項目）を網羅 - **Import スクリプト統合**: `import_to_notion.py` を Revolut/Wise/TNG 全ソース対応の統一パイプラインに書き換え。rules.yaml ベースの自動仕分け + Notion MCP 形式 JSON 出力 - **uv run 対応**: `pyproject.toml` 追加。`uv run python -m scripts.import_to_notion --so… (source: PR #19)
- [2026-01-04] feature: add finance import workflow -- Resolves #15. Adds a /finance:import workflow script that scans Downloads, moves statement files into data/raw, updates sources.yaml, validates data, and runs categorization plus Notion import when configured. Includes skill docs and tests to cover sources.yaml updates. Background The current import workflow requires m… (source: PR #18)
- [2026-01-04] feat: complete notion import pipeline -- Resolves #16 This PR completes the Notion import pipeline by integrating Revolut/Wise parsing alongside TNG and implementing full Notion batch uploads. It adds categorization, FX conversion, and source_id deduplication so imports can run end-to-end from `import_to_notion.py`. Background `import_to_notion.py` previously… (source: PR #17)
- [2026-01-04] feature: add automated statement file detection and import -- Resolves #5. This adds a configurable watcher/import script that detects new statement files, moves them into `data/raw/`, and runs incremental imports with summaries and notifications. It reduces the manual steps in the current download-to-import workflow and provides optional Notion import hooks when configured. Back… (source: PR #14)
