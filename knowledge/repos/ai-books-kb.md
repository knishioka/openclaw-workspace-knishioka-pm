# ai-books Knowledge Base

## Overview
- Repo: knishioka/ai-books
- Description: AI-first accounting MCP server — interface for AI agents, not humans
- Primary language (GitHub): Shell
- License: MIT
- Default branch: main
- Created: 2026-05-25
- Updated: 2026-06-05
- Collected: 2026-06-05

## Tech Stack
- package.json: not found (or not accessible via GitHub contents API)
- pyproject.toml: present
- requirements.txt: not found

## Architecture / Patterns

- (No clear patterns inferred from README/dependencies in this snapshot)
- ADR-backed accounting design log
- AI-agent development guardrails
- e-Tax handoff workflow

## Tech Decisions (from PRs/commits)

- [2026-06-05] Adopt retro-ADRs and ADR process -- Architecture and accounting-policy decisions are now captured as ADRs so future agent work has an explicit design memory. (source: PR #100)
- [2026-06-05] Use module map and testing-guarantees inventory as contribution guide -- The repo documents module ownership and required tests before adding capabilities, reducing drift in AI-assisted changes. (source: PR #99)
- [2026-06-05] Map KOA210 operating-outside interest expense to AMF00330 and defer KOA220/240 -- e-Tax mapping policy now handles 利子割引料 via AMF00330 while leaving unclear KOA220/240 cases deferred. (source: PR #97)
- [2026-06-05] Add hooks, guardrails, and project subagents for dev workflow -- Repository automation now encodes guardrails and specialized subagents rather than relying only on prose instructions. (source: PR #101/#102)
- [2026-06-05] Eliminate general-ledger N+1 queries in whole-book path -- Reporting performance was improved by replacing per-row lookup behavior in the general ledger path. (source: PR #95)
- [2026-05-25] feat: M0 bootstrap scaffold -- (Why not stated in PR/commit body) (source: commit 95f4a91)
- [2026-05-25] Initial commit -- (Why not stated in PR/commit body) (source: commit 772705b)

## Competitive Landscape

- [2026-05-29] MCP SDK baseline: Python SDK `mcp` is v1.27.1 (published 2026-05-08) and TypeScript SDK is v1.29.0 (published 2026-03-30). The official Python README says v1.x is current stable while v2 is pre-alpha on `main`; keep `ai-books` on stable Python SDK until v2 transport/API churn settles. Sources: PyPI `mcp`, GitHub `modelcontextprotocol/python-sdk`, GitHub releases.
- [2026-05-29] Accounting automation trend: 2026 AI bookkeeping tools are moving from generic OCR/read-only extraction toward workflow-integrated close automation, but adoption remains limited by rule tuning and human-in-the-loop review. Feature candidates: journal-entry validation explanations, review queue for uncertain account mappings, and CSV import dry-run with debit/credit proof before write tools.
