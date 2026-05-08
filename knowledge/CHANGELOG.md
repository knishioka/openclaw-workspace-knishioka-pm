# Knowledge Changelog

As of: 2026-05-08

## New findings this week

- knishioka/ib-sec-mcp: feat: add earnings calendar MCP tool (PR #115, 2026-05-01)
- knishioka/english-note-maker: feat(alphabet): expand vocabulary and add tracing mode (PR #29, 2026-05-02)
- knishioka/cost-management-mcp: chore: adopt knishioka/openclaw-workspace-ds-pm baseline (PR #148, 2026-05-02)
- knishioka/kanji-practice: feat: harness pack (AGENTS.md / verify.sh / PR template) — Phase B PoC (PR #32, 2026-05-02)
- knishioka/english-note-maker: feat(alphabet): beginner-friendly tracing — non-italic, full-line, repeated horizontally (PR #30, 2026-05-02)
- knishioka/workflow-engine: feat(notion): auto-close Notion tasks when their GitHub PR is merged (PR #151, 2026-05-02)
- knishioka/cost-management-mcp: fix(security): resolve fast-xml-parser audit finding (PR #150, 2026-05-04)
- knishioka/english-note-maker: fix(build): restore Vite and typecheck pipeline (PR #31, 2026-05-04)
- knishioka/english-note-maker: fix(alphabet): align tracing guides with handwriting lines (PR #32, 2026-05-04)
- knishioka/english-note-maker: fix(alphabet): refine lowercase tracing baseline position (PR #33, 2026-05-04)
- knishioka/english-note-maker: fix(alphabet): use bundled tracing font (PR #34, 2026-05-04)
- knishioka/math-worksheet: fix(number-tracing): refine handwritten digit strokes (PR #64, 2026-05-04)
- knishioka/math-worksheet: fix(number-tracing): match reference handwriting strokes (PR #65, 2026-05-05)
- knishioka/market-lens-studio: fix(workflow): unblock jq + tee pipelines for /note:write --auto runs (PR #177, 2026-05-05)
- knishioka/freee-mcp: test: migrate Jest suite to Vitest (PR #180, 2026-05-05)
- knishioka/kanji-practice: research -> Education trend: Khan Academy's Khanmigo Interests emphasizes learner-specific personalization based on saved interests, reinforcing that engagement is shifting from static practice sheets to context-aware practice experiences. kanji-practice is print-first today, but even lightweight personalization like student goal presets or favorite-theme sentence pools would align with the direction without abandoning printable UX. (source: Khan Academy, "New! Personalized AI Learning with Khanmigo Interests", 2025-03-21; fetched 2026-05-08)
- knishioka/kanji-practice: research -> Competitive implication: worksheet tools increasingly need a bridge between reusable teacher defaults and learner-level personalization. A strong next step is shareable study profiles that bundle grade, target set, review cadence, and sentence difficulty into one printable link. (source: Khan Academy personalization article above + existing repo preset/link-sharing direction)
- knishioka/ib-sec-mcp: research -> MCP SDK latest stable on npm remains 1.29.0, while the 2026-04-01 TypeScript SDK pre-release adds Standard Schema support, TaskManager extraction, and stricter protocol error handling. For a broker-facing MCP server, the practical opportunity is richer structured outputs and resumable long-running portfolio tasks without waiting for another stable line. (sources: npm registry @modelcontextprotocol/sdk latest=1.29.0 fetched 2026-05-08; GitHub releases 2026-04-01)
- knishioka/ib-sec-mcp: research -> Competitive direction: MCP ecosystem is moving from plain text tool responses toward typed tool/prompt schemas and explicit task orchestration. ib-sec-mcp can differentiate by exposing holdings/risk/order-preview payloads as machine-readable structures first, then layering confirmation flows for live trading mutations. (source: modelcontextprotocol/typescript-sdk releases, 2026-04-01)

## Competitive / trend research

- ib-sec-mcp: MCP SDK latest stable on npm remains 1.29.0, while the 2026-04-01 TypeScript SDK pre-release adds Standard Schema support, TaskManager extraction, and stricter protocol error handling. For a broker-facing MCP server, the practical opportunity is richer structured outputs and resumable long-running portfolio tasks without waiting for another stable line. (sources: npm registry @modelcontextprotocol/sdk latest=1.29.0 fetched 2026-05-08; GitHub releases 2026-04-01)
- ib-sec-mcp: Competitive direction: MCP ecosystem is moving from plain text tool responses toward typed tool/prompt schemas and explicit task orchestration. ib-sec-mcp can differentiate by exposing holdings/risk/order-preview payloads as machine-readable structures first, then layering confirmation flows for live trading mutations. (source: modelcontextprotocol/typescript-sdk releases, 2026-04-01)
- kanji-practice: Education trend: Khan Academy's Khanmigo Interests emphasizes learner-specific personalization based on saved interests, reinforcing that engagement is shifting from static practice sheets to context-aware practice experiences. kanji-practice is print-first today, but even lightweight personalization like student goal presets or favorite-theme sentence pools would align with the direction without abandoning printable UX. (source: Khan Academy, "New! Personalized AI Learning with Khanmigo Interests", 2025-03-21; fetched 2026-05-08)
- kanji-practice: Competitive implication: worksheet tools increasingly need a bridge between reusable teacher defaults and learner-level personalization. A strong next step is shareable study profiles that bundle grade, target set, review cadence, and sentence difficulty into one printable link. (source: Khan Academy personalization article above + existing repo preset/link-sharing direction)

## Knowledge freshness

- No priority=high repos are older than 8 weeks in KB freshness.
