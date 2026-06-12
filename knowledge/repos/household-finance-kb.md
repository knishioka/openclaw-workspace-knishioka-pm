# household-finance Knowledge Base

## Overview

- Repo: knishioka/household-finance
- Description: 家計管理・支出分析用リポジトリ
- Primary language (GitHub): Python
- License: none
- Default branch: main
- Created: 2026-01-01
- Updated: 2026-03-09
- Collected: 2026-06-12

## Tech Stack

- package.json: not found (or not accessible via GitHub contents API)
- pyproject.toml: present
- requirements.txt: present

## Architecture / Patterns

- (No clear patterns inferred from README/dependencies in this snapshot)

## Tech Decisions (from PRs/commits)

- [2026-01-04] feature: add automated statement file detection and import -- This adds a configurable watcher/import script that detects new statement files, moves them into `data/raw/`, and runs incremental imports with summaries and notifications. It reduces the manual steps in the current download-to-import workf (source: PR #14)
- [2026-01-04] feature: add data validation and anomaly detection -- This PR adds a pre-import validation and anomaly detection pass that surfaces data quality issues before Notion import. It integrates validation into the existing import CLI so you can run `--validate` to generate a report and optionally ab (source: PR #13)
- [2026-01-04] feature: add uncategorized review CLI -- Adds an interactive CLI for reviewing uncategorized transactions with category shortcuts, batch updates, rule preview/creation, and session resume support. Updates dependencies and tests to support the new workflow. (source: PR #12)
- [2026-01-04] feature: add tng ewallet pdf parser -- This PR adds a first-pass TNG eWallet PDF parser so Touch 'n Go statements can be ingested alongside existing Revolut/Wise data. It focuses on extracting dates, amounts, payees, and references from password-protected PDFs to unlock the TNG  (source: PR #10)
- [2026-01-04] feature: improve categorization rules with fuzzy matching -- This PR introduces a YAML-driven categorization engine with fuzzy matching and learning support to reduce missed merchant variants. It adds a CLI for testing and training data capture so new merchants can be categorized without code changes (source: PR #9)
- [2026-01-04] feature: add monthly report generation -- This PR adds a monthly reporting CLI that pulls Notion transactions for a given month, aggregates by L1/L2 categories, and outputs a formatted Markdown report with optional HTML. It also computes fixed vs variable totals, per-child educatio (source: PR #8)
