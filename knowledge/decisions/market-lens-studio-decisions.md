# market-lens-studio Design Decisions

## 2026-05-05: unblock jq + tee pipelines for /note:write --auto runs

- **What**: unblock jq + tee pipelines for /note:write --auto runs
- **Why**: /note:suggest --auto → /note:write の自動実行パイプラインが Step 4.1 (Save Preview) で繰り返し止まっていた問題を修正します。
- **Source**: PR #177

## 2026-04-18: wire NOTE_SESSION_COOKIE through scripts and CI

- **What**: wire NOTE_SESSION_COOKIE through scripts and CI
- **Why**: PR #171 のフォローアップ。merge 後に判明した残課題を解消し、CI も同時に動くようにする。
- **Source**: PR #173

## 2026-04-17: add Origin/Referer headers to login & remove redundant mkdir

- **What**: add Origin/Referer headers to login & remove redundant mkdir
- **Why**: /note:write のフロー中で発生していた2つの問題を解消。
- **Source**: PR #171

## 2026-04-17: persist per-article generation metadata

- **What**: persist per-article generation metadata
- **Why**: t for clean integration with /note:write Step 5.3b (non-blocking) 12 fields captured (note_id, published_at, writing_style, article_type, persona, category_tags, claude_cost_usd, input_tokens, output_tokens, quality_gates_fired, eyecatch_status, diagrams_gen...
- **Source**: PR #170

## 2026-04-17: add weekly retrospective GitHub Actions workflow

- **What**: add weekly retrospective GitHub Actions workflow
- **Why**: Closes #168.
- **Source**: PR #169

## 2026-04-17: add weekly article retrospective skill and fact-check archive

- **What**: add weekly article retrospective skill and fact-check archive
- **Why**: Closes #165 (partial: tasks A, C, D) /note:retrospect slash command で過去1週間の公開記事を分析し、改善点を GitHub Issue として起票可能に 記事単位の fact-check 結果をアーカイブ保存し、事後の振り返りデータを蓄積 決定的データ収集スクリプト。Claude API 不要。
- **Source**: PR #166

## 2026-04-16: notify Slack and create Issue on write-article failures

- **What**: notify Slack and create Issue on write-article failures
- **Why**: 記事生成ワークフロー (write-article.yml) の失敗時に **GitHub Issue 起票** + **Slack 通知** を行い、緊急対応できるようにする 従来の step failure に加え、Claude セッションが完了しても ci_publish_output.json が生成されない／note_id が空という **サイレント失敗** も検知 schedule gate / guard による正当スキップ（本日投稿済みなど「記事を作らない仕様」）はそのまま残す 1.
- **Source**: PR #163

## 2026-04-16: harden /note:write workflow after 2026-04-15 GS run

- **What**: harden /note:write workflow after 2026-04-15 GS run
- **Why**: No summary captured.
- **Source**: PR #162

## 2026-04-15: strengthen duplicate detection + fix DAL eyecatch

- **What**: strengthen duplicate detection + fix DAL eyecatch
- **Why**: 直近1か月（3/13〜4/13）の投稿26本を分析し、以下の2件を対処: 1.
- **Source**: PR #161

## 2026-04-09: show API cost and article URL in Slack notification

- **What**: show API cost and article URL in Slack notification
- **Why**: **Cost not displayed**: extract_cost.sh failed on pretty-printed JSON from claude-code-action — tail -1 got } instead of the full object, and the grep pattern "total_cost_usd":[0-9.]* didn't match "total_cost_usd": 3.77 (space after colon).
- **Source**: PR #160
