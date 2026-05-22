# market-lens-studio Knowledge Base

## Overview

- Repo: knishioka/market-lens-studio
- Primary language (GitHub): Python
- License: none
- Default branch: main
- Created: 2025-11-14
- Updated: 2026-05-17
- Collected: 2026-05-22

## Tech Stack

- package.json: not found (or not accessible via GitHub contents API)
- pyproject.toml: present
- requirements.txt: present

## Architecture / Patterns

- (No clear patterns inferred from README/dependencies in this snapshot)

## Tech Decisions (from PRs/commits)

- [2026-05-17] chore(hooks): add gh exemption and migrate PreToolUse to hookSpecificOutput envelope -- Two surgical, independent improvements to `.claude/hooks/block-inline-scripts.sh`. Salvaged from closed PR #179 after the rest of that PR became obsolete due to the strategic shift introduced by #177 / #178. (source: PR #181)
- [2026-04-09] fix(ci): show API cost and article URL in Slack notification -- ## Summary - **Cost not displayed**: `extract_cost.sh` failed on pretty-printed JSON from `claude-code-action` — `tail -1` got `}` instead of the full object, and the grep pattern `"total_cost_usd":[0-9.]*` didn't match `"total_cost_usd": 3 (source: PR #160)
- [2026-04-05] fix(note): resize eyecatch to 1280x670 aspect ratio -- - Added `fit_to_note_eyecatch()` to resize/center-crop Gemini-generated 16:9 images (1376x768) to note.com's required 1280x670 aspect ratio - Fixed `upload_eyecatch()` to detect error JSON in HTTP 201 responses (note.com returns 201 with `{ (source: PR #158)
- [2026-04-04] fix(note): widen hook allowlist and harden eyecatch upload -- ## Summary - **Hook allowlist fix**: `block-inline-scripts.sh` only matched `~/.claude/skills/` paths but `/note:write` workflow uses `bash .claude/skills/...` (relative). Widened regex to match both absolute and relative paths, eliminating (source: PR #157)
- [2026-03-23] feat(note): improve article quality across visuals, engagement, and SEO -- 66記事を3ヶ月で投稿してきたが、平均1いいね/記事、コメント0件と低エンゲージメント。データ分析に基づいて**ビジュアル品質**、**コンテンツ戦略**、**エンゲージメント施策**の3領域を全方位改善。 (source: PR #156)
- [2026-03-09] fix(note): replace touch workaround with Read-before-Write for /tmp files -- - Replace `touch` + `Read` + `Write` pattern with simpler `Read` (error OK) + `Write` for new `/tmp/` files in the note:write workflow - Add forbidden→correct pattern substitution table to `file-writing-rules.md` to prevent LLM from generat (source: PR #155)
