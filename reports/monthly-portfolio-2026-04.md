# Monthly Portfolio Review (2026-04)

As of: 2026-04-04
Summary: RED 5 / YELLOW 2 / GREEN 3

>> Changes this month:
  cost-management-mcp: Dormant級の停滞 → Active 復帰（2026-03-28 にコミット再開、days_inactive 143→0）
  math-worksheet: Active を維持しつつ 2026-03-29〜03-31 に連続改善（重複バグ修正、検証層追加、Singapore Math拡張）
  english-note-maker: YELLOW維持だったが、活動分類では Abandoned に移行（最終 push 2026-01-01）

>> Risks / Blockers:
  ib-sec-mcp  CI failure 継続 + open PR 4 で手戻りコスト高
  freee-mcp  open PR 15 でレビュー/マージ待ち滞留
  simple-bookkeeping  open issue 37 / open PR 8、かつ Dormant で再開コスト高
  td-mcp-server  8か月停止、再開トリガー不明

>> Next actions:
  MCP群: freee-mcp / cost-management-mcp を先行対象に schema・tool metadata・error normalization の共通基盤メモを作る → pending
  Education群: kanji-practice / math-worksheet / english-note-maker で A4印刷レイアウト検証を共通化 → pending
  Abandoned群: archive候補を整理し、復活条件が弱いものは月内に方針決定 → pending

>> Confirmed:
  kanji-practice  最終更新13日前 GREEN
  math-worksheet  最終更新4日前 GREEN
  freee-mcp  最終更新4日前 GREEN

---

## 1) Portfolio activity classification (last push 기준)

### Public repos

**Active (<=30d)**
- knishioka/math-worksheet — 2026-03-31
- knishioka/freee-mcp — 2026-03-31
- knishioka/cost-management-mcp — 2026-03-28
- knishioka/kanji-practice — 2026-03-22
- knishioka/ib-sec-mcp — 2026-03-21

**Dormant (30–90d)**
- knishioka/simple-bookkeeping — 2026-01-25

**Abandoned (90d+)**
- knishioka/english-note-maker — 2026-01-01
- knishioka/td-mcp-server — 2025-08-03
- knishioka/meditation-chrome-extension — 2025-06-30
- knishioka/remotion-math-education — 2025-06-17

### Private repos (name + classification only)

**Active (<=30d)**
- knishioka/workflow-engine
- knishioka/market-lens-studio
- knishioka/household-finance
- knishioka/ut-gymnastics

**Dormant (30–90d)**
- none

**Abandoned (90d+)**
- knishioka/jgrants-app
- knishioka/line-advisor *(on-hold)*
- knishioka/story-bridge *(on-hold)*

## 2) Repo health trend (last month)

- `monitoring/health-trend.jsonl` has only **3 snapshots** in the last month: 2026-03-27 / 03-28 / 03-29.
- Across those snapshots, portfolio health stayed **flat at GREEN 3 / YELLOW 2 / RED 5**.
- Meaningful movement inside the flat summary:
  - `cost-management-mcp` reactivated sharply (`days_inactive` 143 → 0 on 2026-03-28) but was still RED because CI remained broken at that point.
  - `math-worksheet` moved to `days_inactive` 0 on 2026-03-29 and then shipped multiple follow-up changes by 2026-03-31.
  - `ib-sec-mcp` stayed RED across all recorded snapshots, so this is the clearest persistent execution risk.
- Conclusion: the portfolio is **not worsening overall**, but RED repos are not being burned down yet; the main change is selective reactivation rather than broad stabilization.

## 3) Cross-repo analysis (knowledge/repos/*.md)

### Common technologies / integration opportunities

**A. MCP server cluster**
- Repos: `freee-mcp`, `cost-management-mcp`, `ib-sec-mcp`, `td-mcp-server`
- Shared patterns seen in KBs:
  - MCP tool registration / routing
  - schema validation (especially Zod in TypeScript repos)
  - external API auth / pagination / error normalization
  - protocol and integration test scaffolding
- Best integration opportunity:
  - Create a small shared MCP toolkit for the TypeScript servers first (`freee-mcp`, `cost-management-mcp`), focused on:
    - schema → tool metadata wiring
    - shared pagination helpers
    - normalized error formatting
    - ListTools / CallTool test fixtures
- Why this matters:
  - `freee-mcp` is adding many tools quickly
  - `cost-management-mcp` already centralized provider definitions and handler routing
  - there is enough repetition now that copy-paste cost is likely higher than extraction cost

**B. Education print apps**
- Repos: `kanji-practice`, `math-worksheet`, `english-note-maker`
- Shared patterns seen in KBs:
  - browser-generated worksheets / notebooks
  - A4 print layout correctness as core product value
  - repeated bugs around overflow, pagination, and fit-to-page behavior
  - Playwright-based verification already exists in parts of the portfolio
- Best integration opportunity:
  - Extract a shared print-layout verification utility or script set:
    - A4 overflow detection
    - page count validation
    - layout margin checks
    - scenario-based regression capture via Playwright
- Why this matters:
  - this is the same class of failure recurring in all three repos
  - solving it once should reduce PM noise and bugfix churn

### Repos showing excessive workload / queue pressure

Using the latest public repo signals available:
- `freee-mcp`: **open PR 15**
  - Fast feature throughput, but review queue is clearly piling up.
- `simple-bookkeeping`: **open issue 37 / open PR 8**
  - Biggest backlog in the portfolio while already Dormant.
  - This is the strongest sign of over-commitment versus available maintenance bandwidth.
- `ib-sec-mcp`: **open PR 4 + persistent RED health**
  - Not huge by count, but risky because CI failure compounds merge friction.

## 4) Abandoned repos: archive recommendation or revival condition

### Public repos

- **knishioka/english-note-maker**
  - Recommendation: **keep only if it becomes part of the shared education print platform; otherwise archive candidate**.
  - Revival condition: reuse as a proving ground for common A4/print QA tooling or add a clearly differentiated learner workflow.

- **knishioka/td-mcp-server**
  - Recommendation: **archive candidate**.
  - Revival condition: a real Treasure Data use-case returns, with the first milestone being CI/type-check recovery rather than feature work.

- **knishioka/meditation-chrome-extension**
  - Recommendation: **archive recommended**.
  - Revival condition: a concrete publish/usage plan exists (Chrome Web Store release, personal daily use, or distribution target).

- **knishioka/remotion-math-education**
  - Recommendation: **archive recommended**.
  - Revival condition: a specific video-based learning workflow is prioritized over printable worksheets, with one end-to-end production path defined.

### Private repos (detail withheld by policy)

- **knishioka/jgrants-app** — archive candidate; revive only if a subsidy-application use case returns.
- **knishioka/line-advisor** — on-hold; keep parked unless priority changes.
- **knishioka/story-bridge** — on-hold; keep parked unless priority changes.

## 5) PM retrospective (last 30 days)

From `monitoring/issue-tracker.jsonl`:
- Created: **7**
- Merged: **2**
- Open: **5**
- Avg days to resolve (merged only): **0.5 days**
- Quality score: **A = 2**

Interpretation:
- When work gets picked up, issue quality is good enough for fast resolution.
- The constraint is not issue clarity; it is **attention bandwidth** on the remaining open queue.
- For April, the PM bias should be:
  - fewer new issues in already-loaded repos
  - more consolidation / backlog reduction / shared-foundation work
