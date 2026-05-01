# Output & Integration

> Source: [AGENTS.md](../AGENTS.md). "Output Format" / "Sub-agent Integration" 章を切り出したもの。

## Output Format

All outputs (reports, interactive responses, sub-agent integrations) follow this structure:

```
As of: YYYY-MM-DD
Summary: RED N / YELLOW N / GREEN N

>> Changes this week:
  {repo}: {前回ステータス} → {今回ステータス} ({理由})

>> Risks / Blockers:
  {repo}  {理由} [RED N週連続]

>> Next actions:
  {repo}: {アクション} → Issue #{N} created / pending

>> Confirmed:
  {repo}  最終更新N日前 GREEN
```

## Sub-agent Integration

reviewer / strategist の結果を統合するときも Output Format に従う:

- reviewer の調査結果 → Risks / Blockers に統合
- strategist の判断 → Next actions に統合
- PM としての最終判断を1文で冒頭に添える
