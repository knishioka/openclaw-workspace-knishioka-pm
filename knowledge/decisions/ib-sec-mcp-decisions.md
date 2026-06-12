# ib-sec-mcp Design Decisions

## 2026-06-04: fix(test): use FastMCP 3 get_resource_templates in account resource test

- **What**: fix(test): use FastMCP 3 get_resource_templates in account resource test
- **Why**: ## Problem Running the full suite on integrated `main` surfaced 2 failures in `tests/mcp/test_resources.py::TestAccountResource` that each contributing PR's isolated CI did not catch:
- **Source**: PR #154

## 2026-06-04: feat(events): add interest-rate (macro) event feed to get_upcoming_events

- **What**: feat(events): add interest-rate (macro) event feed to get_upcoming_events
- **Why**: Resolves #152 (follow-up from #131 / #151). `get_upcoming_events` previously sourced only **earnings** and **ex-dividend** events per symbol from yfinance. Interest-rate (macro) events were deferred because there is no per-symbol macro sour
- **Source**: PR #153

## 2026-06-04: docs(reference): rewrite mcp-tools-reference to cover all modules with correct counts

- **What**: docs(reference): rewrite mcp-tools-reference to cover all modules with correct counts
- **Why**: Rewrites `docs/mcp-tools-reference.md` so it covers **all** tool modules with the correct, post-consolidation counts. Resolves #125.
- **Source**: PR #146

## 2026-06-04: docs(sync): fix module/tool/command counts in architecture, CHANGELOG and .claude docs

- **What**: docs(sync): fix module/tool/command counts in architecture, CHANGELOG and .claude docs
- **Why**: Syncs documentation counts to actual values and backfills the CHANGELOG. Resolves #127 (Wave 4, docs-only, file-isolated).
- **Source**: PR #145

## 2026-06-04: test(mcp): add tests for portfolio/position/sentiment tools + middleware & resources

- **What**: test(mcp): add tests for portfolio/position/sentiment tools + middleware & resources
- **Why**: Resolves #124 (Wave 3, `test` / `parallel-safe`).
- **Source**: PR #144

## 2026-06-04: test(mcp): add tests for market-data tools (stock_data, options, technical, market/etf comparison)

- **What**: test(mcp): add tests for market-data tools (stock_data, options, technical, market/etf comparison)
- **Why**: Resolves #123 (Wave 3, `test` / `parallel-safe`).
- **Source**: PR #143
