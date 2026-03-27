# TOOLS.md - knishioka-pm Environment Notes

## GitHub Access

- Uses host `gh` CLI (authenticated as knishioka)
- Personal repos only -- no GitHub App needed
- API: `gh api repos/{owner}/{repo}/...`

## Notion Integration

- NOTION_PROJECTS_DB_ID and NOTION_TASKS_DB_ID from env
- Task creation via Notion MCP tools

## Scripts

- `scripts/repo-health {owner}/{repo}` -- Health check (JSON + Markdown)
- `scripts/task-suggest {owner}/{repo}` -- Suggest next actions
- `scripts/knowledge-collect {owner}/{repo}` -- Extract knowledge from history

## Secrets

- No secrets in this repo (public)
- gh CLI auth from host keychain
- Notion env vars from .openclaw/.env
