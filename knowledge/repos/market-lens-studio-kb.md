# market-lens-studio Knowledge Base

## Overview

- Repo: knishioka/market-lens-studio
- Description: Market analysis studio
- Primary language (GitHub): Python
- Category / Priority: tool / high
- Status: active
- License: none
- Default branch: main
- Created: 2025-11-14
- Updated: 2026-04-18
- Collected: 2026-04-24

## Tech Stack

- package.json: not found (or not accessible via GitHub contents API)
- Dependencies (sample): not found
- Dev dependencies (sample): not found
- npm scripts (keys): not found
- pyproject.toml: present
- requirements.txt: present
- README signal: Market Lens Studio マーケットデータ・ニュースを元に、note記事、Xポスト用テキスト、画像を自動生成・投稿するシステム。 Features - **市場データ取得**: 日本株（東証）、米国株（NYSE/NASDAQ）の指数・銘柄データ - **自動分析**: センチメント推定、シナリオ生成 - **コンテンツ生成**: note記事、Xポスト、画像の自動生成 - **自動投稿**: note.com、X（Twitter）への投稿 Quick Start Prerequisites - Python 3.10+ - uv (推奨) または pip Installation Usage Documentati

## Architecture / Patterns

- Python application with repo-specific automation around its core domain
- Pipeline combines market data collection, analysis, content generation, and publishing/notification automation

## Competitive Landscape (notes)

[2026-04-17] TradingView's feature surface keeps raising the baseline for market workspaces with many chart modalities (candles, range, Heikin Ashi, Renko, volume profile variants) aimed at fast noise reduction and intraday context switching. That suggests users increasingly expect analysis systems to preserve context, not just output one-off reports. (ref: https://www.tradingview.com/features/)
[2026-04-17] Koyfin positions around **global coverage**, fast multi-asset overview, and comprehensive analysis in a single daily workspace. For this repo, the differentiator is automated insight-to-publication flow, but the competitive gap is a reusable analyst workspace layer that feeds the article generator. (ref: https://www.koyfin.com/features/)

Potential feature candidates for this repo:
- Add **engagement-driven topic selection**: retrospect_week.pyのエンゲージメント指標をsuggest_topics.pyのスコアリングにフィードバックし、高エンゲージメントなカテゴリの記事を優先するループを作る。
- Add **saved market-workspace snapshots** (watchlists, key charts, macro checklist, thesis notes) as first-class inputs to article generation and retrospectives.
- Add **alert-to-briefing workflows** that turn market events or screening hits into a draft article / X thread package with preserved cross-asset context.

## Tech Decisions (from PRs/commits)

- [2026-04-17] feat(ci): weekly retrospective workflow -- Every Monday 09:00 JST: Notion rebuild → note.com metrics refresh → retrospect_week.py → Claude Code ActionがGitHub Issueを起票。fact-check archive (`data/fact_check_archive/{note_id}.json`) で事後検証データを蓄積。 (source: PR #169, #166)
- [2026-04-18] fix(note): wire NOTE_SESSION_COOKIE through scripts and CI -- PR #171 のフォローアップ。merge 後に判明した残課題を解消し、CI も同時に動くようにする。 1. `NotePublishTool` を構築している全スクリプトで `session_cookie` を渡す **根本原因**: `pydantic_settings` は `.env` を Settings オブジェクトに読みますが `os.environ` には書きません。一方 `_try_cached_session()` は `os.environ.get("NOTE_SESSION_COOKIE")` を直接見ているので、`.env` に正しい値を入れていても **scripts 経由ではクッキーが見えない**まま… (source: PR #173)
- [2026-04-17] fix(note): add Origin/Referer headers to login & remove redundant mkdir -- `/note:write` のフロー中で発生していた2つの問題を解消。 1. `mkdir -p data/diagrams` の権限プロンプト撲滅 `generate_custom_chart.py:456` と `generate_mermaid_diagram.py:166` ですでに `output_path.parent.mkdir(parents=True, exist_ok=True)` が実行されているため、ワークフロー側の `mkdir -p data/diagrams` は完全に冗長で、パーミッション確認を出すだけだった。 - `.claude/commands/note/write.md` から呼び出し言及を削… (source: PR #171)
- [2026-04-17] feat(retrospect): persist per-article generation metadata -- Closes #167 Summary - Adds `scripts/note/save_generation_metadata.py` to persist per-article generation metadata to `data/generation_metadata/{note_id}.json` at publish time - New skill `note:save-generation-metadata` wraps the script for clean integration with `/note:write` Step 5.3b (non-blocking) - 12 fields capture… (source: PR #170)
- [2026-04-17] feat(ci): add weekly retrospective GitHub Actions workflow -- Closes #168. Adds `.github/workflows/retrospect-weekly.yml` that automates the weekly article-performance retrospective. - **Schedule:** every Monday 09:00 JST (`cron: "0 0 * * 1"` UTC) + `workflow_dispatch` - **Pipeline:** rebuild history from Notion → refresh note.com metrics (graceful degradation with warning on fai… (source: PR #169)
- [2026-04-17] feat(retrospect): add weekly article retrospective skill and fact-check archive -- Closes #165 (partial: tasks A, C, D) - `/note:retrospect` slash command で過去1週間の公開記事を分析し、改善点を GitHub Issue として起票可能に - 記事単位の fact-check 結果をアーカイブ保存し、事後の振り返りデータを蓄積 Changes 1. `scripts/analysis/retrospect_week.py` (新規) 決定的データ収集スクリプト。Claude API 不要。 - `note_history.json` から期間内の記事を抽出 - `note_metrics_cache.json` からエンゲージメント指標を J… (source: PR #166)
- [2026-04-16] feat(ci): notify Slack and create Issue on write-article failures -- - 記事生成ワークフロー (`write-article.yml`) の失敗時に **GitHub Issue 起票** + **Slack 通知** を行い、緊急対応できるようにする - 従来の step failure に加え、Claude セッションが完了しても `ci_publish_output.json` が生成されない／`note_id` が空という **サイレント失敗** も検知 - schedule gate / guard による正当スキップ（本日投稿済みなど「記事を作らない仕様」）はそのまま残す Changes `.github/workflows/write-article.yml` 1. **`permis… (source: PR #163)
- [2026-04-16] refactor(note): harden /note:write workflow after 2026-04-15 GS run -- Post-mortem refactor after the 2026-04-15 autonomous Goldman Sachs Q1 2026 article run, which shipped with 3 fact-check issues (notably EPS consensus `16.30ドル` vs actual `16.47ドル`) and required manual post-publish corrections. Addresses 5 stability pain points — each change is small and independently revertible. Change… (source: PR #162)
- [2026-04-15] feat(note): strengthen duplicate detection + fix DAL eyecatch -- 直近1か月（3/13〜4/13）の投稿26本を分析し、以下の2件を対処: 1. **DAL記事 (`nf36d69d976d5`) のアイキャッチ欠損を修復** — 4/10公開の「DAL Q1決算」のみeyecatchがnullだったため再生成・アップロード済み (コード変更なし) 2. **重複検出ロジックの強化** — 同一イベントの再掲が `ok` 判定で通ってしまっていた問題を修正 発見した重複事例（過去1か月） 日付 記事 旧判定 新判定 ------ ------ -------- -------- 4/11 → 4/13 SCHD リコンスティテューション / リバランス ok **error** 3/23 → 3/… (source: PR #161)
