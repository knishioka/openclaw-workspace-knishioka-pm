# Knowledge Changelog

As of: 2026-04-03

## This week’s new discoveries / updates

### knishioka/math-worksheet

- [2026-03-28..2026-03-30] Singapore Math problem family expanded (Grade 1-6 → Grade 4-6 coverage added with 10 new generators). (source: PR #47, #53)
- [2026-03-29] Added an **automated verification layer** (runtime assertions + property-based tests + expanded Playwright verification combos). This is a strong pattern for preventing “print a wrong worksheet” regressions as generator count grows. (source: PR #52)
- [2026-03-29] Fixed a structural duplication bug in Grade 1 (+1/+2) when using 2-column layouts (pool exhaustion modulo → reshuffle). (source: PR #51)

### knishioka/freee-mcp

- [2026-03-31] Security response: pinned axios to **1.14.0** to avoid auto-resolving a compromised upstream release (caret range removed). (source: PR #173)
- [2026-04-03] MCP ecosystem note: `@modelcontextprotocol/sdk` latest is **1.29.0** (confirmed via `npm view`). Spec changelog highlights point to ongoing auth/transport evolution (Streamable HTTP, OAuth2.1 guidance, metadata). (ref: https://modelcontextprotocol.io/specification/2025-11-25/changelog)

### knishioka/cost-management-mcp

- [2026-03-28] Fixed schedule-only CI workflow failures (github-script `core` double-declare; TruffleHog schedule scan mode split). (source: PR #147)

### knishioka/kanji-practice

- [2026-04-03] Competitive landscape snapshot recorded (Kakikata Generator, Kanji.sh, MichiKanji, TestMaker, Canva furigana). Feature candidates: custom vocab import + shareable sets, JLPT/漢検切り口フィルタ, “弱点だけ再生成”導線.

## New feature candidates (from competitive / trend research)

- freee-mcp: consider **Streamable HTTP transport** support + re-check auth discovery / incremental consent alignment as MCP spec evolves.
- kanji-practice: add **custom vocabulary import** + **weak-point based regeneration** (review loop) to differentiate vs static worksheet generators.

## Staleness watch (priority=high)

- No priority=high repos exceeded 8 weeks without KB updates (based on this job’s 2026-04-03 collection).
