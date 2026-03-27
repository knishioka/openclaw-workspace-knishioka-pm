# Knowledge Management Strategy

## Purpose

Accumulate technical knowledge about each monitored repository to:

- Understand tech decisions and design rationale
- Track architecture evolution over time
- Inform future task suggestions with historical context

## File Structure

### repos/{name}-kb.md (Knowledge Base)

Per-repo technical profile:

```markdown
# {repo-name} Knowledge Base

## Overview

- Language: ...
- Key dependencies: ...
- Architecture: ...

## Tech Decisions

- [YYYY-MM-DD] {decision} -- {rationale} (source: commit/PR #N)

## Patterns

- {notable patterns observed in the codebase}
```

### decisions/{name}-decisions.md (Design Decisions)

Focused on "why" not "what":

```markdown
# {repo-name} Design Decisions

## YYYY-MM-DD: {decision title}

- **What**: {what was decided}
- **Why**: {rationale}
- **Source**: PR #N / commit abc1234
```

## Rules

1. **200 line cap** per file. When approaching the limit, summarize older entries.
2. **Deduplicate** before appending. Check existing entries for overlap.
3. **Include source dates** for all entries (commit date or PR merge date).
4. **Focus on**:
   - New dependency additions and why
   - Architecture changes (new patterns, refactors)
   - Design decisions visible in PR descriptions
   - Technology migrations
5. **Skip**:
   - Routine commits (typo fixes, formatting)
   - Dependency version bumps (unless major version)
   - CI configuration tweaks
6. **Attribution**: Reference the source (PR #N, commit SHA, etc.)
