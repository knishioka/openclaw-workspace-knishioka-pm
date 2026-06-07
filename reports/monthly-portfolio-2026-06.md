# Monthly Portfolio Review - 2026-06

As of: 2026-06-07
Summary: Active 13 / Dormant 2 / Abandoned 5
Scope: public 11 repos + private 9 repos. Private repo detail is limited to name and class.

## Portfolio snapshot

### Public repos

| Repo | Class | Days inactive | Open issues | Open PRs | Note |
| --- | --- | ---: | ---: | ---: | --- |
| `knishioka/kanji-practice` | Active | 24 | 2 | 0 | education worksheet line remains active but slower than May |
| `knishioka/math-worksheet` | Active | 11 | 1 | 1 | strongest education generator; recent work improved grade-aligned English word problems |
| `knishioka/ib-sec-mcp` | Active | 3 | 0 | 5 | high-priority MCP line accelerated into portfolio/event decision support |
| `knishioka/freee-mcp` | Dormant | 32 | 2 | 11 | slipped past the 30-day activity boundary while dependency PR queue remains high |
| `knishioka/cost-management-mcp` | Active | 15 | 3 | 8 | active but medium-priority MCP review queue is now larger than feature pressure warrants |
| `knishioka/ai-books` | Active | 1 | 3 | 0 | new accounting MCP successor is the clearest finance/product direction |
| `knishioka/ai-english-daily-podcast` | Active | 1 | 0 | 0 | running as a daily generated-content pipeline |
| `knishioka/english-note-maker` | Active | 7 | 1 | 0 | active low-priority education repo; cloze/tracing work is recent |
| `knishioka/td-mcp-server` | Abandoned | 308 | 0 | 2 | legacy MCP line with no current revival signal |
| `knishioka/meditation-chrome-extension` | Abandoned | 342 | 0 | 0 | isolated offline Chrome extension with no active product cluster |
| `knishioka/remotion-math-education` | Abandoned | 355 | 0 | 0 | video experiment outside the current worksheet-first education loop |

### Private repos

| Repo | Class |
| --- | --- |
| `knishioka/market-lens-studio` | Active |
| `knishioka/workflow-engine` | Active |
| `knishioka/household-finance` | Dormant |
| `knishioka/ut-gymnastics` | Active |
| `knishioka/jgrants-app` | Active |
| `knishioka/1000haku` | Active |
| `knishioka/kagoshima-community-kl` | Active |
| `knishioka/line-advisor` | Abandoned / on-hold |
| `knishioka/story-bridge` | Abandoned / on-hold |

## 1-month trend read

- 2026-05-10: GREEN 6 / YELLOW 0 / RED 4 / UNKNOWN 0
- 2026-05-17: GREEN 6 / YELLOW 0 / RED 4 / UNKNOWN 0
- 2026-05-24: GREEN 6 / YELLOW 0 / RED 4 / UNKNOWN 0
- 2026-05-31: GREEN 7 / YELLOW 1 / RED 3 / UNKNOWN 0

Trend note: latest stored public health snapshot is 2026-05-31; current classification was refreshed from live GitHub data on 2026-06-07.

- Public health improved from 6 GREEN / 4 RED to 7 GREEN / 1 YELLOW / 3 RED after `ai-books` and `ai-english-daily-podcast` entered the monitored set.
- The persistent RED set is now mostly intentional abandonment: `td-mcp-server`, `meditation-chrome-extension`, and `remotion-math-education`.
- `freee-mcp` moved from GREEN to Dormant by commit recency, even though its open PR queue remains large.
- The biggest operational risk shifted from stale issues to review load: several active MCP/tool repos have many open PRs despite recent commits.

## Cross-repo analysis

### Common technology and integration opportunities

1. **MCP/accounting foundation**
   - `freee-mcp`, `cost-management-mcp`, `ib-sec-mcp`, `td-mcp-server`, and `ai-books` repeat the same core needs: typed tool registration, schema validation, structured responses, auth/config checks, and external API adapter boundaries.
   - Highest leverage: let `ai-books` become the accounting-policy memory, while extracting shared MCP conventions from active TypeScript/Python MCP repos. Do not revive `td-mcp-server` before this foundation exists.

2. **Worksheet-first education cluster**
   - `math-worksheet`, `kanji-practice`, and `english-note-maker` share browser-first printable generation, layout QA, tracing fidelity, and grade/age-aware presets.
   - Highest leverage: shared Playwright visual QA and print-layout assertions before new worksheet modes. `ai-english-daily-podcast` is adjacent, but it is a content pipeline rather than a worksheet product.

3. **Finance/reporting boundary**
   - Public accounting/MCP work now has a clearer successor path through `ai-books`.
   - Keep integration narrow: reusable accounting terminology tests, deterministic report primitives, and e-Tax mapping decisions are more valuable than merging products.

4. **Automation/tooling pressure**
   - Private tool/web repos are active enough to matter in portfolio capacity, but report details are intentionally omitted.
   - Portfolio-level takeaway: review throughput, not idea supply, is the limiting resource this month.

### Repos with excessive maintenance load

- `knishioka/freee-mcp`: 11 open PRs and 32 days inactive. Dependency/SDK work should be merged or closed before new feature work.
- `knishioka/cost-management-mcp`: 8 open PRs and 3 open issues. Medium-priority repo should avoid broad scope until the queue is smaller.
- `knishioka/ib-sec-mcp`: 5 open PRs but no open issues. This is acceptable only if those PRs are part of one coherent June push.
- Private repo review queues also need attention; details omitted from reports by policy.

## Abandoned repos: archive recommendation or revival gate

### Archive recommended

- `knishioka/td-mcp-server`
  - Archive recommendation: yes.
  - Revival gate: Treasure Data becomes an active data source again, and restart work uses the shared MCP foundation rather than standalone maintenance.

- `knishioka/meditation-chrome-extension`
  - Archive recommendation: yes.
  - Revival gate: a deliberate offline bilingual wellness product strategy with a current distribution path.

- `knishioka/remotion-math-education`
  - Archive recommendation: yes unless video-first education distribution becomes a current strategy.
  - Revival gate: a concrete tie-in to the active worksheet cluster with learning-outcome targets and a generation pipeline.

### Private abandoned / on-hold

- `knishioka/line-advisor` and `knishioka/story-bridge` remain Abandoned/on-hold by classification. Keep them out of restart pressure until Ken explicitly reopens the product direction.

## Portfolio judgement

The portfolio has a clearer center than last month: MCP/accounting infrastructure and worksheet-first education are the two compounding clusters. The next PM move is not more issue creation; it is review queue reduction in active MCP/tool repos, plus archiving decisions for the three public abandoned repos.
