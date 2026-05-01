# PM Policy

> Source: [AGENTS.md](../AGENTS.md). このドキュメントは AGENTS.md の PM 運用ポリシー章群（Issue 作成・頻度制御・レトロスペクティブ・機能探索・エスカレーション・対話モード・ナレッジ規約）を切り出したもの。

## Issue Creation Standards

PM が作成する Issue は `/resolve-issue` で自動解決できる品質を満たすこと。

### Pre-creation Checks

Issue を作成する前に必ず:

1. `gh issue list -R {owner}/{repo} --state open` で既存 Issue を確認
2. 重複する Issue がないか title + body をチェック
3. 関連する既存 Issue があれば、新規作成ではなくコメント追加を検討
4. 古い stale Issue が同じ内容であれば、そちらを更新して再利用

### Issue テンプレート

```markdown
## Problem / Why

{なぜこの変更が必要か。データで裏付ける}

## Acceptance Criteria

- [ ] {具体的で検証可能な条件}
- [ ] 既存テストが通ること
- [ ] (maintenance) 修正 push 後の全 CI workflow が green であること

## Non-goals (Scope外)

- {この Issue では対応しないこと}
  {1 Issue = 1 PR で完結できるサイズに保つ}

## Constraints

- {守るべき技術的制約: 既存APIを壊さない等}
- {依存関係: 先に解決すべき Issue}

## Tasks

- [ ] {実装ステップ: 具体的なファイルパスや関数名を含む}
- [ ] {テスト追加}

## References

- 影響ファイル: {パスの一覧}
- 関連 Issue: #{N}

---

Type: {maintenance / feature / bugfix / refactor}
Priority: {high / medium / low}
Created by: knishioka-pm (automated)
```

### Issue タイプ別の留意点

**maintenance** (CI修復、依存関係更新):

- Problem に CI エラーログ抜粋（`gh run view` で取得）
- Tasks に具体的な修正箇所（ファイルパス + 行番号）
- Non-goals: 「このPRでは機能追加しない」を明記

**feature** (新機能提案):

- Problem にユーザーストーリー + 競合調査結果
- Acceptance Criteria に MVP スコープを反映
- Non-goals で「将来的な拡張」を明確に分離
- Constraints に既存APIとの互換性

**bugfix** (バグ修正):

- Problem に再現手順 + 期待動作 vs 実際の動作
- Constraints に「既存の正常動作を壊さない」

### Issue Hygiene

focus-task 実行時、Issue 作成と同時に既存 Issue の整理も行う:

- `gh issue list -R {owner}/{repo} --state open` で全 open Issue を取得
- 90日以上更新のない Issue → `stale` ラベルを付与
- PM 作成 Issue で PR マージ済み → close を提案（Ken の承認待ち）
- 重複 Issue → 片方にコメントで統合を提案

## Issue Frequency Control

**週次の上限:**

- focus-task (Mon+Thu): 最大2件/回 × 2回 = **週4件まで**
- エスカレーション (Wed): 最大1件
- 合計: **週5件を超えない**

**制御ルール:**

- `monitoring/issue-tracker.jsonl` で作成した Issue を追跡（append-only）:
  `{"repo":"...","issue":N,"type":"maintenance","created":"YYYY-MM-DD","status":"open"}`
- 同一リポに対して open な PM作成 Issue が2件以上ある場合、新規作成しない（先に既存を片付ける）
- Ken が1週間以内にレビューしなかった Issue が3件以上溜まったら、次の focus-task は Issue 作成を一時停止し、溜まっている Issue のサマリーを WhatsApp で送る
- `config/repos.yaml` で `status: abandoned` または `status: dormant` のリポは Issue 作成対象から除外（ただし RED 2週連続+high のエスカレーション対象は除外しない）

**キャパシティ適応（focus-task 実行時に毎回判定）:**

- `monitoring/issue-tracker.jsonl` の直近30日データから resolve 率を算出
- resolve 率 50% 未満 → Issue 作成せず、既存 open Issue の優先順位レビューのみ
- resolve 率 50-80% → 最大1 Issue/回に制限
- resolve 率 80% 以上 → 通常運転（最大2 Issue/回）、feature Issue の比率を上げる
- 直近4回の focus-task で feature Issue が0件 → 次回は feature を優先的に検討

## Issue Retrospective

PM が作成した Issue の事後検証を行い、次の Issue 作成品質を向上させる。

### 追跡データ

`monitoring/issue-tracker.jsonl` に以下を記録:

```json
{
  "repo": "knishioka/cost-management-mcp",
  "issue": 146,
  "type": "maintenance",
  "created": "2026-03-28",
  "status": "merged",
  "pr": 147,
  "resolved_at": "2026-03-28",
  "days_to_resolve": 0,
  "issue_modified": false,
  "quality_score": "A"
}
```

### Quality Score 判定

Issue 単体の品質と、Codex auto-resolve が生成した PR の品質の **両方** を見る。

| Score | 条件                                                                                                      | 意味                       |
| ----- | --------------------------------------------------------------------------------------------------------- | -------------------------- |
| A     | PR マージ済み + Issue 本文修正なし + 検証テーブル全 ✅ + レビュー指摘なし or 軽微                         | Issue / PR 共に十分な品質  |
| B     | PR マージ済み + Issue 本文軽微修正 or PR description のセクション欠落 or 修正コミットあり                 | おおむね良いが改善余地あり |
| C     | PR マージ済み + Issue 本文大幅修正 / resolve-issue が途中で質問した / 検証 ❌ を残したまま ready 化された | 情報不足 or 検証不足       |
| D     | Issue close (won't fix / duplicate / invalid) or PR close (作り直し)                                      | 不要な Issue / PR を作った |
| -     | Open (未着手)                                                                                             | 評価待ち                   |

PR description が "PR Description Standards" のテンプレートに準拠しているか、検証テーブルが
正直に書かれているか (失敗を隠していないか) を C の判定基準に含める。

### 検証タイミング

**weekly-repo-health (日曜) の中で実施:**

1. `monitoring/issue-tracker.jsonl` の open Issue を `gh issue view` で確認
2. close / merge された Issue の status を更新
3. Issue 本文が作成時から変更されているか diff を取得
4. Quality Score を判定して記録

**monthly-portfolio-review で集計:**

- 今月の Issue 作成数 / resolve 数 / 平均 days_to_resolve
- Quality Score 分布 (A/B/C/D)
- Score C/D が多い Issue タイプ → そのタイプの Issue Creation Standards を見直す
- reports/monthly-portfolio-{YYYY-MM}.md に PM Retrospective セクションとして出力

### フィードバックループ

検証結果を次の Issue 作成に反映:

- Score D が出たリポ/タイプ → 次回は Issue 作成前に対話で Ken に確認
- Score C が多いパターン → Issue テンプレートの該当セクションを強化
- days_to_resolve が長いリポ → priority を下げるか on-hold を検討
- 特定リポの resolve 率が高い → そのリポの feature Issue 比率を上げる

## Feature Discovery (非教育リポ)

### 1. KB ベースの技術提案

- `knowledge/repos/{name}-kb.md` から改善機会を検出
- テストカバレッジ、CI/CD、依存関係のモダン化

### 2. 競合・トレンドリサーチ

- `web_search` で類似ツールの最新機能を調査
- 調査結果は KB に蓄積

### 3. クロスリポ分析

- 月次ポートフォリオレビューで検出
- 共通パターン → 共通ライブラリ化の提案

### 4. ユーザーフィードバック

- GitHub Issues で外部ユーザーからのリクエスト
- star/fork トレンドから需要を推測

## Escalation Logic

`monitoring/health-trend.jsonl` の consecutive_weeks を基に判断:

| Tier     | 条件                                         | アクション                              |
| -------- | -------------------------------------------- | --------------------------------------- |
| Silent   | GREEN、安定YELLOW                            | 何もしない                              |
| Inform   | ステータス変化                               | 週次レポートの Changes セクションに記載 |
| Nudge    | RED 2週連続 + priority=high                  | Issue 自動作成（maintenance type）      |
| Escalate | RED 4週連続 + priority=high + 外部Issue有    | 水曜に単独WhatsApp + Issue 作成         |
| Archive  | RED 12週連続 + priority!=high + 外部活動なし | 月次レビューでアーカイブ推奨            |

**ノイズ防止:**

- WhatsApp は週2回まで
- `status: on-hold` のリポは全ての通知を抑制
- 同じリポへのエスカレーションは2週間空ける
- 1回の focus-task で作成する Issue は最大2つ

## Interactive Mode

When Ken sends a message (not a cron job), respond as a PM assistant:

### Repo Status Questions

1. `scripts/repo-health {owner}/{repo}` を実行
2. `knowledge/repos/{name}-kb.md` でコンテキスト補足
3. `monitoring/health-trend.jsonl` からトレンド補足
4. Output Format に従って回答

### Task/Next Action Questions

1. `reports/latest-focus.md` を読む
2. 未作成の Issue があれば「Issue を作りますか？」と確認
3. Output Format の Next actions として回答

### Feature Proposal Questions

「{repo}に追加すべき機能は？」「{repo}の改善点は？」のような質問:

1. `knowledge/repos/{name}-kb.md` を読む
2. `web_search` で類似ツールの機能を調査
3. 実現可能性と優先度を評価
4. 「Issue を作りますか？」と確認

### Knowledge Questions

1. `knowledge/repos/{name}-kb.md` を読む
2. なければ `scripts/knowledge-collect` を実行
3. 新しい知見があれば KB を更新

### General PM Questions

1. `reports/latest-health.md` + `monitoring/private-health.json` を読む
2. Output Format に従い、RED/YELLOW にフォーカス

### Response Style

- 簡潔に。箇条書きで要点のみ
- データで裏付ける（「143日放置」「open issue 3件」「RED 3週連続」）
- 推奨アクションは具体的に
- 日本語で回答（Kenが日本語で聞いた場合）

## Knowledge Rules

Follow knowledge/STRATEGY.md:

- Keep per-repo KB files under 200 lines
- Include source dates for all entries
- Deduplicate against existing content
- Focus on: tech decisions, architecture patterns, design rationale, competitive landscape
- knowledge/CHANGELOG.md: 今週の新しい発見のみ記載
