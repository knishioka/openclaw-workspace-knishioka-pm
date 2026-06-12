# ib-sec-mcp Knowledge Base

## Overview

- Repo: knishioka/ib-sec-mcp
- Primary language (GitHub): Python
- License: none
- Default branch: main
- Created: 2025-10-07
- Updated: 2026-06-04
- Collected: 2026-06-12

## Tech Stack

- package.json: not found (or not accessible via GitHub contents API)
- pyproject.toml: present
- requirements.txt: not found

## Architecture / Patterns

- MCP server / tool integration
- Portfolio analytics MCP tools
- Event-driven investment decision support
- Client Portal/Flex position reconciliation

## Tech Decisions (from PRs/commits)

- [2026-06-04] fix(test): use FastMCP 3 get_resource_templates in account resource test -- ## Problem Running the full suite on integrated `main` surfaced 2 failures in `tests/mcp/test_resources.py::TestAccountResource` that each contributing PR's isolated CI did not catch: (source: PR #154)
- [2026-06-04] feat(events): add interest-rate (macro) event feed to get_upcoming_events -- Resolves #152 (follow-up from #131 / #151). `get_upcoming_events` previously sourced only **earnings** and **ex-dividend** events per symbol from yfinance. Interest-rate (macro) events were deferred because there is no per-symbol macro sour (source: PR #153)
- [2026-06-04] docs(reference): rewrite mcp-tools-reference to cover all modules with correct counts -- Rewrites `docs/mcp-tools-reference.md` so it covers **all** tool modules with the correct, post-consolidation counts. Resolves #125. (source: PR #146)
- [2026-06-04] docs(sync): fix module/tool/command counts in architecture, CHANGELOG and .claude docs -- Syncs documentation counts to actual values and backfills the CHANGELOG. Resolves #127 (Wave 4, docs-only, file-isolated). (source: PR #145)
- [2026-06-04] test(mcp): add tests for portfolio/position/sentiment tools + middleware & resources -- Resolves #124 (Wave 3, `test` / `parallel-safe`). (source: PR #144)
- [2026-06-04] test(mcp): add tests for market-data tools (stock_data, options, technical, market/etf comparison) -- Resolves #123 (Wave 3, `test` / `parallel-safe`). (source: PR #143)

## Competitive Landscape

- [2026-06-12] MCP Python SDK stable line is v1.27.2, while v2.0.0a1 pre-release landed on 2026-06-11 for the upcoming 2026-07-28 spec shift toward stateless request/response. Feature candidate: pin `mcp<2` until migration work starts, then add a compatibility spike around server/session API changes and FastMCP naming changes. Sources: modelcontextprotocol/python-sdk releases (2026-06-11, 2026-05-29), MCP Python SDK docs (accessed 2026-06-12).
- [2026-06-12] IBKR MCP competitors now expose account, position, market-data, and order workflows, commonly via FastMCP/Streamable HTTP or containerized FastAPI gateways. Differentiation should stay on safety and advisory workflow quality: explicit dry-run/order confirmation, portfolio reconciliation, benchmark-relative analytics, event feeds, and local audit logs. Sources: code-rabi/interactive-brokers-mcp, ArjunDivecha/ibkr-mcp-server, GaoChX/ibkr-mcp-server, PulseMCP IB server listing (accessed 2026-06-12).
