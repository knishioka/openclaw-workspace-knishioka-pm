# Monthly Portfolio Review - 2026-05

As of: 2026-05-10
Summary: Active 10 / Dormant 1 / Abandoned 6

## Portfolio snapshot

### Public repos
| Repo | Class | Days inactive | Note |
| --- | --- | ---: | --- |
| knishioka/kanji-practice | Active | 8 | education line keeps compounding through preset and print-quality work |
| knishioka/math-worksheet | Active | 0 | strongest current shipping pace in the education cluster |
| knishioka/ib-sec-mcp | Active | 8 | active delivery resumed, but still carries moderate PR queue |
| knishioka/freee-mcp | Active | 4 | healthiest MCP line, recent output remains steady |
| knishioka/cost-management-mcp | Active | 3 | active again, but latest health snapshot regressed to RED |
| knishioka/simple-bookkeeping | Abandoned | 104 | large backlog remains with no recent execution |
| knishioka/english-note-maker | Active | 5 | recovered from April staleness and kept shipping |
| knishioka/td-mcp-server | Abandoned | 280 | legacy MCP line, no visible revival signal |
| knishioka/meditation-chrome-extension | Abandoned | 314 | long-idle side project |
| knishioka/remotion-math-education | Abandoned | 326 | long-idle experiment, no active distribution path |

### Private repos
| Repo | Class |
| --- | --- |
| knishioka/market-lens-studio | Active |
| knishioka/workflow-engine | Active |
| knishioka/household-finance | Dormant |
| knishioka/ut-gymnastics | Active |
| knishioka/jgrants-app | Active |
| knishioka/line-advisor | Abandoned |
| knishioka/story-bridge | Abandoned |

## 1-month trend read (from monitoring/health-trend.jsonl)

- The public portfolio held **6 GREEN / 0 YELLOW / 4 RED** for three straight weekly checks from 2026-04-12 through 2026-04-26.
- The only regression in the last month was `knishioka/cost-management-mcp`, which moved **GREEN -> RED** on 2026-05-03 despite fresh commits, so the current risk is quality/reliability debt rather than inactivity.
- `knishioka/kanji-practice`, `knishioka/math-worksheet`, `knishioka/freee-mcp`, `knishioka/ib-sec-mcp`, and `knishioka/english-note-maker` all stayed on the active side of the portfolio and did not show month-long health decay.
- `knishioka/simple-bookkeeping`, `knishioka/td-mcp-server`, `knishioka/meditation-chrome-extension`, and `knishioka/remotion-math-education` remained structurally outside the active operating loop.

## Cross-repo analysis

### Common technology and integration opportunities

1. **MCP shared core opportunity**
   - `freee-mcp`, `cost-management-mcp`, `ib-sec-mcp`, and `td-mcp-server` all share the same basic pattern: schema-validated tools, report-style outputs, and external-system error handling.
   - Highest leverage is a small shared baseline for structured outputs, long-running task handling, auth/error conventions, and test harnesses instead of continuing repo-by-repo duplication.

2. **Education generator family is now a real product cluster**
   - `kanji-practice`, `math-worksheet`, and `english-note-maker` all converge on print-first worksheet generation, browser preview, and age/grade-aware presets.
   - Best integration path is a common preset/share model plus shared visual QA for A4 layout, tracing guides, and printable output verification.

3. **Finance domain overlap exists, but needs narrowing before integration**
   - `freee-mcp`, `simple-bookkeeping`, and `household-finance` all touch reporting, ledgers, and anomaly/KPI style workflows.
   - The useful near-term move is not full unification. It is shared reporting primitives and a clearer boundary between personal-finance workflows and business-accounting workflows.

4. **Automation spine is becoming reusable across the portfolio**
   - The active automation/tooling cluster suggests a reusable orchestration layer is emerging across the portfolio.
   - That layer can reduce one-off glue code between GitHub, Notion, content generation, and MCP-style backends.

### Repos with excessive maintenance load

- `knishioka/simple-bookkeeping`: **37 open issues + 8 open PRs** with 100+ days of inactivity. This is the clearest overhang in the public portfolio.
- `knishioka/cost-management-mcp`: active, but **4 open issues + 4 open PRs** plus a fresh RED regression suggests maintenance debt is re-accumulating faster than it is being retired.
- Publicly, no other repo currently looks as overloaded as those two.

## Abandoned repos: archive recommendation or revival gate

### Archive recommended

- `knishioka/td-mcp-server`
  - Archive recommendation: yes.
  - Revival gate: a real Treasure Data use case returns, and the repo is restarted as part of a shared MCP foundation instead of as a standalone branch of maintenance.

- `knishioka/meditation-chrome-extension`
  - Archive recommendation: yes.
  - Revival gate: a deliberate decision to pursue an offline bilingual wellness product, not just keep the prototype around.

- `knishioka/remotion-math-education`
  - Archive recommendation: yes unless video-first distribution becomes a current strategy.
  - Revival gate: tie it directly to the active education cluster with a concrete content pipeline and distribution hypothesis.

### Reset decision needed before revival work

- `knishioka/simple-bookkeeping`
  - Archive recommendation: not yet, but do not resume incremental backlog burning in the current shape.
  - Revival gate: choose one path first, either a minimal blue-return bookkeeping core or a deliberate connection to the finance/MCP cluster. Without that decision, the backlog stays too expensive.

### Private abandoned / on-hold

- `knishioka/line-advisor` and `knishioka/story-bridge` remain classified as Abandoned, but they are on hold and should stay excluded from restart pressure until a clear use case returns.

## Portfolio judgement

The portfolio now has **two clusters worth compounding**: the education generator family and the MCP/automation/tooling line. The main drag is not idea scarcity. It is tail maintenance. The best move this month is to protect momentum in those active clusters and make explicit archive-or-reset decisions for the abandoned edge projects, especially `simple-bookkeeping`.
