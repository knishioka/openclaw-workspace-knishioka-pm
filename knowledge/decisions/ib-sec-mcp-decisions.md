# ib-sec-mcp Design Decisions

## 2026-05-01: add earnings calendar MCP tool

- **What**: add earnings calendar MCP tool
- **Why**: days_ahead add unit coverage and update server registration expectations ruff check ib_sec_mcp/mcp/tools/earnings_calendar.py ib_sec_mcp/mcp/tools/__init__.py tests/unit/test_earnings_calendar.py tests/mcp/test_server.py `ruff format --check ib_sec_mcp/mcp/...
- **Source**: PR #115

## 2026-04-20: FastMCP 3系へ追従し内部API依存テストを解消する

- **What**: FastMCP 3系へ追従し内部API依存テストを解消する
- **Why**: public FastMCP APIs add a small test-only compatibility helper so registration and tool execution checks work across FastMCP 2/3 shapes clean repo-wide Ruff blockers needed to satisfy the acceptance gate UV_CACHE_DIR=.uv-cache uv run pytest `UV_CACHE_DIR=.uv...
- **Source**: PR #112

## 2026-04-11: paginate positions and preserve connection errors in CPClient

- **What**: paginate positions and preserve connection errors in CPClient
- **Why**: **Pagination for get_positions**: Previously only fetched page 0 (/positions/0).
- **Source**: PR #105

## 2026-04-11: fix gitleaks schedule failure on test dummy account IDs

- **What**: fix gitleaks schedule failure on test dummy account IDs
- **Why**: Schedule gitleaks runs now use --no-git --source .
- **Source**: PR #104

## 2026-03-21: add integration test suite for Client Portal API with Paper Trading

- **What**: add integration test suite for Client Portal API with Paper Trading
- **Why**: , and DB sync All tests auto-skip when Gateway is not running — zero impact on CI/CD tests/integration/__init__.py — Package init tests/integration/conftest.py — gateway_available() skip condition + fixtures (cp_client, paper_account_id, cleanup_orders) `tes...
- **Source**: PR #102

## 2026-03-21: add order placement and management via Client Portal API

- **What**: add order placement and management via Client Portal API
- **Why**: Implements order placement, modification, and cancellation via IB Client Portal Gateway API with multiple safety mechanisms (#97).
- **Source**: PR #101

## 2026-03-21: add limit order DB sync with live IB orders via CP API

- **What**: add limit order DB sync with live IB orders via CP API
- **Why**: ith IB as source of truth Graceful handling when Gateway is not running (skip, no error) ib_sec_mcp/storage/order_sync.py — Core sync logic sync_orders_from_ib() — New/filled/cancelled order sync sync_orders_to_ib() — Phase 2 stub (NotImplementedError) `try_...
- **Source**: PR #100

## 2026-03-21: add live trading tools via Client Portal Gateway API

- **What**: add live trading tools via Client Portal Gateway API
- **Why**: account) get_live_positions — positions with unrealized P&L check_gateway_status — connection/auth status check Graceful error handling: gateway down or session expired returns JSON errors, no impact on existing tools Closes #93 | File | Change | |------|--...
- **Source**: PR #99

## 2026-03-21: add IB Client Portal API client with session management

- **What**: add IB Client Portal API client with session management
- **Why**: Implements #96 — IB Client Portal API client for real-time account data access through the local IB Gateway.
- **Source**: PR #98

## 2026-03-13: deduplicate and compress documentation (-44%)

- **What**: deduplicate and compress documentation (-44%)
- **Why**: correct agent count (8→11), command count (12→21), remove template code duplicated in .claude/CLAUDE.md Fix .claude/CLAUDE.md: simplify MCP reference to link, remove outdated "TODO" warning, fix double ---, update counts Fix README.md: remove Design Patterns...
- **Source**: PR #92
