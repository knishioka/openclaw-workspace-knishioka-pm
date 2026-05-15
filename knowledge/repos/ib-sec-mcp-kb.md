# ib-sec-mcp Knowledge Base

## Overview

- Repo: knishioka/ib-sec-mcp
- Description: MCP server for Interactive Brokers securities
- Primary language (GitHub): Python
- Category / Priority: mcp / high
- Status: active
- License: none
- Default branch: main
- Created: 2025-10-07
- Updated: 2026-05-01
- Collected: 2026-05-15

## Tech Stack

- Runtime dependencies: none detected
- pyproject.toml: present
- requirements.txt: not found
- README signal: # IB Analytics Interactive Brokers portfolio analytics library with **AI-powered investment analysis** and **development automation**. ## Overview IB Analytics enables systematic analysis of trading performance across...

## Architecture / Patterns

- MCP server surface should keep tool schemas explicit and API errors predictable for agent callers.
- Auth/token handling and API quota/error translation are core architecture risks.

## Competitive Landscape (notes)

No competitive research captured in this weekly rotation.

## Tech Decisions (from recent PRs/commits)

- [2026-05-01] feat: add earnings calendar MCP tool -- ## Summary - add `get_earnings_calendar` FastMCP tool backed by yfinance calendar data - load symbols from the latest `PositionStore` snapshot when symbols are omitted - return... (source: PR #115)
- [2026-04-20] maintenance: FastMCP 3系へ追従し内部API依存テストを解消する -- ## Summary - upgrade the optional `mcp` dependency and lockfile from FastMCP 2.x to FastMCP 3.x - replace MCP tests that depended on `_tool_manager`, `get_tools()`,... (source: PR #112)
- [2026-04-11] fix(api): paginate positions and preserve connection errors in CPClient -- ## Summary Addresses two unresolved review comments from PR #98 (chatgpt-codex-connector): - **Pagination for `get_positions`**: Previously only fetched page 0 (`/positions/0`).... (source: PR #105)
- [2026-04-11] ci(security): fix gitleaks schedule failure on test dummy account IDs -- ## Summary - Schedule gitleaks runs now use `--no-git --source .` to scan only the working tree, avoiding false positives from IB account ID patterns (`U\d{7,10}`) in git... (source: PR #104)
- [2026-03-21] test: add integration test suite for Client Portal API with Paper Trading -- ## Summary - Add `tests/integration/` with 24 integration tests for the Client Portal API using Paper Trading account - Tests cover connection, live orders, order lifecycle... (source: PR #102)
- [2026-03-21] feat(orders): add order placement and management via Client Portal API -- ## Summary Implements order placement, modification, and cancellation via IB Client Portal Gateway API with multiple safety mechanisms (#97). - **4 MCP tools**: `place_order`,... (source: PR #101)
- [2026-03-21] feat(sync): add limit order DB sync with live IB orders via CP API -- ## Summary - Add `ib_sec_mcp/storage/order_sync.py` with IB → local DB sync logic - Add `sync_limit_orders` MCP tool for manual sync trigger - Matching by `symbol + limit_price... (source: PR #100)
- [2026-03-21] feat(mcp): add live trading tools via Client Portal Gateway API -- ## Summary - Add 4 MCP tools for real-time IB data via Client Portal Gateway API - `get_live_orders` — active orders with symbol/side/status filters - `get_live_account_balance`... (source: PR #99)
