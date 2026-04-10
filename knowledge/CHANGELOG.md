# Knowledge Changelog

As of: 2026-04-10

## This week’s new discoveries / updates

### knishioka/math-worksheet

- [2026-04-10] fix: Bar Model diagram overflow and Grade 4-6 number ranges (source: commit 5bd8d57)
- [2026-04-10] EdTech trend: adaptive math practice is increasingly organized around **skill-gap targeting** rather than static worksheet batches. That suggests value in reusing this repo's generator catalog for “next worksheet from mistakes” flows, not only one-off printing. (refs: https://www.discoveryeducation.com/blog/teaching-and-learning/adaptive-learning-supports-foundational-math-and-reading/ , https://www.mathbrix.com/blog/adaptive-learning-platforms-math/)
- [2026-04-10] Pedagogy trend: spaced / interleaved retrieval is being emphasized for durable math retention. Printable products can differentiate by generating **cumulative mixed review pages** instead of only topic-isolated sheets. (refs: https://www.mathematicshub.edu.au/plan-teach-and-assess/teaching/teaching-strategies/spaced-interleaved-and-retrieval-practice/ , https://www.carnegielearning.com/blog/retrieval-practice-guide-download)
- Add a **mistake-driven regeneration mode** that reissues similar-but-not-identical problems for weak skills.
- Add **spiral review worksheet presets** that intentionally mix prior topics across grades / units.

### knishioka/ib-sec-mcp

- [2026-04-10] Competitive note: IBKR already exposes rich portfolio/account analytics via Client Portal + PortfolioAnalyst (allocation, risk measures, benchmark comparison). Differentiation for this repo is **AI-ready tool ergonomics** rather than raw analytics breadth. (refs: https://www.interactivebrokers.com/campus/ibkr-api-page/web-api-trading/ , https://www.interactivebrokers.com/en/portfolioanalyst/features.php)
- [2026-04-10] MCP trend: community IBKR MCP servers are appearing, but many are alpha-grade and trading-focused. A safer niche for this repo is **paper-trading-first workflows, explainable risk checks, and portfolio/account introspection before execution**. (refs: https://github.com/code-rabi/interactive-brokers-mcp , https://github.com/ArjunDivecha/ibkr-mcp-server)
- Add a **read-only portfolio/risk summary toolset** (allocation drift, concentration, realized/unrealized P&L rollups) to complement the new live-order tools.
- Add an explicit **execution safety mode**: dry-run previews, pre-trade guardrails, and paper/live environment labeling in every tool response.

## New feature candidates (from competitive / trend research)

- ib-sec-mcp: add **read-only portfolio/risk summary tools** plus clearer paper/live safety labels and dry-run previews.
- math-worksheet: add **mistake-driven regeneration** and **spiral review worksheet presets** aligned with adaptive + retrieval-practice trends.

## Staleness watch (priority=high)

- No priority=high repos exceeded 8 weeks without KB updates in this run.
