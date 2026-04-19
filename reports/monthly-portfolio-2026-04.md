As of: 2026-04-19
Summary: Active 10 / Dormant 2 / Abandoned 5

## Portfolio mix

### Public repos
- Active: kanji-practice, math-worksheet, ib-sec-mcp, freee-mcp, cost-management-mcp, english-note-maker
- Dormant: simple-bookkeeping
- Abandoned: td-mcp-server, meditation-chrome-extension, remotion-math-education

### Private repos
- Active: market-lens-studio, workflow-engine, ut-gymnastics, jgrants-app
- Dormant: household-finance
- Abandoned: line-advisor, story-bridge

## 1-month health trend (public repos)
- 2026-03-27: GREEN 3 / YELLOW 2 / RED 5
- 2026-04-05: GREEN 4 / YELLOW 1 / RED 5
- 2026-04-12: GREEN 6 / YELLOW 0 / RED 4
- Direction: portfolio health improved over the month, mainly by recovering active repos rather than reviving neglected ones.

### Status changes this month
- cost-management-mcp: RED -> GREEN after CI recovery and fresh commits
- ib-sec-mcp: RED -> GREEN after CI fixes and active delivery
- english-note-maker: YELLOW -> RED -> GREEN, recovered with new feature work
- simple-bookkeeping: YELLOW -> RED after crossing 90-day inactivity in health checks, though commit recency still places it in Dormant (83 days)

### Persistent RED / neglect
- td-mcp-server, meditation-chrome-extension, remotion-math-education remained effectively neglected throughout the month

## Cross-repo analysis

### Common technology / integration opportunities
1. MCP shared foundation
   - freee-mcp, cost-management-mcp, ib-sec-mcp, td-mcp-server all follow the same pattern: schema-validated tool surface + external API adapter + report-oriented outputs.
   - Opportunity: extract a shared MCP base for tool registration, error shaping, structured-content responses, auth/config validation, and safety modes.
   - Highest leverage targets: freee-mcp + cost-management-mcp first, then port lessons to ib-sec-mcp.

2. Education generator shared platform
   - kanji-practice, math-worksheet, english-note-maker share print-first browser generation, A4 layout constraints, and frequent layout QA work.
   - Opportunity: shared print/layout test harness, common preview/store primitives, and reusable “mistake-driven regeneration” / “spiral review” patterns across apps.
   - remotion-math-education should not stay standalone unless video becomes a real product axis.

3. Finance data pipeline convergence
   - simple-bookkeeping and household-finance both center on reproducible calculations and auditability.
   - Opportunity: share import/normalization rules and reporting primitives, or define a handoff where household-finance becomes personal-data ingestion and simple-bookkeeping becomes formal ledger/reporting.

### Repos with likely excess maintenance load
- freee-mcp: 15 open PRs, active but review queue is too deep
- simple-bookkeeping: 37 open issues / 8 open PRs, clearly over-maintained relative to recent delivery
- ib-sec-mcp: 7 open PRs, acceptable only if merged down soon
- cost-management-mcp: stable now, but 3 issues / 3 PRs on a medium-priority repo suggests keeping scope tight

## Abandoned repos: recommendation / revival condition

### td-mcp-server
- Recommendation: archive candidate
- Why: 259 days inactive, no recent merged PR signal, overlaps with stronger current MCP portfolio
- Revival condition: only revive if Treasure Data becomes an active data source again, or if a shared MCP core makes finishing this server cheap

### meditation-chrome-extension
- Recommendation: archive candidate
- Why: 293 days inactive, no active issue/PR flow, isolated from the current portfolio direction
- Revival condition: revive only if browser-extension distribution becomes an explicit priority with a clear user need and content plan

### remotion-math-education
- Recommendation: do not revive as a standalone repo yet, archive candidate unless video is promoted to a portfolio theme
- Why: 305 days inactive, concept overlaps with stronger worksheet products, no evidence of active validation
- Revival condition: revive only if math-worksheet or kanji-practice gains a defined “generate explainer/review video” roadmap

### Private abandoned repos
- line-advisor: Abandoned (configured on-hold)
- story-bridge: Abandoned (configured on-hold)

## Portfolio recommendation
- Keep investing in the two strongest clusters: MCP and education generators
- Reduce queue pressure in freee-mcp and simple-bookkeeping before creating more work there
- Treat td-mcp-server, meditation-chrome-extension, and remotion-math-education as archive-ready unless a concrete revival trigger appears
- For the next month, the biggest leverage is shared foundations, not more repo proliferation
