# Education QA

> Source: [AGENTS.md](../AGENTS.md). このドキュメントは AGENTS.md の教育サイト関連 QA 章群（教育軸チェック / UX軸チェック / Demo Site QA）を切り出したもの。

## Education Site: 教育軸チェック

`config/learner-context.yaml` の学習状況を参照し、問題が成長に効くかを判断する。

### チェック項目

- 難易度は今の学習段階に合っているか（簡単すぎ / 難しすぎ）
- 問題のバリエーションは十分か（同じパターンの繰り返しになっていないか）
- 学習目標（漢検9級、writing力向上等）に対して効果的な練習か
- 問題の順序や構成がスキル定着に適しているか

### 判断フロー

```
問題を生成して内容を確認
    ↓
├─ OK → reports/learning-recommendations.md に推奨設定を記録
│
├─ 既存の問題タイプ + 設定変更で改善可能
│   → reports/learning-recommendations.md に推奨設定を記載
│
├─ 既存の問題タイプの改善が必要
│   → improvement Issue（難易度調整、バリエーション追加等）
│
└─ 既存では対応不可能
    → feature Issue（教育的根拠 + 技術的実装案）
```

Issue は必要な場合のみ。推奨設定の更新が日常的なアウトプット。

### reports/learning-recommendations.md

```
# Learning Recommendations (YYYY-MM-DD)

## 現在の推奨設定
### kanji-practice
- 学年: 2年生 (9級対策), 問題タイプ: 読み練習, ページ数: 5, ランダム: ON

### math-worksheet
- 学年: 3年生, 問題タイプ: 3桁×1桁, 列: 2列, 20問

### english-note-maker
- モード: フレーズ練習 (あいさつ), 罫線: 10mm, ページ数: 2

## 次のステップ
- kanji: 9級の読みが8割定着したら書き練習の比率を上げる
- math: 3桁×1桁が安定したら割り算の筆算に移行
- english: 写経が安定したら穴埋めモードへ
```

### Issue の教育的根拠

Issue を作る場合、Problem / Why に必ず含める:

- なぜこの変更が学習に効くか（学習指導要領、教育研究、`web_search` 調査）
- 具体的にどんなスキルが伸びるか
- 類似教材での事例

### 実行タイミング

- monthly-portfolio-review (月次) で learner-context.yaml を参照してチェック
- learner-context.yaml が更新された時にも実行
- Issue 乱造を避ける: 推奨設定の更新が中心、Issue は本当に必要な場合のみ

## Education Site: UX軸チェック

エンドユーザーが子供であることを前提に、使いやすさを判断する。

### チェック項目

**操作性:**

- 子供（または親）が迷わず操作できるか
- 設定変更 → 生成 → 印刷 の導線が明確か
- ボタンやラベルがわかりやすいか（専門用語が多すぎないか）
- エラー時のフィードバックがあるか（何も起きない、は最悪のUX）

**パフォーマンス:**

- ページの読み込みは速いか（マレーシアからのアクセスを想定）
- 問題生成に時間がかかりすぎないか
- 大量ページ生成（10ページ等）でブラウザが固まらないか

**レスポンシブ:**

- モバイル / タブレットで操作できるか
- 印刷プレビューがモバイルでも確認できるか

**アクセシビリティ:**

- 色のコントラストは十分か（罫線が薄すぎないか）
- フォントサイズは読みやすいか

### チェック方法

browser ツールで:

1. `browser(open)` でサイトを開く
2. 初見のユーザーとして操作フローを辿る（設定 → 生成 → 印刷）
3. 迷うポイント、わかりにくいラベル、反応がない操作を検出
4. `browser(act evaluate)` でページ読み込み時間を計測
5. viewport をモバイルサイズに変更してレスポンシブを確認

### 判断フロー

```
├─ 問題なし → OK
├─ 軽微（ラベル改善、配色調整等）→ improvement Issue
└─ 重大（操作不能、モバイル非対応等）→ bugfix Issue
```

### 実行タイミング

- monthly-portfolio-review (月次) で実行
- サイトに新機能が追加された時（knowledge-extract で検出）
- QA軸・教育軸より低頻度でよい

## Demo Site QA (Education Sites)

`demo_url` を持つリポは、コード健康診断に加えてサイトの動作検証も行う。
チェック観点は `config/site-checks.yaml` を参照。

### アプローチ: 理解→判断（決め打ちではない）

チェックロジックをハードコードするのではなく、生成された内容を理解してから判断する:

1. サイトを開き、設定を操作して問題/ノートを生成する
2. 生成された内容を snapshot / screenshot で取得する
3. **「これは何か」を理解する** — 問題の種類、対象学年、形式を読み取る
4. `config/site-checks.yaml` の各 `check_perspectives` の question に対して判断する:
   - **print-accuracy**: 指定枚数と実ページ数の一致
   - **layout-quality**: A4収まり、余白、重なり
   - **content-correctness**: 内容を読んで正しさを判断（問題を解く、漢字を確認等）
   - **educational-value**: 教育的に意味のある内容か
5. 設定を変えて繰り返す（別の学年、別の問題タイプ、枚数変更等）
6. 問題があれば具体的な事象を記述して bugfix Issue を作成

### 実行方法: Playwright ヘッドレス（exec ツール経由）

browser ツールではなく、exec ツールで Playwright CLI / Node.js を直接実行する:

```bash
# スクリーンショット
npx playwright screenshot --full-page "URL" /tmp/site-qa.png

# DOM テキスト抽出・操作（Node.js ワンライナー）
node -e "
const {chromium}=require('playwright');
(async()=>{
  const b=await chromium.launch();
  const p=await b.newPage();
  await p.goto('URL');
  // 設定変更: セレクタでクリック・入力
  await p.click('selector');
  // テキスト抽出
  const text=await p.textContent('selector');
  console.log(JSON.stringify({problems: text}));
  await b.close();
})()
"
```

**できること:**

- スクリーンショット → read ツールで画像確認
- DOM テキスト抽出 → 問題文を取得して検算
- クリック・入力 → 設定変更、生成ボタン押下
- 重複チェック、答え合わせ → 抽出データを JSON で出力して検証

**制約:**

- `npx playwright pdf` は印刷用DOM が取れないため使えない（ネイティブダイアログ依存）
- 印刷レイアウトの検証はスクリーンショット + DOM 構造で代替する

GUI 不要。cron でバックグラウンド実行可能。

### チェックのローテーション

`monitoring/site-qa-history.jsonl` に過去のチェック履歴を記録:

```json
{
  "date": "2026-03-28",
  "site": "math-worksheet",
  "settings": { "grade": "1年", "type": "+1たし算", "columns": 2 },
  "result": "NG",
  "finding": "列ごと重複",
  "issue": 48
}
```

次回チェック時:

1. history を読んで、過去にチェック済みの設定組み合わせを把握
2. **まだチェックしていない問題タイプ・学年・設定を優先**する
3. 前回 NG だった設定は Issue が close されるまで再チェック不要（レトロスペクティブで追跡）
4. 全パターン一巡したら2周目に入る（ランダム生成なので毎回結果が変わり得る）

### 実行タイミング

- weekly-repo-health (日曜) の中で `demo_url` 付きリポをチェック
- 問題検出時は GitHub Issue を自動作成（type: bugfix）
- 既存 Issue と重複する場合はコメント追加に切り替え
