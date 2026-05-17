# Monthly Portfolio Review - 2026-05

As of: 2026-05-17
Summary: Active 8 / Dormant 3 / Abandoned 6
Scope: public 10 repos + private 7 repos. Private repo detail is limited to name and class.

## Portfolio snapshot

### Public repos

| Repo | Class | Days inactive | Open issues | Open PRs | Note |
| --- | --- | ---: | ---: | ---: | --- |
| `knishioka/kanji-practice` | Active | 3 | 1 | 0 | education cluster keeps compounding through print customization and worksheet quality |
| `knishioka/math-worksheet` | Active | 4 | 2 | 1 | strong active education line with recent word-problem depth work |
| `knishioka/ib-sec-mcp` | Active | 15 | 5 | 5 | active MCP line; review queue still needs pressure reduction |
| `knishioka/freee-mcp` | Active | 6 | 12 | 11 | active high-priority MCP, but open queue grew again |
| `knishioka/cost-management-mcp` | Active | 5 | 6 | 3 | active and CI recovered after early-May RED regression |
| `knishioka/simple-bookkeeping` | Abandoned | 111 | 45 | 8 | largest public backlog with no delivery since January |
| `knishioka/english-note-maker` | Active | 12 | 0 | 0 | active but lower-priority education repo after alphabet/tracing push |
| `knishioka/td-mcp-server` | Abandoned | 287 | 2 | 2 | legacy MCP line with no current revival signal |
| `knishioka/meditation-chrome-extension` | Abandoned | 321 | 0 | 0 | isolated long-idle side project |
| `knishioka/remotion-math-education` | Abandoned | 333 | 0 | 0 | video experiment outside current education execution loop |

### Private repos

| Repo | Class |
| --- | --- |
| `knishioka/market-lens-studio` | Active |
| `knishioka/workflow-engine` | Active |
| `knishioka/household-finance` | Dormant |
| `knishioka/ut-gymnastics` | Dormant |
| `knishioka/jgrants-app` | Dormant |
| `knishioka/line-advisor` | Abandoned |
| `knishioka/story-bridge` | Abandoned |

## 1-month trend read (from monitoring/health-trend.jsonl)

- 2026-04-19: GREEN 6 / YELLOW 0 / RED 4 / UNKNOWN 0
- 2026-04-26: GREEN 6 / YELLOW 0 / RED 4 / UNKNOWN 0
- 2026-05-03: GREEN 5 / YELLOW 0 / RED 5 / UNKNOWN 0
- 2026-05-10: GREEN 6 / YELLOW 0 / RED 4 / UNKNOWN 0

Trend note: latest stored health snapshot is 2026-05-10 (no 2026-05-17 health-trend entry was present at review time).
- Public health held near 6 GREEN / 4 RED through late April and 2026-05-10, with the RED set dominated by abandoned or backlog-heavy repos.
- `cost-management-mcp` briefly regressed to RED on 2026-05-03, then returned to GREEN by 2026-05-10 after CI/security cleanup.
- `freee-mcp` review load improved sharply in trend data (15 open PRs -> 0 on 2026-05-10), but live GitHub state now shows the queue has re-accumulated.
- `simple-bookkeeping` remains the persistent structural drag: RED, 100+ days inactive, and a large issue/PR backlog.

## Cross-repo analysis

### Common technology and integration opportunities

1. **MCP shared foundation**
   - `freee-mcp`, `cost-management-mcp`, `ib-sec-mcp`, and `td-mcp-server` repeat the same architecture: schema-validated tools, external API adapters, auth/config validation, and structured report outputs.
   - Highest leverage: extract a small shared baseline for tool registration, error shaping, structured-content responses, SDK-version migration checks, and quota/auth handling.
   - Start with active TypeScript repos (`freee-mcp` + `cost-management-mcp`), then port conventions to Python MCP repos.

2. **Education generator family**
   - `kanji-practice`, `math-worksheet`, and `english-note-maker` now share a clear product pattern: browser-first printable worksheets, grade/age-aware presets, tracing/handwriting fidelity, and A4 layout QA.
   - Highest leverage: shared visual QA harness, common preset/share model, and reusable print-layout assertions before adding more worksheet modes.
   - `remotion-math-education` should only revive if video becomes a deliberate extension of this cluster.

3. **Finance/reporting boundary**
   - `freee-mcp`, `simple-bookkeeping`, and private `household-finance` all touch calculations, categorization, ledgers, or KPI/anomaly reporting.
   - Integration should be narrow: share deterministic reporting primitives and terminology tests, not a single merged finance product.

4. **Automation spine**
   - The active tooling/automation repos point toward reusable patterns for GitHub/Notion/content workflow orchestration and rate-limit-safe batching.
   - This can reduce bespoke glue code across PM automation, portfolio reporting, and MCP-adjacent workflows.

### Repos with excessive maintenance load

- `knishioka/simple-bookkeeping`: 45 open issues + 8 open PRs with 100+ days of inactivity. This is the clearest public overhang.
- `knishioka/freee-mcp`: 12 open issues + 11 open PRs despite active delivery; review throughput should be protected before adding more feature work.
- `knishioka/ib-sec-mcp`: 5 open issues + 5 open PRs; still manageable, but high-priority MCP work should merge down before widening scope.
- `knishioka/cost-management-mcp`: 6 open issues + 3 open PRs and recent CI/security churn; keep medium-priority scope tight.

## Abandoned repos: archive recommendation or revival gate

### Archive recommended

- `knishioka/td-mcp-server`
  - Archive recommendation: yes.
  - Revival gate: Treasure Data becomes an active data source again, and the restart happens on top of the shared MCP foundation rather than standalone maintenance.

- `knishioka/meditation-chrome-extension`
  - Archive recommendation: yes.
  - Revival gate: a deliberate offline bilingual wellness product strategy with a current distribution path.

- `knishioka/remotion-math-education`
  - Archive recommendation: yes unless video-first education distribution becomes a current strategy.
  - Revival gate: direct tie-in to the active education cluster with a concrete generation pipeline and learning outcome target.

### Reset decision needed before revival work

- `knishioka/simple-bookkeeping`
  - Archive recommendation: not yet, because the domain is still strategically adjacent to finance/reporting work.
  - Revival gate: choose either a minimal blue-return bookkeeping core or a deliberate finance-cluster integration. Do not resume broad backlog burning without that decision.

### Private abandoned / on-hold

- `knishioka/line-advisor` and `knishioka/story-bridge` remain Abandoned/on-hold by classification. Keep them out of restart pressure until a clear use case returns.

## Portfolio judgement

The portfolio is healthiest where work compounds into two reusable clusters: **education generators** and **MCP/automation tooling**. The risk is tail maintenance: abandoned repos are clear archive candidates, while `simple-bookkeeping` and high-queue MCP repos need queue reduction or a reset decision before new scope is added.
