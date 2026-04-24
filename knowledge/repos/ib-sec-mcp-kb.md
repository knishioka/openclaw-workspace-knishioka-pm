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
- Updated: 2026-04-20
- Collected: 2026-04-24

## Tech Stack

- package.json: not found (or not accessible via GitHub contents API)
- Dependencies (sample): not found
- Dev dependencies (sample): not found
- npm scripts (keys): not found
- pyproject.toml: present
- requirements.txt: not found
- README signal: IB Analytics Interactive Brokers portfolio analytics library with **AI-powered investment analysis** and **development automation**. Overview IB Analytics enables systematic analysis of trading performance across multiple IB accounts with type-safe, modular, and extensible architecture. **For Investors** (Modes 1 & 2):…

## Architecture / Patterns

- Python MCP server with tool-per-capability surface and schema-validated inputs
- Python service layer around external brokerage / data APIs
- Interactive Brokers gateway / Client Portal integration with safety-conscious trading workflow

## Competitive Landscape (notes)

[2026-04-24] MCP Python SDK stable line is still **v1.x**, while the README on main already documents upcoming v2 concepts plus features like structured output, elicitation, context, and Streamable HTTP patterns. That means near-term leverage is more about adopting stable v1 protocol features cleanly than chasing a pre-alpha upgrade. (refs: https://github.com/modelcontextprotocol/python-sdk , `python3 -m pip index versions mcp` => 1.27.0 latest)
[2026-04-24] MCP spec 2025-06-18 adds **structured tool output**, **elicitation**, **resource links**, OAuth resource-server metadata, and stricter HTTP protocol-version signaling. For a broker-facing server, these changes map well to safer order workflows and richer portfolio/risk payloads. (ref: https://modelcontextprotocol.io/specification/2025-06-18/changelog)

Potential feature candidates for this repo:
- Add **structured-content responses** for portfolio, positions, and order-preview tools so clients can render holdings/risk tables without reparsing text.
- Add **elicitation-driven execution guards** that request missing account / confirmation context before placing or modifying live orders.

## Tech Decisions (from PRs/commits)

- [2026-04-20] maintenance: FastMCP 3系へ追従し内部API依存テストを解消する -- - upgrade the optional `mcp` dependency and lockfile from FastMCP 2.x to FastMCP 3.x - replace MCP tests that depended on `_tool_manager`, `get_tools()`, `get_resources()`, and `get_resource_templates()` with public FastMCP APIs - add a small test-only compatibility helper so registration and tool execution checks work… (source: PR #112)
- [2026-04-11] fix(api): paginate positions and preserve connection errors in CPClient -- Addresses two unresolved review comments from PR #98 (chatgpt-codex-connector): - **Pagination for `get_positions`**: Previously only fetched page 0 (`/positions/0`). IB paginates ~30 positions per page, so accounts with more holdings silently lost data. Now loops through all pages until empty response. - **Connection… (source: PR #105)
- [2026-04-11] ci(security): fix gitleaks schedule failure on test dummy account IDs -- - Schedule gitleaks runs now use `--no-git --source .` to scan only the working tree, avoiding false positives from IB account ID patterns (`U\d{7,10}`) in git history - Push/PR gitleaks runs continue scanning commit history as before - Expanded `.gitleaks.toml` allowlist from `tests/fixtures/.*` to `tests/.*` as defen… (source: PR #104)
- [2026-03-21] test: add integration test suite for Client Portal API with Paper Trading -- - Add `tests/integration/` with 24 integration tests for the Client Portal API using Paper Trading account - Tests cover connection, live orders, order lifecycle (place/modify/cancel), and DB sync - All tests auto-skip when Gateway is not running — zero impact on CI/CD Changes New Files - `tests/integration/__init__.py… (source: PR #102)
- [2026-03-21] feat(orders): add order placement and management via Client Portal API -- Implements order placement, modification, and cancellation via IB Client Portal Gateway API with multiple safety mechanisms (#97). - **4 MCP tools**: `place_order`, `modify_order`, `cancel_order`, `cancel_all_orders` - **6 safety mechanisms**: dry-run (default ON), per-order limit ($50K), daily limit ($200K), read-only… (source: PR #101)
- [2026-03-21] feat(sync): add limit order DB sync with live IB orders via CP API -- - Add `ib_sec_mcp/storage/order_sync.py` with IB → local DB sync logic - Add `sync_limit_orders` MCP tool for manual sync trigger - Matching by `symbol + limit_price + order_type` with IB as source of truth - Graceful handling when Gateway is not running (skip, no error) Changes New Files - `ib_sec_mcp/storage/order_sy… (source: PR #100)
- [2026-03-21] feat(mcp): add live trading tools via Client Portal Gateway API -- - Add 4 MCP tools for real-time IB data via Client Portal Gateway API - `get_live_orders` — active orders with symbol/side/status filters - `get_live_account_balance` — real-time balance (auto-selects first account) - `get_live_positions` — positions with unrealized P&L - `check_gateway_status` — connection/auth status… (source: PR #99)
- [2026-03-21] feat(api): add IB Client Portal API client with session management -- Implements #96 — IB Client Portal API client for real-time account data access through the local IB Gateway. - **CPClient**: Async httpx client with session management, TLS enforcement, exponential backoff retry (3 attempts) - **Pydantic Models**: CPAuthStatus, CPOrder, CPAccountBalance, CPPosition — all financial fiel… (source: PR #98)
