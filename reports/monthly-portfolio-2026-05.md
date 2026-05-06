# Monthly Portfolio Review - 2026-05

Date: 2026-05-06 19:00 Asia/Kuala_Lumpur

## Executive Summary

- Portfolio snapshot: 17 repos total, 10 Active, 1 Dormant, 6 Abandoned.
- Public portfolio improved through April, then slightly regressed in early May: health trend moved from 3 GREEN / 2 YELLOW / 5 RED in late March to 6 GREEN / 0 YELLOW / 4 RED in mid-to-late April, then 5 GREEN / 0 YELLOW / 5 RED on 2026-05-03.
- Main positive shift this month: `english-note-maker` returned to active development, `ib-sec-mcp` recovered from RED to GREEN, and education repos kept shipping.
- Main drag this month: `cost-management-mcp` reactivated but CI fell back to failure by early May, and `simple-bookkeeping` is now functionally abandoned while still carrying a large unresolved backlog.

## Classification

### Active

Public:
- knishioka/kanji-practice
- knishioka/math-worksheet
- knishioka/ib-sec-mcp
- knishioka/freee-mcp
- knishioka/cost-management-mcp
- knishioka/english-note-maker

Private:
- knishioka/market-lens-studio
- knishioka/workflow-engine
- knishioka/ut-gymnastics
- knishioka/jgrants-app

### Dormant

Public:
- none

Private:
- knishioka/household-finance

### Abandoned

Public:
- knishioka/simple-bookkeeping
- knishioka/td-mcp-server
- knishioka/meditation-chrome-extension
- knishioka/remotion-math-education

Private:
- knishioka/line-advisor
- knishioka/story-bridge

## 1-Month Trend Readout

- Late March baseline: strong activity in `kanji-practice`, `math-worksheet`, and `freee-mcp`; `ib-sec-mcp` and `cost-management-mcp` were RED; `simple-bookkeeping` and `english-note-maker` were aging.
- Early April inflection: `cost-management-mcp` recovered to GREEN, and the portfolio briefly reached 4 GREEN / 1 YELLOW / 5 RED.
- Mid April best state: 6 GREEN / 0 YELLOW / 4 RED. `ib-sec-mcp` turned GREEN, `english-note-maker` became active again, and the education cluster was healthy.
- Early May regression: `cost-management-mcp` returned to RED on CI failure, bringing the public snapshot to 5 GREEN / 0 YELLOW / 5 RED.
- Persistent problem across the full month: `simple-bookkeeping` stayed deeply stale and overloaded with open work.

## Cross-Repo Analysis

### Common technology and integration opportunities

#### 1. MCP shared platform opportunity is now clear

`freee-mcp`, `cost-management-mcp`, `ib-sec-mcp`, and `td-mcp-server` all converge on the same pattern:
- schema-validated tool surfaces
- report / analysis oriented outputs
- growing need for structured content, async jobs, and safer long-running flows

Portfolio-level opportunity:
- create a shared MCP foundation for tool registration, structured output conventions, pagination helpers, error mapping, and async task patterns
- prioritize `freee-mcp`, `cost-management-mcp`, and `ib-sec-mcp`; treat `td-mcp-server` only as a migration source, not as a strategic product

Expected benefit:
- less duplicate protocol plumbing
- faster rollout of structured outputs and TaskManager-style async flows
- easier consistency across finance / broker / cost domains

#### 2. Education repos are forming a reusable worksheet product family

`kanji-practice`, `math-worksheet`, `english-note-maker`, and even the abandoned `remotion-math-education` share a product thesis:
- A4 print-first generation
- browser-only delivery
- pedagogy-led feature design
- layout verification and output-fit constraints

Portfolio-level opportunity:
- unify them as a worksheet platform with shared preset logic, layout-fit verification, print QA helpers, and distribution patterns
- common next step across `kanji-practice` and `math-worksheet`: cumulative review / spaced retrieval presets
- `english-note-maker` can likely reuse the same preset and print QA concepts

#### 3. Finance domain overlap exists but is fragmented

`freee-mcp`, `simple-bookkeeping`, and `household-finance` all revolve around auditable financial records and reporting.

Portfolio-level opportunity:
- standardize shared ledger / category / reporting vocabulary across repos
- keep `freee-mcp` as API-facing advisory tooling
- decide whether `simple-bookkeeping` remains a product bet or is reduced to a reference domain model
- use `household-finance` as a smaller proving ground for reporting and anomaly UX

### Repos showing excessive effort or backlog pressure

Public:
- `simple-bookkeeping`: 37 open issues, 8 open PRs, 100 days inactive. This is the clearest overhang in the portfolio.
- `freee-mcp`: active and healthy, but previously carried a very high PR volume. Current load looks more controlled, yet still needs scope discipline.
- `ib-sec-mcp`: active with 5 open PRs. Not alarming, but enough concurrent surface area to watch.
- `cost-management-mcp`: 3 open issues and 3 open PRs is manageable, but CI regression means coordination cost is higher than the raw count suggests.

Private:
- `market-lens-studio`
- `workflow-engine`

Note: private repo details are intentionally omitted here beyond identification.

## Abandoned Repo Recommendations

### Public repos

#### knishioka/simple-bookkeeping
Recommendation: archive only if there is no concrete restart intent before the next tax-focused development window; otherwise run a hard revival triage first.

Reasoning:
- domain is still strategically relevant to the finance cluster
- but 100+ days inactivity plus 45 open items means it is currently carrying more backlog than active momentum

Revival condition:
- first, close or defer backlog aggressively until one narrow milestone remains
- relaunch only with a single concrete use case, for example blue-return bookkeeping core flow or report export

#### knishioka/td-mcp-server
Recommendation: archive.

Reasoning:
- 276 days inactive
- no recent product signal in KB
- overlaps with stronger MCP investments elsewhere

Revival condition:
- only if a real Treasure Data workflow reappears and cannot be served by the shared MCP foundation or another analytics path

#### knishioka/meditation-chrome-extension
Recommendation: archive.

Reasoning:
- 310 days inactive
- no visible cross-repo leverage
- isolated product thesis relative to current portfolio center of gravity

Revival condition:
- user pull for an offline bilingual wellness product, or a clear distribution channel that justifies standalone maintenance

#### knishioka/remotion-math-education
Recommendation: do not revive now; archive unless video generation becomes a deliberate education strategy.

Reasoning:
- 322 days inactive
- conceptually adjacent to education repos, but current momentum is in printable worksheet products, not video

Revival condition:
- revive only if there is a specific plan to turn worksheet content into reusable instructional video assets or teacher-facing explainer content

### Private repos

- knishioka/line-advisor: on-hold, keep frozen unless priority changes
- knishioka/story-bridge: on-hold, keep frozen unless priority changes

## Portfolio-Level Recommendations for Next Month

1. Consolidate the active bets into three clusters:
   - Education: `kanji-practice`, `math-worksheet`, `english-note-maker`
   - MCP/finance infrastructure: `freee-mcp`, `ib-sec-mcp`, `cost-management-mcp`
   - Automation/publishing tools: `workflow-engine`, `market-lens-studio`

2. Treat `simple-bookkeeping` as a portfolio decision, not a normal repo task queue.
   - Either restart with one narrow milestone or intentionally wind it down.

3. Put shared-platform work ahead of isolated feature work where possible.
   - MCP shared foundation
   - worksheet shared preset / print QA layer
   - finance shared reporting vocabulary

4. Watch CI quality on `cost-management-mcp`.
   - It is active again, but unstable activity is noisier than dormancy.

## Appendix: Classification Basis

Classification uses latest observed push recency as of 2026-05-06 11:00 UTC.
- Active: commit within 30 days
- Dormant: 30-90 days
- Abandoned: 90+ days
