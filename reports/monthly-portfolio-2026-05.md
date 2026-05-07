# Monthly Portfolio Review - 2026-05

As of: 2026-05-07
Summary: Active 10 / Dormant 1 / Abandoned 6

## Portfolio snapshot

### Public repos
| Repo | Class | Days inactive | Note |
| --- | --- | ---: | --- |
| knishioka/kanji-practice | Active | 5 | healthy education track |
| knishioka/math-worksheet | Active | 2 | healthy education track |
| knishioka/ib-sec-mcp | Active | 5 | regained delivery pace after March CI issues |
| knishioka/freee-mcp | Active | 1 | steady MCP delivery, PR queue absorbed |
| knishioka/cost-management-mcp | Active | 0 | active but health regressed to RED in latest trend |
| knishioka/simple-bookkeeping | Abandoned | 101 | still carrying large backlog with no recent execution |
| knishioka/english-note-maker | Active | 2 | recovered from early-April staleness and kept shipping |
| knishioka/td-mcp-server | Abandoned | 277 | inactive legacy MCP line |
| knishioka/meditation-chrome-extension | Abandoned | 311 | long-idle side project |
| knishioka/remotion-math-education | Abandoned | 323 | long-idle experiment |

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

- Early April baseline was 4 GREEN / 1 YELLOW / 5 RED.
- Mid to late April improved to 6 GREEN / 0 YELLOW / 4 RED, driven by recoveries in `ib-sec-mcp`, `english-note-maker`, and `cost-management-mcp`.
- Latest weekly snapshot (2026-05-03) slipped to 5 GREEN / 0 YELLOW / 5 RED because `cost-management-mcp` regressed to RED again despite fresh commits.
- `simple-bookkeeping` remained RED all month and crossed deeper into abandonment.
- `kanji-practice`, `math-worksheet`, and `freee-mcp` stayed consistently productive through the month.

## Cross-repo analysis

### Common technology and integration opportunities

1. **MCP platform consolidation opportunity**
   - `freee-mcp`, `cost-management-mcp`, `ib-sec-mcp`, and `td-mcp-server` all follow the same server pattern: tool-per-capability MCP surface, schema validation, and report-style outputs.
   - Shared extraction candidate: common tool registration, structured output conventions, auth/error handling, and long-running task support.
   - Highest leverage path is to treat `freee-mcp` and `cost-management-mcp` as the current TypeScript reference line, with `ib-sec-mcp` mirroring structured output / elicitation concepts on Python side.

2. **Education generator family is converging**
   - `kanji-practice`, `math-worksheet`, and `english-note-maker` are all print-first A4 generators with layout automation and age/grade-oriented presets.
   - Shared product opportunity: preset library, cumulative review flows, and a common QA harness for printable layout verification.
   - Strategic fit is good: `kanji-practice` and `math-worksheet` already moved toward spaced retrieval / progression design, while `english-note-maker` recently deepened age-linked difficulty presets.

3. **Finance domain can be connected more tightly**
   - `freee-mcp`, `simple-bookkeeping`, and `household-finance` all live in analysis/accounting territory.
   - A pragmatic integration path is not product unification yet, but shared reporting primitives: anomaly detection, ledger/KPI structured output, and consistent import/export surfaces.

4. **Automation spine is emerging**
   - `workflow-engine` is the most reusable orchestration layer in the portfolio.
   - It can become the bridge across MCP servers, GitHub/Notion automations, and content or operations workflows, reducing one-off glue code across projects.

### Repos with likely excessive maintenance load

- `simple-bookkeeping`: 37 open issues + 8 open PRs with 100+ days inactivity. This is the clearest overhang in the public portfolio.
- `cost-management-mcp`: active, but 4 open issues + 4 open PRs combined with RED regression suggests review/CI debt is re-accumulating.
- `workflow-engine`: active private repo, but appears to be carrying meaningful ongoing maintenance load.
- `market-lens-studio`: active private repo and likely still management-heavy; keep it intentionally bounded.

## Abandoned repos: archive or revival gate

### Archive recommended

- `knishioka/td-mcp-server`
  - Recommendation: archive unless Treasure Data becomes an active commercial or personal workflow again.
  - Revival gate: clear need for TD integration, plus a decision to fold it into a shared MCP core instead of reviving it as a standalone snowflake.

- `knishioka/meditation-chrome-extension`
  - Recommendation: archive. No current portfolio adjacency and no recent learning compounding.
  - Revival gate: explicit intent to build an offline bilingual wellness product, plus a modern Chrome extension roadmap.

- `knishioka/remotion-math-education`
  - Recommendation: archive unless video-first distribution becomes a real channel.
  - Revival gate: a concrete distribution hypothesis, reusable content pipeline, and linkage to the active worksheet products instead of standalone experimentation.

### Triage before deciding archive vs revival

- `knishioka/simple-bookkeeping`
  - Recommendation: do not invest incrementally in the current backlog without a reset decision.
  - Revival gate: choose one of two paths, either (a) narrow to a minimal blue-return bookkeeping core, or (b) explicitly connect it to `freee-mcp` / `household-finance` as a shared finance platform play. Without that decision, backlog burn will stay inefficient.

### Private abandoned / on-hold

- `knishioka/line-advisor`: keep on hold unless a clear restart owner/use case appears.
- `knishioka/story-bridge`: keep on hold unless there is a validated user-discovery reason to restart.

## Portfolio judgement

The portfolio currently has **two strong clusters worth compounding**: education generators and MCP/automation tooling. The main drag is not lack of ideas, but carrying too many tails. The best portfolio move this month is to protect momentum in the active clusters while making explicit archive-or-reset decisions on `simple-bookkeeping` and the older abandoned repos.
