<!-- generated: 2026-05-02 -->

# Spike: Clone Duplicates Audit (Phase 0 / Issue #17)

## Summary

`scripts/bootstrap-workspace.sh --json` を `config/repos.yaml` 全 17 リポに対し
て実行。canonical (`~/Developer/private/{name}`) 以外に重複 clone があるかを
網羅的にチェックした。

| 指標           |  件数 |
| -------------- | ----: |
| total          |    17 |
| present        |    11 |
| missing        |     6 |
| **duplicates** | **1** |
| applied        |     0 |
| clone_errors   |     0 |

実行モード: `dry-run` (`--apply` ではない)。`bootstrap-workspace.sh` 自体は
削除を一切行わないので、本レポートは検出結果のみで、Ken の手動レビュー →
削除を待つ状態。

## 重複検出結果 (1 件)

### `cost-management-mcp`

| 項目               | canonical                                                | 重複                                               |
| ------------------ | -------------------------------------------------------- | -------------------------------------------------- |
| path               | `~/Developer/private/cost-management-mcp`                | `~/Developer/cost-management-mcp`                  |
| remote (`origin`)  | `git@github.com:knishioka/cost-management-mcp.git`       | `git@github.com:knishioka/cost-management-mcp.git` |
| branch             | `main` (`...origin/main`)                                | `main` (`...origin/main`)                          |
| working tree       | clean                                                    | clean                                              |
| 未 push commit     | 0 (`git rev-list --count HEAD ^origin/main`)             | 0                                                  |
| 未 push branch     | 0 (`git log --branches --not --remotes`)                 | 0                                                  |
| 最新 commit (HEAD) | `2394b2c 2026-03-28` fix(ci): fix schedule workflows ... | `abeef1e 2025-11-04` Upgrade Zod to v4 ...         |
| 状態               | newer / canonical / cron 経路で参照される                | ~5 ヶ月 stale / cron からは見えない                |

判定: **重複 clone (`~/Developer/cost-management-mcp`) は安全に削除可能**。

- 両 clone とも working tree clean、未 push の branch / commit なし
- canonical 側が origin と最新で fetch 済み
- 重複側は origin と一致しているため、ローカルにしかない変更は存在しない

## 他 16 リポの状況 (重複なし、参考)

`bootstrap-workspace.sh` の dry-run 出力より。詳細は `bash scripts/bootstrap-workspace.sh --json` を再実行すれば再現可能。

| name                        | status    | present | action      |
| --------------------------- | --------- | :-----: | ----------- |
| kanji-practice              | (active)  |   ✅    | skip        |
| math-worksheet              | (active)  |   ✅    | skip        |
| ib-sec-mcp                  | (active)  |   ✅    | skip        |
| freee-mcp                   | (active)  |   ✅    | skip        |
| simple-bookkeeping          | dormant   |   ✅    | skip        |
| english-note-maker          | (active)  |   ✅    | skip        |
| td-mcp-server               | abandoned |   ❌    | would-clone |
| meditation-chrome-extension | abandoned |   ❌    | would-clone |
| remotion-math-education     | abandoned |   ❌    | would-clone |
| market-lens-studio          | (active)  |   ✅    | skip        |
| workflow-engine             | (active)  |   ❌    | would-clone |
| household-finance           | (active)  |   ✅    | skip        |
| ut-gymnastics               | (active)  |   ✅    | skip        |
| jgrants-app                 | (active)  |   ✅    | skip        |
| line-advisor                | on-hold   |   ❌    | would-clone |
| story-bridge                | on-hold   |   ❌    | would-clone |

`would-clone` 行は canonical path に未 clone なだけで重複ではない。`abandoned`
/ `on-hold` は `--apply` でも自動 clone されないため、Issue #17 のスコープ
(重複整理) には影響しない。

## Ken への手動アクション (本 Issue では自動実行しない)

```bash
# 1. 安全確認 (clean / 未 push 0 件であることを再確認)
cd ~/Developer/cost-management-mcp
git status                                # 期待: clean
git log --branches --not --remotes        # 期待: 出力なし

# 2. 削除
rm -rf ~/Developer/cost-management-mcp

# 3. 検証 (重複 0 件)
cd ~/.openclaw/workspace-knishioka-pm
bash scripts/bootstrap-workspace.sh --json | jq '.summary.duplicates'  # 期待: 0
```

## Acceptance Criteria 進捗

- [x] `bootstrap-workspace.sh` を実行し全 17 リポについて重複検出を実施
- [x] 結果を `reports/spike-clone-duplicates-2026-05-02.md` に記録
- [x] `docs/environment.md` に「canonical: `~/Developer/private/{name}`、それ以外は使わない」を明記 (本 PR で更新)
- [ ] (manual) Ken が `~/Developer/cost-management-mcp` を `rm -rf` で削除
- [ ] (manual) 整理後にもう一度 `bootstrap-workspace.sh` で重複 0 件を確認
