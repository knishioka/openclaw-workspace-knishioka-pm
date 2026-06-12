# 1000haku Design Decisions

## 2026-06-11: feat(content): #16301 沖縄台風安心特約2026 記事を公開予約 + PDCA init

- **What**: feat(content): #16301 沖縄台風安心特約2026 記事を公開予約 + PDCA init
- **Why**: 新 PDCA フロー (strategy → write --from-strategy) での初の記事公開。WP には #16301 として 2026-06-12 06:00 JST に予約公開済み。
- **Source**: PR #84

## 2026-06-11: fix(pdca): collect で scheduled→active を自動昇格

- **What**: fix(pdca): collect で scheduled→active を自動昇格
- **Why**: `/pdca` snapshot の self-healing 初稼働 (PR #79) で発覚した構造バグ。5月公開済みの 5 記録が毎週 collect されているのに `status: scheduled` のまま凍結していた。
- **Source**: PR #81

## 2026-06-10: fix(pdca): collect --all の全件失敗を exit 1 で表面化

- **What**: fix(pdca): collect --all の全件失敗を exit 1 で表面化
- **Why**: PR #79 マージ直前に届いた Codex P2 への follow-up (マージ手順ミスで未対応のまま merge してしまったため別 PR で即対応)。
- **Source**: PR #80

## 2026-06-10: feat(pdca): collect --all — stale check の self-healing sweep

- **What**: feat(pdca): collect --all — stale check の self-healing sweep
- **Why**: #16077 の Act review (PR #78) で発覚した「check が公開後 1 週間で止まり 4 週間放置」の再発防止。collect 定期化の検討結果、**案 A: /pdca snapshot への self-healing 組み込み**を実装 (cron 不要・新インフラ不要)。
- **Source**: PR #79

## 2026-06-10: fix(pdca): /pdca approve に featured_media 未設定ガードを追加

- **What**: fix(pdca): /pdca approve に featured_media 未設定ガードを追加
- **Why**: 画像生成は歴史的に失敗が多い工程 (2026-05-14 Pillow 直書き事故等) だが、/pdca approve の手順では「eyecatch 失敗時に G-Final へ進まない」ことが明文化されていなかった。
- **Source**: PR #77

## 2026-06-10: feat(pdca): 朝刊 routine + /pdca approve — 発表→公開リードタイムを最大24時間に

- **What**: feat(pdca): 朝刊 routine + /pdca approve — 発表→公開リードタイムを最大24時間に
- **Why**: PDCA 省力化計画の PR6/6 (PR #75 の上に stack)。「朝刊方式」の最終形。
- **Source**: PR #76
