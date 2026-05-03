# Weekly Repo Health Report — 2026-05-03

**Generated:** 2026-05-03 20:00 KL / 2026-05-03T12:00Z  
**Previous check:** 2026-04-26

---

## Summary

| Status | Count | Change vs last week |
|--------|-------|---------------------|
| 🟢 GREEN | 5 | -1 |
| 🟡 YELLOW | 0 | — |
| 🔴 RED | 5 | +1 |

**⚠️ Status change detected:** `cost-management-mcp` GREEN → RED (CI failure)

---

## Active Repos

| Repo | Status | CI | Inactive | Issues | PRs | Change |
|------|--------|----|----------|--------|-----|--------|
| kanji-practice | 🟢 GREEN | ✅ | 1d | 1 | 0 | — |
| math-worksheet | 🟢 GREEN | ✅ | 8d | 1 | 1 | — |
| ib-sec-mcp | 🟢 GREEN | ✅ | 2d | 0 | 5 | — |
| freee-mcp | 🟢 GREEN | ✅ | 4d | 1 | 15 | — |
| cost-management-mcp | 🔴 RED | ❌ | 1d | 3 | 3 | 🔺 GREEN→RED |
| simple-bookkeeping | 🔴 RED | ✅ | 113d | 37 | 8 | — (dormant) |
| english-note-maker | 🟢 GREEN | ✅ | 1d | 0 | 0 | — |

### Abandoned (skipped for issues)

| Repo | Status | Inactive |
|------|--------|----------|
| td-mcp-server | 🔴 RED | 273d |
| meditation-chrome-extension | 🔴 RED | 307d |
| remotion-math-education | 🔴 RED | 320d |

---

## 🔴 Risks / Blockers

### cost-management-mcp — CI failure (GREEN→RED)
- **CI:** Both `CI` and `Security Scan` workflows failing on `main` since 2026-05-02
- **Root cause (Security Scan):** `fast-xml-parser` DoS vulnerability (GHSA-37qj-frw5-hhjh) — `npm audit --production` exits 1; fix: `npm audit fix`
- **TruffleHog false positive:** BASE==HEAD error on push-to-main (non-blocking, workflow config issue)
- **Action taken:** Created Issue #149 (fix: resolve fast-xml-parser vulnerability)
- **Note:** Dependabot PR #145 (deps bump ×11) may resolve this — check and merge first
- **Open PRs:** 3 ready PRs including deps bumps waiting for review

### freee-mcp — 15 open PRs
- 15 open PRs is a persistent backlog. Oldest issue open 321 days.

### math-worksheet — stale issue
- Issue #57 (分数↔小数変換プリント追加) open since 2026-04-13; PR #14 also open

### simple-bookkeeping (dormant)
- 37 open issues, 8 open PRs, 113 days inactive. No action per dormant policy.

---

## Part 2: Demo Site QA

**Environment note:** Playwright not installed in workspace; browser SSRF policy blocked. Sites verified via HTTP availability only.

| Site | HTTP | Last Deploy | Notes |
|------|------|-------------|-------|
| kanji-practice | ✅ 200 | 2026-05-02 | Active development (Phase B PoC merged) |
| math-worksheet | ✅ 200 | 2026-04-25 | tracing 2-row practice added |
| english-note-maker | ✅ 200 | 2026-05-02 | alphabet tracing (beginner-friendly) |

**Full browser QA skipped** — Playwright not available in this cron environment. No regression issues flagged from code review.

---

## Part 3: Issue Retrospective

### Resolved This Week

| Repo | Issue | Type | PR | Days | Score | Notes |
|------|-------|------|----|------|-------|-------|
| freee-mcp | #177 | tech-adoption | #178 | 0 | A | merged 2026-04-29 |
| ib-sec-mcp | #114 | feature | #115 | 0 | A | merged 2026-05-01 |

### Still Open

| Repo | Issue | Type | Created | Age | Auto-resolve |
|------|-------|------|---------|-----|--------------|
| kanji-practice | #31 | bugfix | 2026-04-26 | 7d | skipped |
| freee-mcp | #177 | tech-adoption | 2026-04-27 | — | *(now resolved above)* |
| ib-sec-mcp | #114 | feature | 2026-04-30 | — | *(now resolved above)* |

### Newly Created This Run

| Repo | Issue | Type | Title |
|------|-------|------|-------|
| cost-management-mcp | #149 | bugfix | fix(security): resolve fast-xml-parser DoS vulnerability |

### Quality Score Summary (all-time)
- **A:** 11 (merged, no edits)
- **B:** 0
- **C:** 0
- **Open:** 2 (kanji-practice #31, cost-management-mcp #149)

---

## Next Actions

1. **cost-management-mcp:** Review and merge PR #145 → check if it resolves fast-xml-parser; then verify CI passes
2. **cost-management-mcp:** TruffleHog BASE==HEAD false positive — may need workflow config fix for push-to-main
3. **kanji-practice #31:** Debug overlay in production build (open 7d, auto-resolve skipped)
4. **freee-mcp:** 15 open PRs backlog — batch review
5. **math-worksheet:** PR #14 (multi-page printing) + Issue #57 (fractions worksheet)
