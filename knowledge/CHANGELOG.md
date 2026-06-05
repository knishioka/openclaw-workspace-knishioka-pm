# Knowledge Changelog - 2026-06-05

Only new findings since 2026-05-29 are listed.

## knishioka/ib-sec-mcp

- [2026-06-04] Unify live CP and historical Flex positions via reconciliation view (PR #150)
- [2026-06-04] Add position-decision synthesis tool (PR #149)
- [2026-06-04] Integrate earnings, ex-dividend, and macro event feeds into daily checks (PR #151/#153)
- [2026-06-04] Add portfolio time-series and benchmark-relative tracking (PR #148)

## knishioka/ai-books

- [2026-06-05] Adopt retro-ADRs and ADR process (PR #100)
- [2026-06-05] Use module map and testing-guarantees inventory as contribution guide (PR #99)
- [2026-06-05] Map KOA210 operating-outside interest expense to AMF00330 and defer KOA220/240 (PR #97)
- [2026-06-05] Add hooks, guardrails, and project subagents for dev workflow (PR #101/#102)
- [2026-06-05] Eliminate general-ledger N+1 queries in whole-book path (PR #95)

## knishioka/ai-english-daily-podcast

- [2026-06-05] Maintain daily episode generation cadence (commits a43cd98..01c2d0c)

## knishioka/english-note-maker

- [2026-05-31] Expand cloze vocabulary and variation (PR #36)

## knishioka/market-lens-studio

- [2026-06-04] Deny ScheduleWakeup during headless note runs (PR #279)
- [2026-05-30] Bound morning suggest with a hard wall-clock timeout (PR #275)
- [2026-05-30] Prevent duplicate posts and surface the real failure reason (PR #277)

## knishioka/workflow-engine

- [2026-05-31] Add keyless Vertex AI image generation endpoint (PR #155)
- [2026-05-31] Send reference images via stdin (PR #156)
- [2026-05-30] Restrict manual workflow invocation by source IP (PR #154)

## knishioka/ut-gymnastics

- [2026-06-04] Standardize API domains with zod, services, guards, and wrapper (PR #172/#176/#177/#178)
- [2026-06-04] Make production-build E2E a merge gate (PR #185/#188)
- [2026-06-04] Invalidate cache after mutations across pages (PR #190)
- [2026-06-03] Replace role magic numbers with UserRole constants (PR #170)

## Competitive Research Findings

- math-worksheet: 2026 education/worksheet tools are moving toward AI-assisted generation, curriculum/objective metadata, answer keys, and progress tracking; research risk suggests preserving productive struggle with hints/worked-space rather than student-facing answer generation.
- freee-mcp: Official hosted freee-mcp now covers about 270 operations across five domains, so differentiation should shift to safer local workflows, audit/dry-run behavior, release-note watch, and schema-drift tests.
- freee-mcp: MCP TypeScript SDK production guidance remains v1.x while v2 is pre-alpha toward Q3 2026; add v2 compatibility watch before migrating.

## Staleness Warnings

- None: all priority=high repositories were collected this week.
