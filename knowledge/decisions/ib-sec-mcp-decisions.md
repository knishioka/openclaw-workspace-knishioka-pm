# ib-sec-mcp Design Decisions

## 2026-04-20: maintenance: FastMCP 3系へ追従し内部API依存テストを解消する

- **What**: maintenance: FastMCP 3系へ追従し内部API依存テストを解消する
- **Why**: - upgrade the optional `mcp` dependency and lockfile from FastMCP 2.x to FastMCP 3.x - replace MCP tests that depended on `_tool_manager`, `get_tools()`, `get_resources()`, and `get_resource_templates()` with public FastMCP APIs - add a small test-only compati…
- **Source**: PR #112

## 2026-04-11: fix(api): paginate positions and preserve connection errors in CPClient

- **What**: fix(api): paginate positions and preserve connection errors in CPClient
- **Why**: No summary captured.
- **Source**: PR #105

## 2026-04-11: ci(security): fix gitleaks schedule failure on test dummy account IDs

- **What**: ci(security): fix gitleaks schedule failure on test dummy account IDs
- **Why**: No summary captured.
- **Source**: PR #104

## 2026-03-21: test: add integration test suite for Client Portal API with Paper Trading

- **What**: test: add integration test suite for Client Portal API with Paper Trading
- **Why**: No summary captured.
- **Source**: PR #102

## 2026-03-21: feat(orders): add order placement and management via Client Portal API

- **What**: feat(orders): add order placement and management via Client Portal API
- **Why**: No summary captured.
- **Source**: PR #101

## 2026-03-21: feat(sync): add limit order DB sync with live IB orders via CP API

- **What**: feat(sync): add limit order DB sync with live IB orders via CP API
- **Why**: No summary captured.
- **Source**: PR #100

## 2026-03-21: feat(mcp): add live trading tools via Client Portal Gateway API

- **What**: feat(mcp): add live trading tools via Client Portal Gateway API
- **Why**: No summary captured.
- **Source**: PR #99

## 2026-03-21: feat(api): add IB Client Portal API client with session management

- **What**: feat(api): add IB Client Portal API client with session management
- **Why**: No summary captured.
- **Source**: PR #98
