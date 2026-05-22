# Knowledge Changelog - 2026-05-22

Only new findings since 2026-05-15 are listed.

## knishioka/market-lens-studio

- [2026-05-17] PR #182: unblocked the note article retrospect measurement pipeline by fixing the weekly workflow script path and making generation metadata persistence reachable from `/note:write`.
- [2026-05-17] PR #181: migrated Claude Code PreToolUse hook denial output to `hookSpecificOutput.permissionDecision` and exempted `gh` commands whose PR/issue text contains blocked command patterns.

## Competitive Research Findings

- ib-sec-mcp: MCP remote-server baseline is Streamable HTTP plus explicit Origin/auth protections; Python SDK v1.27.x also adds StreamableHTTP idle timeout and OAuth/resource-validation fixes. Feature candidates: remote transport readiness checklist, SDK pin/watch, OAuth/resource validation regression tests.
- kanji-practice: 2026 education trend signal favors AI-assisted differentiation and feedback while preserving handwriting practice. Feature candidates: "differentiate this sheet", scanned/self-check weak-kanji tracking, and targeted A4 review-sheet regeneration.

## Staleness Warnings

- None: all priority=high repositories were collected this week.
