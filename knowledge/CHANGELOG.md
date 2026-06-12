# Knowledge Changelog - 2026-06-12

Only new findings since 2026-06-05 are listed.

## knishioka/ai-books

- [2026-06-10] Add production smoke checks for deployed web viewer and automatic issue creation on failures (PR #177)
- [2026-06-10] Expose e-Tax filing preflight as an MCP tool with optional local XSD validation (PR #176)
- [2026-06-10] Supply KOA210 filer header fields from a local TOML profile (PR #172)
- [2026-06-10] Centralize e-Tax data-completeness and mapping dry-run checks before filing (PR #170)

## knishioka/market-lens-studio

- [2026-06-11] Match real Notion optional-property errors so fallback sync does not hard-fail on missing optional fields (PR #292)
- [2026-06-11] Add render checks to fallback publishing path, closing the gap with the `/note:write` workflow (PR #291)
- [2026-06-10] Add deterministic Playwright render checks against published note pages (PR #290)
- [2026-06-10] Feed generation insights back into diagram suggestion budgets for the PDCA loop (PR #286/#288)

## knishioka/workflow-engine

- [2026-06-11] Use an AWS billing role for cloud cost reporting (commit-derived decision)
- [2026-06-11] Add AWS cross-account role setup docs and provider routing CLI cleanup (commit-derived decisions)

## knishioka/jgrants-app

- [2026-06-08] Fix schedule date helpers to avoid timezone-driven off-by-one calendar dates (PR #118)
- [2026-06-07] Resolve npm audit vulnerabilities without direct dependency range changes (PR #111)
- [2026-06-07] Improve list loading/error states and replace native dialogs with toast/confirm UI (PR #107/#108)

## knishioka/ut-gymnastics

- [2026-06-04] Continue API domain standardization across news, albums, and tags using zod/service/guard/wrapper pattern (PR #176/#177/#178)
- [2026-06-04] Fix optimized production image 404s (PR #189)
- [2026-06-03] Add app-segment error/loading boundaries and architecture onboarding docs (PR #162/#169)

## Competitive Research Findings

- kanji-practice: Writing-first competitors combine handwriting detection with SRS, while broader Japanese apps emphasize customizable study paths. Feature candidate: add review-schedule metadata/export and evolve presets into named bottleneck-based study paths.
- ib-sec-mcp: MCP Python SDK v2.0.0a1 is now in alpha for the upcoming 2026-07-28 spec changes; stable remains v1.27.2. Feature candidate: pin `mcp<2` now and plan a compatibility spike before the stable v2 release.
- ib-sec-mcp: IBKR MCP alternatives are converging on account/position/market-data/order coverage. Differentiation should emphasize dry-run/order confirmation, reconciliation, benchmark-relative analytics, event feeds, and audit logs.

## Staleness Warnings

- None: all priority=high repositories were collected this week.
