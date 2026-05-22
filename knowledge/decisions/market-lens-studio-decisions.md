# market-lens-studio Design Decisions

## 2026-05-17: chore(hooks): add gh exemption and migrate PreToolUse to hookSpecificOutput envelope

- **What**: chore(hooks): add gh exemption and migrate PreToolUse to hookSpecificOutput envelope
- **Why**: Two surgical, independent improvements to `.claude/hooks/block-inline-scripts.sh`. Salvaged from closed PR #179 after the rest of that PR became obsolete due to the strategic shift introduced by #177 / #178.
- **Source**: PR #181

## 2026-04-09: fix(ci): show API cost and article URL in Slack notification

- **What**: fix(ci): show API cost and article URL in Slack notification
- **Why**: ## Summary - **Cost not displayed**: `extract_cost.sh` failed on pretty-printed JSON from `claude-code-action` — `tail -1` got `}` instead of the full object, and the grep pattern `"total_cost_usd":[0-9.]*` didn't match `"total_cost_usd": 3
- **Source**: PR #160

## 2026-04-05: fix(note): resize eyecatch to 1280x670 aspect ratio

- **What**: fix(note): resize eyecatch to 1280x670 aspect ratio
- **Why**: - Added `fit_to_note_eyecatch()` to resize/center-crop Gemini-generated 16:9 images (1376x768) to note.com's required 1280x670 aspect ratio - Fixed `upload_eyecatch()` to detect error JSON in HTTP 201 responses (note.com returns 201 with `{
- **Source**: PR #158

## 2026-04-04: fix(note): widen hook allowlist and harden eyecatch upload

- **What**: fix(note): widen hook allowlist and harden eyecatch upload
- **Why**: ## Summary - **Hook allowlist fix**: `block-inline-scripts.sh` only matched `~/.claude/skills/` paths but `/note:write` workflow uses `bash .claude/skills/...` (relative). Widened regex to match both absolute and relative paths, eliminating
- **Source**: PR #157

## 2026-03-23: feat(note): improve article quality across visuals, engagement, and SEO

- **What**: feat(note): improve article quality across visuals, engagement, and SEO
- **Why**: 66記事を3ヶ月で投稿してきたが、平均1いいね/記事、コメント0件と低エンゲージメント。データ分析に基づいて**ビジュアル品質**、**コンテンツ戦略**、**エンゲージメント施策**の3領域を全方位改善。
- **Source**: PR #156

## 2026-03-09: fix(note): replace touch workaround with Read-before-Write for /tmp files

- **What**: fix(note): replace touch workaround with Read-before-Write for /tmp files
- **Why**: - Replace `touch` + `Read` + `Write` pattern with simpler `Read` (error OK) + `Write` for new `/tmp/` files in the note:write workflow - Add forbidden→correct pattern substitution table to `file-writing-rules.md` to prevent LLM from generat
- **Source**: PR #155
