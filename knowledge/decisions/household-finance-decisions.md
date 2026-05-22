# household-finance Design Decisions

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
