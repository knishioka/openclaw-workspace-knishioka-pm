As of: 2026-04-26
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
- 2026-04-19: GREEN 6 / YELLOW 0 / RED 4
- Direction: active repos recovered over the month, but neglected repos stayed neglected.

### Status changes this month
- cost-management-mcp: RED -> GREEN after CI recovery and fresh commits
- ib-sec-mcp: RED -> GREEN after CI fixes and continued delivery
- english-note-maker: YELLOW -> RED -> GREEN, then returned to active development
- simple-bookkeeping: YELLOW -> RED in weekly health checks after crossing 90-day inactivity, while current portfolio classification is still Dormant at 90 days since last push

## Cross-repo analysis

### Common technology / integration opportunities
1. MCP shared foundation
   - freee-mcp, cost-management-mcp, ib-sec-mcp, td-mcp-server share the same shape: schema-validated tools + external API adapters + report-oriented outputs.
   - Highest leverage: extract shared modules for tool registration, error shaping, structured-content responses, config/auth validation, and safety prompts.
   - Recommended starting set: freee-mcp + cost-management-mcp first, then port patterns to ib-sec-mcp.

2. Education generator shared platform
   - kanji-practice, math-worksheet, english-note-maker all operate as print-first browser generators with repeated A4 layout QA and preview-state logic.
   - Opportunity: shared print/layout test harness, common preview/store primitives, and reusable spiral-review or mistake-driven worksheet patterns.
   - remotion-math-education should not remain standalone unless video becomes a deliberate product axis.

3. Finance data pipeline convergence
   - simple-bookkeeping and household-finance both optimize for reproducible calculations and auditability.
   - Opportunity: separate roles cleanly, household-finance as ingestion/normalization and simple-bookkeeping as formal ledger/reporting, or share import/report primitives.

### Repos with excess maintenance load (public only)
- freee-mcp: 15 open PRs, healthy but review queue is too deep
- simple-bookkeeping: 37 open issues / 8 open PRs with only Dormant delivery, strongest signal of queue overload
- ib-sec-mcp: 5 open PRs, acceptable only if merged down soon
- cost-management-mcp: 3 open issues / 3 open PRs on a medium-priority repo, keep scope tight

## Abandoned repos: archive recommendation / revival condition

### td-mcp-server
- Recommendation: archive candidate
- Why: 266 days inactive, no recent merged PR signal, overlaps with stronger MCP repos already moving faster
- Revival condition: Treasure Data becomes an active data source again, or a shared MCP core makes completion cheap

### meditation-chrome-extension
- Recommendation: archive candidate
- Why: 300 days inactive, isolated from the current portfolio direction, no active issue/PR flow
- Revival condition: browser-extension distribution becomes an explicit product priority with a clear user need

### remotion-math-education
- Recommendation: archive candidate unless video is promoted to a portfolio theme
- Why: 312 days inactive, overlaps with stronger worksheet products, no evidence of recent validation
- Revival condition: math-worksheet or kanji-practice gains a defined explainer/review video roadmap

### Private abandoned repos
- line-advisor: Abandoned
- story-bridge: Abandoned

## PM Retrospective (2026-04)
- Issues created in April: 4
- Issues resolved in April: 6
- Open PM-tracked issues: 2
- Average days to resolve (April-resolved): 9.2
- Quality score distribution: A=6 / B=0 / C=0 / D=0
- Signal: issue quality is strong; the bottleneck is queue management in PR-heavy repos, not issue definition quality

## Recommendation for May
- Keep investing in the two strongest clusters: MCP and education generators
- Reduce queue pressure in freee-mcp and simple-bookkeeping before creating more work there
- Treat td-mcp-server, meditation-chrome-extension, and remotion-math-education as archive-ready unless a concrete revival trigger appears
- Highest leverage next month is shared foundations, not more repo proliferation
