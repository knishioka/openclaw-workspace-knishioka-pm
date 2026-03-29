As of: 2026-03-29
Summary: RED 5 / YELLOW 2 / GREEN 3

>> Changes this week:
  (no status transitions detected; GREEN/YELLOW/RED counts unchanged vs 2026-03-28)

>> Risks / Blockers:
  knishioka/ib-sec-mcp  CI: Security (schedule) が gitleaks の `ib-account-id` ルール検出で failure（tests/* 内のテストデータ） [RED 3回連続]
  knishioka/cost-management-mcp  CI/Security Scan が trufflehog の設定で failure（"BASE and HEAD commits are the same" で scan されず exit 1） [RED 3回連続]
  knishioka/td-mcp-server  238日更新なし + open PR 2（CIはsuccessだが停滞） [RED 3回連続]
  knishioka/meditation-chrome-extension  272日更新なし（CIなし） [RED 3回連続]
  knishioka/remotion-math-education  285日更新なし（CIなし） [RED 3回連続]
  knishioka/simple-bookkeeping  78日更新なし + open issues 36 / PR 8（作業負債が増えがち） [YELLOW]

>> Next actions:
  knishioka/ib-sec-mcp: Issue #103 (open) を先に解消して Security workflow を green に戻す（tests の account-id をマスク or ルール例外）
  knishioka/cost-management-mcp: trufflehog 実行条件（push 時 BASE/HEAD が同一扱い）を修正する Issue 候補（今回は自動作成なし）
  knishioka/kanji-practice: Issue #20 は現状再現せず（10枚→生成後も 10/10 表示・ページ数も維持）。確認後 close 提案

>> Confirmed:
  knishioka/kanji-practice  最終更新7日前 GREEN / open issues 2 / PR 0
  knishioka/math-worksheet  最終更新0日前 GREEN / open issues 2 / PR 2
  knishioka/freee-mcp  最終更新23日前 GREEN / open issues 1 / PR 15
  knishioka/english-note-maker  最終更新87日前 YELLOW / open issues 1 / PR 0
  knishioka/simple-bookkeeping  最終更新78日前 YELLOW / open issues 36 / PR 8
  knishioka/ib-sec-mcp  最終更新8日前 RED / open issues 2 / PR 4
  knishioka/cost-management-mcp  最終更新1日前 RED / open issues 3 / PR 3
  knishioka/td-mcp-server  最終更新238日前 RED / open issues 0 / PR 2
  knishioka/meditation-chrome-extension  最終更新272日前 RED / open issues 0 / PR 0
  knishioka/remotion-math-education  最終更新285日前 RED / open issues 0 / PR 0

---

## Demo Site QA (severity: high 相当)

- knishioka/kanji-practice
  - print-accuracy: ページ数 1/5/10 を指定 → 生成後のフッターが 1/1, 5/5, 10/10 と一致（ページ数もリセットされず）
  - layout-quality: 10枚でもページフッター・余白が崩れず（目視）
  - content-correctness: 3年生で生成した漢字は範囲内に見える（抜き取り確認）

- knishioka/math-worksheet
  - print-accuracy: UI上の制約で各レイアウトが基本「A4 1枚に収まる最大問題数」に調整される
  - content-correctness: 1年生「+1のたし算」解答表示 ON で抜き取り計算が一致
  - regression check (Issue #48): 2列/20問で (n) と (n+10) の列コピーは再現せず（first10 vs last10 の完全一致=0）

- knishioka/english-note-maker
  - print-accuracy: ページ数 5/10 を指定 → プレビュー見出しが (1/5)…(5/5), (1/10)…(10/10) と一致
  - layout-quality: A4 preview 内で崩れなし（目視）

---

## Issue Tracker (retrospective)

- Resolved this week:
  - knishioka/math-worksheet #48 (bugfix) → PR #51 merged (2026-03-29) / Quality: A (body_hash未記録のため本文編集有無は未判定)

- Still open:
  - knishioka/ib-sec-mcp #103 (maintenance)
  - knishioka/kanji-practice #20 (bugfix)
  - knishioka/english-note-maker #19 (feature)
  - knishioka/kanji-practice #21 (improvement)
