# Spike: worktree skill `status.sh` cross-repo PR の jq parse 失敗

As of: 2026-05-02
Type: spike (known issue, upstream bug)

## 事象

Wave 8 (Issue #21: kanji-practice PoC) の進行中、`/worktree` で `status.sh` が以下のエラーを返した:

```
jq: invalid JSON text passed to --argjson
```

`complete-wave.sh --wave 8` も同じ経路で失敗し、`unmerged: ["21 (null", "null)"]` のような壊れた表示になった。

## 根本原因

worktree skill (`~/.claude/skills/worktree/scripts/_gh_helpers.sh`) の `get_pr_data_for_issue` 関数:

```bash
pr_data=$(gh pr view "$closed_by" --json "$fields" 2>/dev/null | jq -s '.' || echo "[]")
```

の挙動:

1. Issue #21 は **kanji-practice/32 (cross-repo)** で auto-close されている
2. `gh issue view 21 --json closedByPullRequestsReferences` は `kanji-practice/32` を返す
3. 関数内で `gh pr view 32` を **`--repo` 指定なし** で呼ぶ → workspace に PR #32 が無いので `GraphQL: Could not resolve to a PullRequest` エラー
4. `set -o pipefail` (status.sh 冒頭で `set -euo pipefail`) のため、pipe の中間 fail が伝播
5. `gh pr view ... | jq -s '.'` で gh が exit 1 → pipefail で全体 exit 1 → `|| echo "[]"` が走る
6. しかし `jq -s '.'` は空入力を `[]` として既に出力済 → stdout に `[]\n[]` の二重連結
7. 呼び出し元で `jq '.[0]'` がこれを受けて parse error

## 影響範囲

- workspace 内の Issue が cross-repo PR で close されているとき (Wave 8 のような外部リポ作業 PoC)
- complete-wave.sh が PR を見つけられず unmerged 扱いで失敗
- 結果として **wave-plan.json を手動編集して completed マーク**せざるを得ない (Wave 8 で実施)

## 回避策 (現状)

cross-repo Issue を含む Wave は:

1. wave-plan.json を直接編集して `status: "completed"` + `external_pr: "owner/repo#N"` を追加
2. tmux pane / worktree を手動で `tmux kill-pane` + `git worktree remove --force`
3. complete-wave.sh は呼ばない

## 推奨修正 (upstream)

`_gh_helpers.sh` の `get_pr_data_for_issue` を以下のいずれかに修正:

**案 A**: cross-repo PR を検出してスキップ (workspace と PR の repo が異なるなら null を返す)

```bash
local pr_repo
pr_repo=$(gh issue view "$issue_num" --json closedByPullRequestsReferences \
  --jq '.closedByPullRequestsReferences[0].repository.nameWithOwner // empty' 2>/dev/null)
local current_repo
current_repo=$(gh repo view --json nameWithOwner --jq '.nameWithOwner' 2>/dev/null)
if [[ -n "$pr_repo" && "$pr_repo" != "$current_repo" ]]; then
  echo "[]"
  return
fi
```

**案 B**: pipefail 影響を受けないように pipe を分解

```bash
local raw
raw=$(gh pr view "$closed_by" --json "$fields" 2>/dev/null) || raw=""
if [[ -n "$raw" ]]; then
  pr_data=$(echo "$raw" | jq -s '.' 2>/dev/null || echo "[]")
else
  pr_data="[]"
fi
```

両方併用が安全。

## 関連 Issue / PR

- 本 workspace Issue #21 (Wave 8 - kanji-practice PoC) — 本事象の発生 trigger
- workspace Wave 8 の手動 complete マーク経緯: `.git/wave-plan.json.bak.pre-wave8-manual-20260502`
- 関連スクリプト: `~/.claude/skills/worktree/scripts/_gh_helpers.sh`, `status.sh`, `complete-wave.sh`

## アクション

- [x] 事象記録 (本ファイル)
- [ ] worktree skill 本体への upstream PR / Issue (本 workspace のスコープ外、Ken が別途判断)
- [ ] 同種事象が再発したら同じ手動回避策を docs/environment.md に追記
