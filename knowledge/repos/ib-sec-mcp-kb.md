# ib-sec-mcp Knowledge Base

## Overview

- Repo: knishioka/ib-sec-mcp
- Primary language (GitHub): Python
- Category / Priority: mcp / high
- License: none
- Default branch: main
- Created: 2025-10-07
- Updated: 2026-03-21
- Collected: 2026-04-10

## Tech Stack

- package.json: not found (or not accessible via GitHub contents API)
- Dependencies (sample): not found
- Dev dependencies (sample): not found
- npm scripts (keys): not found
- pyproject.toml: present
- requirements.txt: not found
- README signal: # IB Analytics Interactive Brokers portfolio analytics library with **AI-powered investment analysis** and **development automation**. ## Overview IB Analytics enables systematic analysis of trading performance across mu…

## Architecture / Patterns

- Python MCP server around Interactive Brokers APIs
- Local-gateway / Client Portal integration with tool-oriented surface
- Trading workflow emphasis with sync + safety-oriented tests

## Competitive Landscape (notes)

- [2026-04-10] Competitive note: IBKR already exposes rich portfolio/account analytics via Client Portal + PortfolioAnalyst (allocation, risk measures, benchmark comparison). Differentiation for this repo is **AI-ready tool ergonomics** rather than raw analytics breadth. (refs: https://www.interactivebrokers.com/campus/ibkr-api-page/web-api-trading/ , https://www.interactivebrokers.com/en/portfolioanalyst/features.php)
- [2026-04-10] MCP trend: community IBKR MCP servers are appearing, but many are alpha-grade and trading-focused. A safer niche for this repo is **paper-trading-first workflows, explainable risk checks, and portfolio/account introspection before execution**. (refs: https://github.com/code-rabi/interactive-brokers-mcp , https://github.com/ArjunDivecha/ibkr-mcp-server)

Potential feature candidates for this repo:
- Add a **read-only portfolio/risk summary toolset** (allocation drift, concentration, realized/unrealized P&L rollups) to complement the new live-order tools.
- Add an explicit **execution safety mode**: dry-run previews, pre-trade guardrails, and paper/live environment labeling in every tool response.

## Tech Decisions (from PRs/commits)

- [2026-03-21] test: add integration test suite for Client Portal API with Paper Trading -- ## Summary - Add `tests/integration/` with 24 integration tests for the Client Portal API using Paper Trading account - Tests cover connection, live orders, order lifecycle (place/modify/cancel), and DB sync - All tests auto-skip when Gatew… (source: PR #102)
- [2026-03-21] feat(orders): add order placement and management via Client Portal API -- ## Summary Implements order placement, modification, and cancellation via IB Client Portal Gateway API with multiple safety mechanisms (#97). - **4 MCP tools**: `place_order`, `modify_order`, `cancel_order`, `cancel_all_orders` - **6 safety… (source: PR #101)
- [2026-03-21] feat(sync): add limit order DB sync with live IB orders via CP API -- ## Summary - Add `ib_sec_mcp/storage/order_sync.py` with IB → local DB sync logic - Add `sync_limit_orders` MCP tool for manual sync trigger - Matching by `symbol + limit_price + order_type` with IB as source of truth - Graceful handling wh… (source: PR #100)
- [2026-03-21] feat(mcp): add live trading tools via Client Portal Gateway API -- ## Summary - Add 4 MCP tools for real-time IB data via Client Portal Gateway API - `get_live_orders` — active orders with symbol/side/status filters - `get_live_account_balance` — real-time balance (auto-selects first account) - `get_live_p… (source: PR #99)
- [2026-03-21] feat(api): add IB Client Portal API client with session management -- ## Summary Implements #96 — IB Client Portal API client for real-time account data access through the local IB Gateway. - **CPClient**: Async httpx client with session management, TLS enforcement, exponential backoff retry (3 attempts) - **… (source: PR #98)
- [2026-03-13] docs: deduplicate and compress documentation (-44%) -- ## Summary - Rewrite `.claude/README.md` (1,042→140 lines): verbose descriptions → concise tables, remove all duplicated content (architecture, time savings, version history, best practices, 3x `/daily-check`) - Fix `CLAUDE.md`: correct age… (source: PR #92)
