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

---

## 2026-05-04 追記: Phase A 配線は **freee-mcp #179 で本番検証済** ✅

kanji-practice ターン到達前に、別リポ (freee-mcp) で Phase A 配信メカ全体の本番動作を確認できた。

### 観察対象

| Repo                | Issue                                                        | PR                                                      | created    |
| ------------------- | ------------------------------------------------------------ | ------------------------------------------------------- | ---------- |
| knishioka/freee-mcp | [#179](https://github.com/knishioka/freee-mcp/issues/179) dx | [#181](https://github.com/knishioka/freee-mcp/pull/181) | 2026-05-04 |

### 検証ゲート結果 (Phase A)

| 観察項目                                                                     | 結果                                                                                                     |
| ---------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------- |
| `monitoring/issue-tracker.jsonl` の新レコードに `playbook_version` 入る      | ✅ `"playbook_version": "2026-05-01"`                                                                    |
| 同 `lint_available` 入る (Issue #20)                                         | ✅ `"lint_available": true`, `"lint_skipped_reason": null`                                               |
| 同 `verification` フィールド (build/lint/typecheck/test/ci) 入る             | ✅ `{"build":"pass","lint":"0 errors / 52 warnings","typecheck":"pass","test":"603 passed","ci":"pass"}` |
| 生成 PR description が "PR Description Standards" 準拠 (日本語 7 セクション) | ✅ 概要 / 変更内容 / 動作確認 / 受け入れ条件 / スコープ外 / 影響範囲 / レビュー観点                      |
| 動作確認テーブルに各検証コマンドの結果と実行ログ要約                         | ✅ Install / Build / Lint / Typecheck / Unit test / Coverage / CI 7 行 + 自己修正経緯記録                |

→ **Phase A 配線 (Issue #18 / #19 / #20 + cron 切替) は本番で完全に機能している**

### Phase B (kanji 固有) 観察は依然 pending

Phase A は他リポでも効くため freee-mcp で検証できたが、Phase B の固有要素 (kanji の AGENTS.md 内の oklch / 印刷領域制約を Codex が反映するか、verify.sh の出力が PR 本文に取り込まれるか) は **kanji-practice ターン待ち**。

直近 4 回の focus-task perspective は PM 3 : Dev 3 で次回はバランス上 PM 寄り (= 教育リポ kanji が選定されやすい) と推測。

### 既知の運用障害 (Phase A 検証中に発覚)

- **2026-05-04 8:30 KL focus-task 起動時に OAuth `refresh_token_reused` 401**: openai-codex/gpt-5.4 認証失敗 → anthropic/claude-sonnet-4-6 に fallback で続行成功 (#179 / #181 はこの fallback 経路で生成)
- 影響: 5/3 weekly-repo-health 経由の `cost-management-mcp #149` も同 auth 問題で `auto_resolve: skipped` だった可能性
- 対応: Ken が `codex login` 再認証実施済 (2026-05-04)、再発時は同手順
- 注: anthropic fallback 経路でも playbook 注入が機能している = wrapper 設計の言語非依存性が確認できた副次効果

### Phase C 判断は引き続き Phase B 観察待ち

Phase A 単独成功は Phase C への部分的 go signal だが、AGENTS.md / verify.sh / PR template の **per-repo 配備が PR 品質に効くかどうか** は kanji 観察で初めて判定できる。Phase C の計画起票は 2026-05-08 以降に保留継続。
