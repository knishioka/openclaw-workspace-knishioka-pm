# household-finance Knowledge Base

## Overview

- Repo: knishioka/household-finance
- Description: 家計管理・支出分析用リポジトリ
- Primary language (GitHub): Python
- License: none
- Default branch: main
- Created: 2026-01-01
- Updated: 2026-03-09
- Collected: 2026-05-29

## Tech Stack

- package.json: not found (or not accessible via GitHub contents API)
- pyproject.toml: present
- requirements.txt: present

## Architecture / Patterns

- (No clear patterns inferred from README/dependencies in this snapshot)

## Tech Decisions (from PRs/commits)

- [2026-03-09] feat: add local JSONL data source and anomaly detection to monthly report -- - Add `--source local` option to generate monthly reports from local `transactions.jsonl` file (offline, no Notion API needed) - Add category-level anomaly detection: warns when a category's monthly total exceeds 2x the 3-month average - Ad (source: PR #27)
- [2026-03-08] feat: add transactions.jsonl and import_log.jsonl persistence -- - Add `data/processed/transactions.jsonl` persistence with `source_id` deduplication - Add `data/processed/import_log.jsonl` to track Notion import history - Integrate import log-based dedup into `--output` flow with `--force` bypass - Add  (source: PR #26)
- [2026-03-08] feature: add unit tests for categorize + import loaders (#20) -- - Add comprehensive unit tests for `categorize.py` rule matching (41 tests) and `import_to_notion.py` loader functions (27 tests) - 36-payee snapshot regression tests against production `rules.yaml` to detect regressions on rule changes - S (source: PR #24)
- [2026-03-08] feature: add categorization rules and unified import pipeline -- - **仕分けルール拡充**: `rules.yaml` を6ルール→45+ルールに拡張。CLAUDE.mdの全カテゴリ体系（住居/教育/食費/交通/日用品/医療/保険/行政/エンタメ/衣類 + 除外項目）を網羅 - **Import スクリプト統合**: `import_to_notion.py` を Revolut/Wise/TNG 全ソース対応の統一パイプラインに書き換え。rules.yaml ベースの自動仕分け + Notion MCP 形式 JSON 出力 - ** (source: PR #19)
- [2026-01-04] feature: add finance import workflow -- Resolves #15. Adds a /finance:import workflow script that scans Downloads, moves statement files into data/raw, updates sources.yaml, validates data, and runs categorization plus Notion import when configured. Includes skill docs and tests  (source: PR #18)
- [2026-01-04] feat: complete notion import pipeline -- This PR completes the Notion import pipeline by integrating Revolut/Wise parsing alongside TNG and implementing full Notion batch uploads. It adds categorization, FX conversion, and source_id deduplication so imports can run end-to-end from (source: PR #17)
