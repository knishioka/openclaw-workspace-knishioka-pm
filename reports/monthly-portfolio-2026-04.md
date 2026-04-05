# Monthly Portfolio Review (2026-04)

As of: 2026-04-05
Summary: Active 9 / Dormant 1 / Abandoned 7

>> Changes this month:
  cost-management-mcp: Dormant級の停滞から Active 復帰（最終 push 8日前）
  english-note-maker: Dormant → Abandoned（最終 push 93日前）
  Public health trend: 直近記録3点では RED 5 / YELLOW 2 / GREEN 3 のまま横ばい

>> Risks / Blockers:
  ib-sec-mcp  RED 継続 + open PR 4 で修正着手コスト高
  freee-mcp  open PR 15 でレビュー待ち滞留
  simple-bookkeeping  Dormant 69日 + open issue 37 / open PR 8 で過剰キュー
  Abandoned public repos 4件（english-note-maker / td-mcp-server / meditation-chrome-extension / remotion-math-education）

>> Next actions:
  MCP群: freee-mcp / cost-management-mcp を先行に共通基盤（tool metadata・schema validation・error normalization）を整理 → pending
  Education群: kanji-practice / math-worksheet / english-note-maker の A4印刷QAを共通化 → pending
  Abandoned群: public 4件は archive 判断、private 3件は分類維持のみ → pending

>> Confirmed:
  market-lens-studio  最終更新0日前 Active
  math-worksheet  最終更新4日前 Active
  freee-mcp  最終更新4日前 Active
  workflow-engine  最終更新6日前 Active
  kanji-practice  最終更新14日前 Active

---

## 1) Portfolio activity classification

### Public repos

**Active (<=30d)**
- knishioka/math-worksheet — 4d
- knishioka/freee-mcp — 4d
- knishioka/cost-management-mcp — 8d
- knishioka/kanji-practice — 14d
- knishioka/ib-sec-mcp — 14d

**Dormant (30–90d)**
- knishioka/simple-bookkeeping — 69d

**Abandoned (90d+)**
- knishioka/english-note-maker — 93d
- knishioka/td-mcp-server — 245d
- knishioka/meditation-chrome-extension — 279d
- knishioka/remotion-math-education — 291d

### Private repos (name + classification only)

**Active (<=30d)**
- knishioka/market-lens-studio — Active
- knishioka/workflow-engine — Active
- knishioka/household-finance — Active
- knishioka/ut-gymnastics — Active

**Dormant (30–90d)**
- none

**Abandoned (90d+)**
- knishioka/jgrants-app — Abandoned
- knishioka/line-advisor — Abandoned *(on-hold)*
- knishioka/story-bridge — Abandoned *(on-hold)*

## 2) Repo health trend (past month)

- `monitoring/health-trend.jsonl` has only **3 snapshots** in the last month: 2026-03-27 / 2026-03-28 / 2026-03-29.
- Across all 3 snapshots, public-repo health stayed flat at **GREEN 3 / YELLOW 2 / RED 5**.
- Meaningful movement inside that flat summary:
  - `cost-management-mcp` reactivated sharply (`days_inactive` 143 → 0 on 2026-03-28).
  - `math-worksheet` also returned to active development (`days_inactive` 6 → 0 on 2026-03-29), then shipped additional changes through 2026-03-31.
  - `ib-sec-mcp` stayed RED in every recorded snapshot, making it the clearest persistent public risk.
- Conclusion: the portfolio is not broadly deteriorating, but RED repos are not being burned down yet; progress is selective rather than portfolio-wide.

## 3) Cross-repo analysis from `knowledge/repos/*.md`

### Common technologies / integration opportunities

**MCP server cluster**
- Repos: `freee-mcp`, `cost-management-mcp`, `ib-sec-mcp`, `td-mcp-server`
- Shared patterns in KBs:
  - MCP tool registration / routing
  - schema validation
  - auth / pagination / error normalization
  - protocol-level or integration test scaffolding
- Best integration opportunity:
  - Start a small shared foundation for the TypeScript servers (`freee-mcp`, `cost-management-mcp`) covering tool metadata wiring, schema helpers, pagination helpers, and normalized errors.

**Education print-app cluster**
- Repos: `kanji-practice`, `math-worksheet`, `english-note-maker`
- Shared patterns in KBs:
  - browser-generated worksheet / notebook output
  - A4 print correctness as a core product requirement
  - recurring bugs around overflow, pagination, and fit-to-page behavior
- Best integration opportunity:
  - Extract a common print QA utility based on Playwright + DOM/layout checks for page count, overflow, and A4 margin validation.

### Repos with excessive maintenance load

- `freee-mcp` — **open PR 15**
  - Fast throughput, but the review queue is clearly piling up.
- `simple-bookkeeping` — **open issue 37 / open PR 8**
  - Largest backlog in the public portfolio while already Dormant.
- `ib-sec-mcp` — **RED + open PR 4**
  - CI instability magnifies merge and review cost.

## 4) Abandoned repos: archive recommendation / revival condition

### Public repos

- **knishioka/english-note-maker**
  - Recommendation: archive candidate unless reused as part of the shared education print platform.
  - Revival condition: make it the proving ground for common A4/print QA tooling or add a clearly differentiated learner workflow.

- **knishioka/td-mcp-server**
  - Recommendation: archive candidate.
  - Revival condition: a real Treasure Data use-case returns; first milestone should be CI/type-check recovery, not feature work.

- **knishioka/meditation-chrome-extension**
  - Recommendation: archive recommended.
  - Revival condition: a concrete publish or daily-use plan exists.

- **knishioka/remotion-math-education**
  - Recommendation: archive recommended.
  - Revival condition: video-based learning becomes a real product bet, with one end-to-end production path defined.

### Private repos

- Private abandoned repos are intentionally listed by name/classification only in this committed report.

## 5) PM retrospective (last 30 days)

From `monitoring/issue-tracker.jsonl`:
- Created: **7**
- Merged: **2**
- Open: **5**
- Avg days to resolve (merged only): **0.5 days**
- Quality score: **A = 2**

Interpretation:
- When work gets picked up, issue quality is good enough for fast resolution.
- The bottleneck is attention bandwidth, not issue clarity.
- April should bias toward backlog reduction and shared-foundation work instead of increasing issue count in already-loaded repos.
