As of: 2026-05-04
Summary: Active 10 / Dormant 1 / Abandoned 4

## Portfolio classification

### Public repos

| Repo | Category | Days inactive | Status |
|------|----------|--------------|--------|
| kanji-practice | education | 2 | Active |
| math-worksheet | education | 9 | Active |
| ib-sec-mcp | mcp | 3 | Active |
| freee-mcp | mcp | 1 | Active |
| cost-management-mcp | mcp | 0 | Active |
| english-note-maker | education | 0 | Active |
| simple-bookkeeping | fintech | 99 | Abandoned |
| td-mcp-server | mcp | 274 | Abandoned |
| meditation-chrome-extension | tool | 308 | Abandoned |
| remotion-math-education | education | 321 | Abandoned |

### Private repos

| Repo | Status |
|------|--------|
| market-lens-studio | Active |
| workflow-engine | Active |
| household-finance | Dormant |
| ut-gymnastics | Active |
| jgrants-app | Active |
| line-advisor | On-hold (excluded) |
| story-bridge | On-hold (excluded) |

## 1-month health trend (public repos)

| Date | GREEN | YELLOW | RED |
|------|-------|--------|-----|
| 2026-04-05 | 4 | 1 | 5 |
| 2026-04-12 | 6 | 0 | 4 |
| 2026-04-19 | 6 | 0 | 4 |
| 2026-04-26 | 6 | 0 | 4 |
| 2026-05-03 | 5 | 0 | 5 |

Direction: the active cluster stayed strong through April, then slipped slightly on 2026-05-03 when cost-management-mcp regressed from GREEN to RED on CI while still shipping commits. Neglected repos remained persistently RED all month.

### Status changes this month
- cost-management-mcp: RED -> GREEN by mid-April after CI recovery and fresh delivery, then GREEN -> RED again on 2026-05-03 due to CI failure while activity stayed high
- english-note-maker: moved from borderline inactivity back into the active cluster and shipped again on 2026-05-04
- simple-bookkeeping: remained stalled and is now clearly beyond the archive threshold

## Cross-repo analysis

### Common technology / integration opportunities

1. MCP shared foundation
   - freee-mcp, cost-management-mcp, ib-sec-mcp, td-mcp-server share the same shape: MCP tool surface, schema validation, external API adapters, and report-oriented outputs.
   - Highest leverage: extract shared patterns for structured tool output, error shaping, auth/config validation, and long-running task handling.
   - Best starting pair: freee-mcp + cost-management-mcp, then port the same patterns into ib-sec-mcp.

2. Education generator shared platform
   - kanji-practice, math-worksheet, english-note-maker all operate as print-first A4 worksheet generators with repeated layout QA, preview-state logic, and curriculum-driven content expansion.
   - Highest leverage: shared A4 layout test harness, shared preset/state helpers, and a common spiral-review framework across math and language products.
   - Portfolio fit is strong: together they now cover preschool through elementary practice.

3. Finance pipeline convergence
   - household-finance is the active personal-finance data pipeline, while simple-bookkeeping is the dormant formal-ledger product.
   - Opportunity: keep ingestion, categorization, and anomaly detection in household-finance, and only revive simple-bookkeeping if there is a narrow filing/reporting need.

### Repos with excess maintenance load
- freee-mcp: 17 open PRs, still the clearest review-queue overload in the active portfolio
- simple-bookkeeping: 37 open issues / 8 open PRs with no corresponding delivery, strongest signal of maintenance debt
- ib-sec-mcp: 5 open PRs, still manageable but should not grow much further
- cost-management-mcp: 3 open issues / 3 open PRs on a medium-priority repo, okay if CI is stabilised first

## Abandoned repos: archive recommendation / revival condition

### simple-bookkeeping
- Recommendation: archive candidate unless a tax-filing milestone is explicitly revived
- Why: 99 days inactive, 37 open issues, 8 open PRs, and no visible forward motion despite repeated PM attention
- Revival condition: define a narrow milestone such as year-end statements or blue-return filing support, not a full-product restart

### td-mcp-server
- Recommendation: archive candidate
- Why: 274 days inactive and strategically overlapped by stronger MCP repos
- Revival condition: Treasure Data becomes an active data source again, or a shared MCP base makes completion cheap

### meditation-chrome-extension
- Recommendation: archive candidate
- Why: 308 days inactive, isolated from the current portfolio direction, no active issue or PR flow
- Revival condition: browser-extension distribution becomes an explicit product priority with a concrete user need

### remotion-math-education
- Recommendation: archive candidate unless video becomes a deliberate product axis
- Why: 321 days inactive and overlapped by the stronger worksheet products
- Revival condition: kanji-practice or math-worksheet gains a defined video or animation roadmap

### Private repos
- household-finance: Dormant
- line-advisor: On-hold (excluded)
- story-bridge: On-hold (excluded)

## Recommendation for June
- Reduce review queue pressure in freee-mcp before creating more work there
- Decide whether simple-bookkeeping is truly worth reviving; if not, move it to archive recommendation formally
- Reuse freee-mcp's structured-output pattern in ib-sec-mcp and cost-management-mcp
- Treat the education cluster as the strongest portfolio axis and invest in shared spiral-review and layout infrastructure
- Keep abandoned repos out of active planning unless a concrete revival trigger appears
