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
- Collected: 2026-05-08

## Tech Stack

- package.json: not found (or not accessible via GitHub contents API)
- Dependencies (sample): not found
- Dev dependencies (sample): not found
- npm scripts (keys): not found
- pyproject.toml: present
- requirements.txt: not found
- README signal: # IB Analytics Interactive Brokers portfolio analytics library with **AI-powered investment analysis** and **development automation**. ## Overview IB Analytics enables systematic analysis of trading performance across multiple IB accounts with type-safe, modular, and extensible a

## Architecture / Patterns

- MCP server with tool-per-capability interface and schema-validated inputs
- Upstream API/client layer isolated from MCP presentation surface
- Risk-aware workflow design around external system access, auth, and long-running tasks

## Competitive Landscape (notes)

[2026-04-24] MCP Python SDK stable line is still **v1.x**, while the README on main already documents upcoming v2 concepts plus features like structured output, elicitation, context, and Streamable HTTP patterns. That means near-term leverage is more about adopting stable v1 protocol features cleanly than chasing a pre-alpha upgrade. (refs: https://github.com/modelcontextprotocol/python-sdk , `python3 -m pip index versions mcp` => 1.27.0 latest)
[2026-04-24] MCP spec 2025-06-18 adds **structured tool output**, **elicitation**, **resource links**, OAuth resource-server metadata, and stricter HTTP protocol-version signaling. For a broker-facing server, these changes map well to safer order workflows and richer portfolio/risk payloads. (ref: https://modelcontextprotocol.io/specification/2025-06-18/changelog)
[2026-05-08] MCP SDK latest stable on npm remains 1.29.0, while the 2026-04-01 TypeScript SDK pre-release adds Standard Schema support, TaskManager extraction, and stricter protocol error handling. For a broker-facing MCP server, the practical opportunity is richer structured outputs and resumable long-running portfolio tasks without waiting for another stable line. (sources: npm registry @modelcontextprotocol/sdk latest=1.29.0 fetched 2026-05-08; GitHub releases 2026-04-01)
[2026-05-08] Competitive direction: MCP ecosystem is moving from plain text tool responses toward typed tool/prompt schemas and explicit task orchestration. ib-sec-mcp can differentiate by exposing holdings/risk/order-preview payloads as machine-readable structures first, then layering confirmation flows for live trading mutations. (source: modelcontextprotocol/typescript-sdk releases, 2026-04-01)

Potential feature candidates for this repo:
- Add **structured holdings/risk payloads** for portfolio and order-preview tools so MCP clients can render tables and diff states without reparsing prose.
- Add **task-based portfolio jobs** for slower analytics, with polling/resume support instead of single long synchronous tool calls.
- Add **confirmation-oriented live trading flows** that gather missing account/limit context before any mutation tool executes.

## Tech Decisions (from PRs/commits)

- [2026-05-01] feat: add earnings calendar MCP tool -- days_ahead add unit coverage and update server registration expectations ruff check ib_sec_mcp/mcp/tools/earnings_calendar.py ib_sec_mcp/mcp/tools/__init__.py tests/unit/test_earnings_calendar.py tests/mcp/test_server.py `ruff format --check ib_sec_mcp/mcp/... (source: PR #115)
- [2026-04-20] maintenance: FastMCP 3系へ追従し内部API依存テストを解消する -- public FastMCP APIs add a small test-only compatibility helper so registration and tool execution checks work across FastMCP 2/3 shapes clean repo-wide Ruff blockers needed to satisfy the acceptance gate UV_CACHE_DIR=.uv-cache uv run pytest `UV_CACHE_DIR=.uv... (source: PR #112)
- [2026-04-11] fix(api): paginate positions and preserve connection errors in CPClient -- **Pagination for get_positions**: Previously only fetched page 0 (/positions/0). (source: PR #105)
- [2026-04-11] ci(security): fix gitleaks schedule failure on test dummy account IDs -- Schedule gitleaks runs now use --no-git --source . (source: PR #104)
- [2026-03-21] test: add integration test suite for Client Portal API with Paper Trading -- , and DB sync All tests auto-skip when Gateway is not running — zero impact on CI/CD tests/integration/__init__.py — Package init tests/integration/conftest.py — gateway_available() skip condition + fixtures (cp_client, paper_account_id, cleanup_orders) `tes... (source: PR #102)
- [2026-03-21] feat(orders): add order placement and management via Client Portal API -- Implements order placement, modification, and cancellation via IB Client Portal Gateway API with multiple safety mechanisms (#97). (source: PR #101)
- [2026-03-21] feat(sync): add limit order DB sync with live IB orders via CP API -- ith IB as source of truth Graceful handling when Gateway is not running (skip, no error) ib_sec_mcp/storage/order_sync.py — Core sync logic sync_orders_from_ib() — New/filled/cancelled order sync sync_orders_to_ib() — Phase 2 stub (NotImplementedError) `try_... (source: PR #100)
- [2026-03-21] feat(mcp): add live trading tools via Client Portal Gateway API -- account) get_live_positions — positions with unrealized P&L check_gateway_status — connection/auth status check Graceful error handling: gateway down or session expired returns JSON errors, no impact on existing tools Closes #93 | File | Change | |------|--... (source: PR #99)
