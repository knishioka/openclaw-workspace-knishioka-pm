# ai-books Design Decisions

## 2026-06-05: Adopt retro-ADRs and ADR process

- **What**: Adopt retro-ADRs and ADR process
- **Why**: Architecture and accounting-policy decisions are now captured as ADRs so future agent work has an explicit design memory.
- **Source**: PR #100

## 2026-06-05: Use module map and testing-guarantees inventory as contribution guide

- **What**: Use module map and testing-guarantees inventory as contribution guide
- **Why**: The repo documents module ownership and required tests before adding capabilities, reducing drift in AI-assisted changes.
- **Source**: PR #99

## 2026-06-05: Map KOA210 operating-outside interest expense to AMF00330 and defer KOA220/240

- **What**: Map KOA210 operating-outside interest expense to AMF00330 and defer KOA220/240
- **Why**: e-Tax mapping policy now handles 利子割引料 via AMF00330 while leaving unclear KOA220/240 cases deferred.
- **Source**: PR #97

## 2026-06-05: Add hooks, guardrails, and project subagents for dev workflow

- **What**: Add hooks, guardrails, and project subagents for dev workflow
- **Why**: Repository automation now encodes guardrails and specialized subagents rather than relying only on prose instructions.
- **Source**: PR #101/#102

## 2026-06-05: Eliminate general-ledger N+1 queries in whole-book path

- **What**: Eliminate general-ledger N+1 queries in whole-book path
- **Why**: Reporting performance was improved by replacing per-row lookup behavior in the general ledger path.
- **Source**: PR #95

## 2026-05-25: feat: M0 bootstrap scaffold

- **What**: feat: M0 bootstrap scaffold
- **Why**: Not explicitly stated in PR/commit body (see source)
- **Source**: commit 95f4a91

## 2026-05-25: Initial commit

- **What**: Initial commit
- **Why**: Not explicitly stated in PR/commit body (see source)
- **Source**: commit 772705b
