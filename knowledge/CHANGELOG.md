# Knowledge Changelog - 2026-05-29

Only new findings since 2026-05-22 are listed.

## knishioka/ai-books

- [2026-05-25] New high-priority repo added to monitoring: AI-first accounting MCP server with Python 3.12+, `uv`, stdio MCP server, and SQLite-oriented roadmap.
- [2026-05-25] Initial design direction: MCP is the primary UX, with human-facing output limited to reports; non-goals explicitly exclude web data-entry UI, multi-tenant SaaS/RLS, and tax filing.

## knishioka/math-worksheet

- [2026-05-27] PR #72 aligned English word problems with elementary curriculum by grade, including grade-bounded templates and answer rendering that supports fractions/decimals/remainders.
- [2026-05-23] PR #71 added partial-product rows for advanced hissan multiplication, improving Grade 4 written-calculation practice.

## knishioka/market-lens-studio

- [2026-05-29] PR #273 tightened `/note:suggest --auto` headless behavior so the morning automation cannot stop before publishing because of mandate ambiguity.
- [2026-05-27] PR #260 added deterministic article lint plus Codex fact-check quality gates; PR #261 added Codex fallback orchestration with locking, notification dedup, retry, and idempotency controls.

## Competitive Research Findings

- ai-books: MCP Python SDK `mcp` is v1.27.1 (2026-05-08) and TypeScript SDK is v1.29.0 (2026-03-30); Python v1.x remains the stable line while v2 is pre-alpha. Feature candidates: SDK pin/watch, MCP transport compatibility tests, and stable-v1 migration notes before exposing write tools.
- ai-books: accounting automation is converging on workflow-integrated close/bookkeeping with human review rather than fully autonomous posting. Feature candidates: uncertain-mapping review queue, journal-entry validation explanations, and CSV import dry-run with debit/credit proof.
- market-lens-studio: AI market research tools are moving toward always-on monitoring and cited synthesis. Feature candidates: watchlist-based daily signal digest, source freshness score, and persisted evidence packs per generated article.
- market-lens-studio: Google Finance expanded AI-powered market research globally on 2026-04-08, making generic stock Q&A less differentiated. Stronger moat: Japan-market workflow depth, note/X publishing automation, audit trails, and deterministic quality gates.

## Staleness Warnings

- None: all priority=high repositories were collected this week.
