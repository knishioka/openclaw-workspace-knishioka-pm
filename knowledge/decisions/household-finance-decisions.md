# household-finance Design Decisions

## 2026-01-04: feature: add automated statement file detection and import

- **What**: feature: add automated statement file detection and import
- **Why**: This adds a configurable watcher/import script that detects new statement files, moves them into `data/raw/`, and runs incremental imports with summaries and notifications. It reduces the manual steps in the current download-to-import workf
- **Source**: PR #14

## 2026-01-04: feature: add data validation and anomaly detection

- **What**: feature: add data validation and anomaly detection
- **Why**: This PR adds a pre-import validation and anomaly detection pass that surfaces data quality issues before Notion import. It integrates validation into the existing import CLI so you can run `--validate` to generate a report and optionally ab
- **Source**: PR #13

## 2026-01-04: feature: add uncategorized review CLI

- **What**: feature: add uncategorized review CLI
- **Why**: Adds an interactive CLI for reviewing uncategorized transactions with category shortcuts, batch updates, rule preview/creation, and session resume support. Updates dependencies and tests to support the new workflow.
- **Source**: PR #12

## 2026-01-04: feature: add tng ewallet pdf parser

- **What**: feature: add tng ewallet pdf parser
- **Why**: This PR adds a first-pass TNG eWallet PDF parser so Touch 'n Go statements can be ingested alongside existing Revolut/Wise data. It focuses on extracting dates, amounts, payees, and references from password-protected PDFs to unlock the TNG
- **Source**: PR #10

## 2026-01-04: feature: improve categorization rules with fuzzy matching

- **What**: feature: improve categorization rules with fuzzy matching
- **Why**: This PR introduces a YAML-driven categorization engine with fuzzy matching and learning support to reduce missed merchant variants. It adds a CLI for testing and training data capture so new merchants can be categorized without code changes
- **Source**: PR #9

## 2026-01-04: feature: add monthly report generation

- **What**: feature: add monthly report generation
- **Why**: This PR adds a monthly reporting CLI that pulls Notion transactions for a given month, aggregates by L1/L2 categories, and outputs a formatted Markdown report with optional HTML. It also computes fixed vs variable totals, per-child educatio
- **Source**: PR #8
