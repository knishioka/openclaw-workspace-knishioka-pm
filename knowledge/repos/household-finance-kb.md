# household-finance Knowledge Base

## Overview

- Repo: knishioka/household-finance
- Description: Household finance management and expense analysis
- Primary language (GitHub): Python
- Category / Priority: fintech / medium
- Status: active
- License: none
- Default branch: main
- Created: 2026-01-01
- Updated: 2026-03-09
- Collected: 2026-05-15

## Tech Stack

- Runtime dependencies: none detected
- pyproject.toml: present
- requirements.txt: present
- README signal: # Household Finance Management マレーシア在住日本人家族（夫婦＋子供3人）の家計管理・支出分析用リポジトリ。 ## Overview 複数の金融サービス（Revolut、Wise、TNG eWallet）から取引データを収集し、 月次の生活費を把握・分析することを目的としています。 **月間生活費**: 約 ¥823,000（旅行・大型購入・投資除く） - 固定費:...

## Architecture / Patterns

- Financial data workflows need deterministic calculations, auditability, and careful domain terminology.

## Competitive Landscape (notes)

No competitive research captured in this weekly rotation.

## Tech Decisions (from recent PRs/commits)

- [2026-03-09] feat: add local JSONL data source and anomaly detection to monthly report -- ## Summary - Add `--source local` option to generate monthly reports from local `transactions.jsonl` file (offline, no Notion API needed) - Add category-level anomaly detection:... (source: PR #27)
- [2026-03-08] feat: add transactions.jsonl and import_log.jsonl persistence -- ## Summary - Add `data/processed/transactions.jsonl` persistence with `source_id` deduplication - Add `data/processed/import_log.jsonl` to track Notion import history -... (source: PR #26)
- [2026-03-08] feature: add amount_jpy auto-conversion to import pipeline -- ## Summary - Integrate `exchange_rates.convert_to_jpy()` into the import pipeline to auto-calculate `amount_jpy` for every transaction - Add `--offline` flag for cached-rates-... (source: PR #25)
- [2026-03-08] feature: add unit tests for categorize + import loaders (#20) -- ## Summary - Add comprehensive unit tests for `categorize.py` rule matching (41 tests) and `import_to_notion.py` loader functions (27 tests) - 36-payee snapshot regression tests... (source: PR #24)
- [2026-03-08] feature: add categorization rules and unified import pipeline -- ## Summary - **仕分けルール拡充**: `rules.yaml` を6ルール→45+ルールに拡張。CLAUDE.mdの全カテゴリ体系（住居/教育/食費/交通/日用品/医療/保険/行政/エンタメ/衣類 + 除外項目）を網羅 - **Import スクリプト統合**: `import_to_notion.py` を... (source: PR #19)
- [2026-01-04] feature: add finance import workflow -- ## Summary Resolves #15. Adds a /finance:import workflow script that scans Downloads, moves statement files into data/raw, updates sources.yaml, validates data, and runs... (source: PR #18)
- [2026-01-04] feat: complete notion import pipeline -- ## Summary Resolves #16 This PR completes the Notion import pipeline by integrating Revolut/Wise parsing alongside TNG and implementing full Notion batch uploads. It adds... (source: PR #17)
- [2026-01-04] feature: add automated statement file detection and import -- ## Summary Resolves #5. This adds a configurable watcher/import script that detects new statement files, moves them into `data/raw/`, and runs incremental imports with summaries... (source: PR #14)
