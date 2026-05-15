# ib-sec-mcp Design Decisions

Updated: 2026-05-15

## 2026-05-01: feat: add earnings calendar MCP tool

- **What**: ## Summary - add `get_earnings_calendar` FastMCP tool backed by yfinance calendar data - load symbols from the latest `PositionStore` snapshot when symbols are omitted - return...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #115

## 2026-04-20: maintenance: FastMCP 3系へ追従し内部API依存テストを解消する

- **What**: ## Summary - upgrade the optional `mcp` dependency and lockfile from FastMCP 2.x to FastMCP 3.x - replace MCP tests that depended on `_tool_manager`, `get_tools()`,...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #112

## 2026-04-11: fix(api): paginate positions and preserve connection errors in CPClient

- **What**: ## Summary Addresses two unresolved review comments from PR #98 (chatgpt-codex-connector): - **Pagination for `get_positions`**: Previously only fetched page 0 (`/positions/0`)....
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #105

## 2026-04-11: ci(security): fix gitleaks schedule failure on test dummy account IDs

- **What**: ## Summary - Schedule gitleaks runs now use `--no-git --source .` to scan only the working tree, avoiding false positives from IB account ID patterns (`U\d{7,10}`) in git...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #104

## 2026-03-21: test: add integration test suite for Client Portal API with Paper Trading

- **What**: ## Summary - Add `tests/integration/` with 24 integration tests for the Client Portal API using Paper Trading account - Tests cover connection, live orders, order lifecycle...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #102

## 2026-03-21: feat(orders): add order placement and management via Client Portal API

- **What**: ## Summary Implements order placement, modification, and cancellation via IB Client Portal Gateway API with multiple safety mechanisms (#97). - **4 MCP tools**: `place_order`,...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #101

## 2026-03-21: feat(sync): add limit order DB sync with live IB orders via CP API

- **What**: ## Summary - Add `ib_sec_mcp/storage/order_sync.py` with IB → local DB sync logic - Add `sync_limit_orders` MCP tool for manual sync trigger - Matching by `symbol + limit_price...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #100

## 2026-03-21: feat(mcp): add live trading tools via Client Portal Gateway API

- **What**: ## Summary - Add 4 MCP tools for real-time IB data via Client Portal Gateway API - `get_live_orders` — active orders with symbol/side/status filters - `get_live_account_balance`...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #99

## 2026-03-21: feat(api): add IB Client Portal API client with session management

- **What**: ## Summary Implements #96 — IB Client Portal API client for real-time account data access through the local IB Gateway. - **CPClient**: Async httpx client with session...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #98

## 2026-03-13: docs: deduplicate and compress documentation (-44%)

- **What**: ## Summary - Rewrite `.claude/README.md` (1,042→140 lines): verbose descriptions → concise tables, remove all duplicated content (architecture, time savings, version history,...
- **Why**: Inferred from PR text/commit history; preserves product behavior while improving user-facing workflow, correctness, or maintainability.
- **Source**: PR #92
