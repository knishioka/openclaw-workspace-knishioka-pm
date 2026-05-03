# Monthly Portfolio Review — 2026-05

As of: 2026-05-03
Summary: Active 10 / Dormant 1 / Abandoned 4

---

## Portfolio classification

### Public repos
| Repo | Category | Days inactive | Status |
|------|----------|--------------|--------|
| kanji-practice | education | 1 | Active |
| math-worksheet | education | 8 | Active |
| ib-sec-mcp | mcp | 2 | Active |
| freee-mcp | mcp | 4 | Active |
| cost-management-mcp | mcp | 1 | Active |
| english-note-maker | education | 1 | Active |
| simple-bookkeeping | fintech | 98 | **Abandoned** ↑ (was Dormant) |
| td-mcp-server | mcp | 273 | Abandoned |
| meditation-chrome-extension | tool | 307 | Abandoned |
| remotion-math-education | education | 320 | Abandoned |

### Private repos
| Repo | Days inactive | Status |
|------|--------------|--------|
| market-lens-studio | 15 | Active |
| workflow-engine | 1 | Active |
| ut-gymnastics | 18 | Active |
| jgrants-app | 18 | Active |
| household-finance | 55 | Dormant |
| line-advisor | — | On-hold (excluded) |
| story-bridge | — | On-hold (excluded) |

---

## Health trend (public repos, weekly)

| Date | GREEN | YELLOW | RED |
|------|-------|--------|-----|
| 2026-03-27 | 3 | 2 | 5 |
| 2026-04-05 | 4 | 1 | 5 |
| 2026-04-12 | 6 | 0 | 4 |
| 2026-04-19 | 6 | 0 | 4 |
| 2026-04-26 | 6 | 0 | 4 |

Direction: GREEN stabilised at 6 for the past three checks. The 4 RED repos are persistent neglected repos (simple-bookkeeping, td-mcp-server, meditation-chrome-extension, remotion-math-education). No regressions in the active cluster.

### Notable status change this month
- **simple-bookkeeping**: crossed 90-day inactivity threshold → reclassified Dormant → **Abandoned**. 45 open issues and 8 open PRs remain frozen. This is the largest open-issue debt in the portfolio.

---

## Key activity this month (April → May 3)

**Education cluster — very active**
- kanji-practice: Klee One web-font rollout (PRs #27-28) ensures educational typeface in all browsers; copybook mode deepened to 1-3 practice rows (PRs #29-30), 2-3× practice volume per problem
- math-worksheet: number-tracing preschool worksheet (PRs #56, #60-63) extends the audience down to 年長; fraction layout overhaul fixes A4 overflow across 5 patterns (PRs #58-59)
- english-note-maker: paged deduplication helper + difficulty presets across all modes (PRs #26, #28)

**MCP cluster — steady delivery**
- freee-mcp: first structured-content tool output (PR #178, KPI dashboard); Zod 4 migration (PR #176); axios security pin (PR #173)
- ib-sec-mcp: FastMCP 3.x migration (PR #112); positions pagination fix (PR #105); gitleaks CI fix (PR #104)
- cost-management-mcp: CI schedule fix (PR #147); Zod v4 upgrade now live

**Private repos**
- workflow-engine: Sonnet 4.6 upgrade (PR #150); duplicate Notion task fix (PR #149) — active infra
- market-lens-studio: weekly retrospective CI workflow (PR #169); article dedup hardening (PR #161, #162)

---

## Cross-repo analysis

### Common technology / integration opportunities

**1. MCP shared foundation**
freee-mcp, cost-management-mcp, ib-sec-mcp all share: TypeScript/Python MCP tool registration, schema-validated inputs (Zod), external API adapters, structured-output ambitions.
- freee-mcp has the first structured-content tool; pattern should be ported to ib-sec-mcp (has 5 open issues, structured output for portfolio/positions is a direct next step) and cost-management-mcp.
- Zod 4 migration is complete in freee-mcp and cost-management-mcp; ib-sec-mcp (Python, FastMCP) does not apply, but elicitation / safety workflow patterns from the MCP spec 2025-06-18 apply to all three.

**2. Education generator shared platform**
kanji-practice, math-worksheet, english-note-maker are all print-first A4 generators built with React + zustand/state store patterns.
- All three expanded content scope this month. The shared investment opportunity is a common A4-layout test harness and a shared spiral-review preset framework (cumulative review, mistake-driven regeneration).
- math-worksheet now targets 年長 (age 5-6); kanji-practice targets grades 1-6; english-note-maker targets international school students — the three cover the full K-6 curriculum range. Portfolio coherence is strong.

**3. Finance pipeline convergence**
- simple-bookkeeping is functionally abandoned at 45 open issues / 98 days inactive. household-finance is the active fintech axis (Python pipeline, anomaly detection, Notion import).
- If the fintech axis is to be maintained, household-finance should be the primary vehicle; simple-bookkeeping needs a deliberate triage decision (archive or scope-cut to minimal blue-return reporter only).

### Repos with excess maintenance load
- **freee-mcp**: 16 open issues / 15 open PRs (estimated from 2026-04-26 trend) — PR queue too deep for the activity level; need merge-down cadence
- **simple-bookkeeping**: 45 open issues / 8 open PRs, fully stalled — archive candidate, not a queue-management problem
- **ib-sec-mcp**: 5 open issues, open PRs from Codex runs — manageable if reviewed promptly

---

## Abandoned repos: archive recommendation

### simple-bookkeeping (newly Abandoned)
- **Recommendation**: triage required — archive, or cut scope to minimal MVP
- Why: 98 days inactive (pushed 2026-01-25), 45 open issues, 8 open PRs. The cognitive debt is real: every PM pass flags this repo but no commits follow.
- Revival condition: Ken explicitly decides to resume for tax-filing season with a scope-limited milestone (e.g., basic BS/PL report for 2025 filing only). Without that trigger, archive.

### td-mcp-server
- **Recommendation**: archive — no change from last month
- Why: 273 days inactive, Treasure Data is not an active data source
- Revival condition: TD becomes active again, or shared MCP base makes completion cheap

### meditation-chrome-extension
- **Recommendation**: archive — no change
- Why: 307 days inactive, no PRs, no issues, isolated from portfolio direction

### remotion-math-education
- **Recommendation**: archive — no change
- Why: 320 days inactive. math-worksheet and kanji-practice already cover the learner. Video axis has no active roadmap.

---

## PM Retrospective (2026-04 → 2026-05-03)

- Focus: education cluster expansion, MCP structured-output adoption, infra fixes
- Issues created this period: focus-task cron produced issues for ib-sec-mcp (structured output) and kanji-practice (cumulative review presets); estimate 3-4 new issues
- Open PM-tracked issues: ~2-3
- Top health signal: education cluster is the strongest delivery axis — 3 active repos, all pushed within 8 days

---

## Recommendation for June

1. **freee-mcp PR queue**: merge or close open PRs down from 15 to ≤5. Review cadence, not more feature work.
2. **simple-bookkeeping decision**: explicitly archive or define a scope-limited revival milestone before next portfolio review. The stall is costing PM bandwidth every cycle.
3. **Education cluster next priority**: shared spiral-review presets (cumulative-review) in math-worksheet and kanji-practice — both KB files flag this as the highest-leverage next step.
4. **ib-sec-mcp structured output**: port freee-mcp's structured-content pattern to portfolio/positions tools — low effort, high payoff for AI-rendered tables.
5. **Archive candidates**: propose archiving td-mcp-server, meditation-chrome-extension, remotion-math-education to Ken for approval; no action taken autonomously.
