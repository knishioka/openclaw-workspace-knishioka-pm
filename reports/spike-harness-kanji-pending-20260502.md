# Spike: kanji-practice PoC 観察 (Phase B - pending)

As of: 2026-05-02
Type: spike (pending — cron 観察待ち)
Related: Issue #21, knishioka/kanji-practice#32

## 状態

Phase B (Issue #21: kanji-practice harness pack PoC) の本体作業は完了:

- knishioka/kanji-practice#32 merged 2026-05-02 05:13 UTC
- 配備内容:
  - `AGENTS.md` (kanji-practice 固有制約: html2canvas oklch / 印刷 A4 安全領域 / src/utils/layout.ts 経由 ルール)
  - `.github/PULL_REQUEST_TEMPLATE.md`
  - `scripts/verify.sh` (Node/Vite/Biome 用、`--json` で構造化出力)
  - `.gitignore` に `.codex-progress.md` 追加
  - 既存 `CLAUDE.md` を Claude 固有のみに整理

ただし Issue #21 の Acceptance Criteria のうち「**次回 focus-task cron で生成 PR の挙動観察**」が残っており、観察結果待ちのため Issue は open のまま (※ GitHub は cross-repo PR の Closes キーワードで auto-close したが、本 workspace の運用上は観察 follow-up があるので reopen を検討)。

## 観察対象

次回 focus-task cron 実行 (Mon 2026-05-04 8:30 KL or Thu 2026-05-07 8:30 KL) で kanji-practice 向け Issue が選定された場合:

- [ ] 生成 PR description が新テンプレ (workspace `docs/codex-playbook.md` "PR Description Standards") に準拠
- [ ] 動作確認テーブルに `verify.sh --json` の出力 (build/lint/format/typecheck/test) が含まれる
- [ ] `monitoring/issue-tracker.jsonl` の新レコードに `playbook_version` フィールドが入る (Issue #19 の効果検証)
- [ ] `monitoring/issue-tracker.jsonl` の `lint_available: true` が記録される (Issue #20 の効果検証、kanji は Biome 完備)
- [ ] Codex が `AGENTS.md` 内の kanji 固有制約 (oklch / 印刷領域 等) を読んで PR 内容に反映している

## 判断 (cron 観察後に追記)

### Phase C (横展開) go/no-go 判断材料

- (TBD) 生成 PR 品質が現状より明確に改善 → Phase C で残り 11 リポへ展開
- (TBD) 改善が薄い / verify.sh が Codex に活用されていない → テンプレを改善して再 PoC
- (TBD) 不具合発見 → 改善 Issue を起票

### 想定タイムライン

- 2026-05-04 (月) または 2026-05-07 (木): 1 回目の観察機会
- 2026-05-08 (金): 観察結果を本ファイルに追記、Phase C の判断
- 2026-05-15 頃: Wave 9 (Codex hooks 評価 spike) の起動条件 (4-6 サイクル運用) 達成

## アクション

- [ ] 次回 focus-task cron 実行後に reports/spike-harness-kanji-{date}.md を新規作成 or 本ファイルを更新
- [ ] 観察結果を踏まえ Issue #21 の最終 close (Phase C 計画 or 本観察自体の終了)
- [ ] 必要なら Phase C (残り 11 リポ harness 配布) の計画を別 plan に切り出す
