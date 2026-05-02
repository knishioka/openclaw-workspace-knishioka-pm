# Monthly Portfolio Review — 2026-05

Generated: 2026-05-02 (Asia/Kuala_Lumpur)
Scope: 10 public repos + 7 private repos (5 active, 2 on-hold excluded)

---

## 1. Portfolio Health Snapshot

| Repo | Category | Days Inactive | Status | Open Issues |
|------|----------|:---:|:---:|:---:|
| kanji-practice | education | 0 | ✅ Active | 1 |
| math-worksheet | education | 7 | ✅ Active | 2 |
| ib-sec-mcp | mcp | 1 | ✅ Active | 5 |
| freee-mcp | mcp | 3 | ✅ Active | 16 |
| cost-management-mcp | mcp | 0 | ✅ Active | 6 |
| english-note-maker | education | 0 | ✅ Active | 0 |
| simple-bookkeeping | fintech | 97 | 🔴 Abandoned | 45 |
| td-mcp-server | mcp | 272 | 🔴 Abandoned | 2 |
| meditation-chrome-extension | tool | 306 | 🔴 Abandoned | 0 |
| remotion-math-education | education | 319 | 🔴 Abandoned | 0 |

**Private repos (name + classification only):**

| Repo | Days Inactive | Status |
|------|:---:|:---:|
| market-lens-studio | 14 | ✅ Active |
| workflow-engine | 0 | ✅ Active |
| ut-gymnastics | 17 | ✅ Active |
| jgrants-app | 17 | ✅ Active |
| household-finance | 54 | 🟡 Dormant |
| line-advisor | — | ⏸ On-hold (excluded) |
| story-bridge | — | ⏸ On-hold (excluded) |

**Summary:** 10 Active / 1 Dormant / 4 Abandoned (of 15 tracked repos)

---

## 2. 1-Month Trend (April 2026)

From weekly health snapshots (2026-03-27 → 2026-04-26):

| Date | GREEN | YELLOW | RED |
|------|:---:|:---:|:---:|
| 2026-03-27 | 3 | 2 | 5 |
| 2026-04-05 | 4 | 1 | 5 |
| 2026-04-12 | **6** | 0 | 4 |
| 2026-04-19 | 6 | 0 | 4 |
| 2026-04-26 | 6 | 0 | 4 |

**Key changes in April:**
- **ib-sec-mcp**: RED → GREEN (FastMCP 3.x migration + CI fix, April 12)
- **cost-management-mcp**: RED → GREEN (active development resumed, April 5)
- **english-note-maker**: YELLOW → GREEN (phonics mode + cloze mode shipped, April 11-16)
- **simple-bookkeeping**: YELLOW → RED (crossed 90-day inactivity threshold)
- **freee-mcp**: Consistently GREEN; accumulated PR backlog (15→16 open issues) is the only concern

---

## 3. Cross-Repo Analysis

### 3-1. MCP Server Cluster

Four MCP servers share architecture patterns:

| Repo | Lang | Pattern | Status |
|------|------|---------|--------|
| freee-mcp | TypeScript | Zod v4 schema + typed tool registry | ✅ Active |
| cost-management-mcp | TypeScript | Zod v4 + provider registry | ✅ Active |
| ib-sec-mcp | Python | FastMCP 3 + pydantic tools | ✅ Active |
| td-mcp-server | Python | Basic MCP + pydantic | 🔴 Abandoned |

**Integration opportunity:** freee-mcp and cost-management-mcp both migrated to Zod v4 and share TypeScript MCP patterns. A shared `@knishioka/mcp-utils` package (schema helpers, error formatting, structured-content utilities) could eliminate duplication. Low priority but worth extracting if a 3rd TypeScript MCP server is added.

**MCP spec opportunity:** MCP spec 2025-06-18 structured output + elicitation is relevant to all three active MCP servers. freee-mcp already shipped structured KPI output (PR #178). ib-sec-mcp and cost-management-mcp are next candidates.

### 3-2. Education Worksheet Cluster

Three active print-first A4 generators:

| Repo | Content | Recent activity |
|------|---------|-----------------|
| kanji-practice | Kanji 1-6th grade | Learning presets, Klee One font, sentence mode polish |
| math-worksheet | Math K-6 | Toddler tracing mode, URL state, Singapore Math |
| english-note-maker | English 4-line notebook | Phonics, cloze, difficulty presets |

**Common architecture:** All three share print-first A4 layout + client-side generation + A4 overflow detection. They've evolved independently with similar solutions (auto-layout, page dedup, difficulty presets).

**Integration opportunity:** A shared `@knishioka/worksheet-layout` library (A4 layout engine, page capacity calculations, paged dedup helpers) could be extracted. Currently low priority — each repo has its own QA cadence and the overhead of a shared package is not yet justified.

### 3-3. Fintech Cluster

| Repo | Purpose | Status |
|------|---------|--------|
| freee-mcp | Accounting API (MCP) | ✅ Active — KPI, advisory, AR aging tools |
| household-finance | Expense import pipeline | 🟡 Dormant (54d) |
| simple-bookkeeping | Double-entry bookkeeping | 🔴 Abandoned (97d, 45 issues) |

**Overlap risk:** freee-mcp now covers analysis, KPI, and journal consistency checks. simple-bookkeeping was targeting blue-return (青色申告) filing — a distinct use case (domestic tax form generation) not covered by freee-mcp. However, 97 days of inactivity and 45 open issues signal it is not being maintained.

**household-finance** is dormant (54 days) but has a clear seasonal purpose (monthly expense review). Not at abandonment threshold yet. Recommend checking at next review.

### 3-4. Over-Issue Repos

| Repo | Open Issues | Risk |
|------|:---:|-----|
| simple-bookkeeping | **45** | 🔴 Abandoned; issues are stale backlog |
| freee-mcp | 16 | 🟡 Active repo, but issue-to-commit ratio is high |
| cost-management-mcp | 6 | 🟡 Acceptable, monitor |

simple-bookkeeping's 45 open issues are noise — no active development to resolve them. If archiving, closing all issues is part of the cleanup.

---

## 4. Abandoned Repo Disposition

### simple-bookkeeping (97 days, 45 open issues)
**Recommendation: Archive**
- Functional overlap with freee-mcp increasing
- 45 open issues = unmaintainable backlog
- No commits since 2026-01-25
- **Revival condition:** A specific need to generate 青色申告 PDF forms that freee doesn't cover, and a committed 2-week sprint. Set a deadline: if no commit by 2026-08-01, archive.

### td-mcp-server (272 days)
**Recommendation: Archive**
- Treasure Data is not in the current tech stack
- No strategic value
- 2 open PRs (stale Codex drafts) — can be closed with archive
- No revival condition identified

### meditation-chrome-extension (306 days)
**Recommendation: Archive**
- Pure side project with no integration value
- Chrome extension ecosystem has moved on (Manifest V3 migration may have broken it)
- No revival condition

### remotion-math-education (319 days)
**Recommendation: Archive**
- Video generation use case is now superseded by the worksheet cluster (print-first approach proved more practical)
- Remotion is a heavyweight dependency for a personal project
- No revival condition

---

## 5. PM Retrospective (April 2026)

### What went well
- Education cluster had a strong month: english-note-maker shipped phonics + cloze modes; kanji-practice shipped learning presets and font improvements; math-worksheet added toddler tracing
- ib-sec-mcp recovered cleanly from RED (FastMCP migration, CI fix)
- freee-mcp structured output milestone (KPI dashboard, PR #178)
- workflow-engine active with Sonnet 4.6 upgrade and PR dedup fixes

### Concerns
- **freee-mcp PR backlog**: 15 open PRs in March trended down to 16 open issues now. Most are feature proposals — acceptable if triaged but worth a review pass.
- **simple-bookkeeping** is now technically abandoned. The 45-issue count is misleading; cleanup is needed regardless of archive decision.
- **household-finance** went dormant during a period when the import pipeline was functional. If the pipeline is running, dormancy may be intentional. No action needed now.

### Focus for May 2026
1. **freee-mcp**: Structured output for ledger/aging/comparison tools (next structured-output candidates after KPI dashboard)
2. **ib-sec-mcp**: Elicitation guards for order placement (safety improvement per MCP spec)
3. **kanji-practice**: Cumulative review presets (spaced retrieval — high educational impact)
4. **Archive decision**: Bring simple-bookkeeping + td-mcp-server archive to Ken for approval

---

## 6. Portfolio Metrics

| Metric | Value |
|--------|-------|
| Total repos tracked | 15 (excl. 2 on-hold) |
| Active (≤30d) | 10 |
| Dormant (31-90d) | 1 |
| Abandoned (>90d) | 4 |
| Archive candidates this month | 4 |
| Repos with CI green | 6/10 public (abandoned repos excluded from CI) |
| Total open issues (public) | 77 |
| Issues in abandoned repos | 47 (61% of total — noise) |
