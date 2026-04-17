# market-lens-studio Design Decisions

## 2026-04-17: fix(note): add Origin/Referer headers to login & remove redundant mkdir

- **What**: fix(note): add Origin/Referer headers to login & remove redundant mkdir
- **Why**: ## Summary `/note:write` のフロー中で発生していた2つの問題を解消。 ### 1. `mkdir -p data/diagrams` の権限プロンプト撲滅 `generate_custom_chart.py:456` と `generate_mermaid_diagram.py:166` ですでに `output_path.parent.mkdir(parents=True, exist_ok=True)` が実行されているため、ワークフロー側の `mkdir -p data/diagrams` は完全に冗長で、パーミッション確認を出すだけだった。 - `.claude/commands/note/write.md` から呼び出し言及を削除 - `.claude/commands/note/refs/content-generation.md` の Step 3 を削除し、後続ステップを繰り上げ - 「…
- **Source**: PR #171

## 2026-04-17: feat(retrospect): persist per-article generation metadata

- **What**: feat(retrospect): persist per-article generation metadata
- **Why**: Closes #167 ## Summary - Adds `scripts/note/save_generation_metadata.py` to persist per-article generation metadata to `data/generation_metadata/{note_id}.json` at publish time - New skill `note:save-generation-metadata` wraps the script for clean integration with `/note:write` Step 5.3b (non-blocking) - 12 fields captured (note_id, published_at, writing_style, article_type, persona, category_tags, claude_cost_usd, …
- **Source**: PR #170

## 2026-04-17: feat(ci): add weekly retrospective GitHub Actions workflow

- **What**: feat(ci): add weekly retrospective GitHub Actions workflow
- **Why**: ## Summary Closes #168. Adds `.github/workflows/retrospect-weekly.yml` that automates the weekly article-performance retrospective. - **Schedule:** every Monday 09:00 JST (`cron: "0 0 * * 1"` UTC) + `workflow_dispatch` - **Pipeline:** rebuild history from Notion → refresh note.com metrics (graceful degradation with warning on failure) → run `scripts/note/retrospect_week.py` → Claude Code Action opens a GitHub Issue …
- **Source**: PR #169

## 2026-04-17: feat(retrospect): add weekly article retrospective skill and fact-check archive

- **What**: feat(retrospect): add weekly article retrospective skill and fact-check archive
- **Why**: ## Summary Closes #165 (partial: tasks A, C, D) - `/note:retrospect` slash command で過去1週間の公開記事を分析し、改善点を GitHub Issue として起票可能に - 記事単位の fact-check 結果をアーカイブ保存し、事後の振り返りデータを蓄積 ## Changes ### 1. `scripts/analysis/retrospect_week.py` (新規) 決定的データ収集スクリプト。Claude API 不要。 - `note_history.json` から期間内の記事を抽出 - `note_metrics_cache.json` からエンゲージメント指標を JOIN - `data/fact_check_archive/{note_id}.json` から fact-check 結果を JOIN - article_t…
- **Source**: PR #166

## 2026-04-16: feat(ci): notify Slack and create Issue on write-article failures

- **What**: feat(ci): notify Slack and create Issue on write-article failures
- **Why**: ## Summary - 記事生成ワークフロー (`write-article.yml`) の失敗時に **GitHub Issue 起票** + **Slack 通知** を行い、緊急対応できるようにする - 従来の step failure に加え、Claude セッションが完了しても `ci_publish_output.json` が生成されない／`note_id` が空という **サイレント失敗** も検知 - schedule gate / guard による正当スキップ（本日投稿済みなど「記事を作らない仕様」）はそのまま残す ## Changes ### `.github/workflows/write-article.yml` 1. **`permissions` に `issues: write` 追加**: Issue 起票に必要 2. **Verify publish output ステップ追加** (S…
- **Source**: PR #163

## 2026-04-16: refactor(note): harden /note:write workflow after 2026-04-15 GS run

- **What**: refactor(note): harden /note:write workflow after 2026-04-15 GS run
- **Why**: ## Summary Post-mortem refactor after the 2026-04-15 autonomous Goldman Sachs Q1 2026 article run, which shipped with 3 fact-check issues (notably EPS consensus `16.30ドル` vs actual `16.47ドル`) and required manual post-publish corrections. Addresses 5 stability pain points — each change is small and independently revertible. ## Changes ### 1. Demote XSRF warning noise `src/tools/note_publish.py` — note.com stopped ret…
- **Source**: PR #162

## 2026-04-15: feat(note): strengthen duplicate detection + fix DAL eyecatch

- **What**: feat(note): strengthen duplicate detection + fix DAL eyecatch
- **Why**: ## Summary 直近1か月（3/13〜4/13）の投稿26本を分析し、以下の2件を対処: 1. **DAL記事 (`nf36d69d976d5`) のアイキャッチ欠損を修復** — 4/10公開の「DAL Q1決算」のみeyecatchがnullだったため再生成・アップロード済み (コード変更なし) 2. **重複検出ロジックの強化** — 同一イベントの再掲が `ok` 判定で通ってしまっていた問題を修正 ## 発見した重複事例（過去1か月） | 日付 | 記事 | 旧判定 | 新判定 | |------|------|--------|--------| | 4/11 → 4/13 | SCHD リコンスティテューション / リバランス | ok | **error** | | 3/23 → 3/24 | VIX26 / VIX26.78 | ok | warning | | 3/21 → 3/27 → 3/29 |…
- **Source**: PR #161

## 2026-04-09: fix(ci): show API cost and article URL in Slack notification

- **What**: fix(ci): show API cost and article URL in Slack notification
- **Why**: ## Summary - **Cost not displayed**: `extract_cost.sh` failed on pretty-printed JSON from `claude-code-action` — `tail -1` got `}` instead of the full object, and the grep pattern `"total_cost_usd":[0-9.]*` didn't match `"total_cost_usd": 3.77` (space after colon). Fixed by using `jq` on the whole file and portable whitespace-tolerant grep+sed. - **Wrong fallback message**: When `public_url` was empty in `ci_publish…
- **Source**: PR #160
