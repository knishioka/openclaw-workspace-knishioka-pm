## Problem / Why

本番公開中の `https://knishioka.github.io/kanji-practice/` を 2026-04-26 の weekly-repo-health で確認したところ、**プレビュー右下に `Debug` ボタンが常時表示されている**。これは開発用 UI が production build に残っている状態で、初見ユーザーに不要なノイズを与える。

今回の確認では、1年生 / 書き練習 / 1枚 / 3マス / 15mm / 十字ガイドのデフォルト表示時点で `Debug` バッジが見えていた。印刷物そのものには `no-print` で含まれない可能性が高いが、**設定→生成→印刷の導線上にデバッグ表現が露出していること自体が UX 上の不具合**。

コード上でも `src/App.tsx` で `DebugOverlay` が常時マウントされており、`src/components/DebugOverlay.tsx` では `enabled=false` でもトグル用の `Debug` ボタンを表示する実装になっている。

## Acceptance Criteria

- [ ] production 環境ではプレビュー右下に `Debug` ボタンが表示されない
- [ ] 開発時のみレイアウト検証 UI を使える導線が維持される、もしくは明示的な開発フラグでのみ有効化される
- [ ] `npm run build` 後の GitHub Pages 相当 build で、通常表示時にデバッグ UI が露出しない
- [ ] 既存のプレビュー表示・印刷・PDF保存フローは壊れない
- [ ] 既存テストが通ること

## Non-goals (Scope外)

- デバッグオーバーレイ自体の全面削除
- レイアウト検証ロジックの再設計
- 印刷レイアウト仕様の変更

## Constraints

- 開発者向けのデバッグ機能は必要なら残してよいが、本番UIに露出させない
- 既存の `no-print` 指定やプレビューDOM構造を壊さない
- 1 Issue = 1 PR で完結する小さな修正に保つ

## Tasks

- [ ] `src/App.tsx` で `DebugOverlay` のマウント条件を production / development で切り替える
- [ ] もしくは `src/components/DebugOverlay.tsx` 側で production 時はトグルボタンを描画しないようにする
- [ ] Vite の `import.meta.env.DEV` など、公開 build と開発 build を安全に判別できる方法を使う
- [ ] E2E またはスナップショットで、本番相当表示に `Debug` が出ないことを確認する

## References

- 影響ファイル:
  - `src/App.tsx`
  - `src/components/DebugOverlay.tsx`
- 確認日時: 2026-04-26 weekly-repo-health
- 確認URL: https://knishioka.github.io/kanji-practice/
- 証跡スクリーンショット: `reports/site-qa/kanji-practice.png`
- 関連 Issue: なし

---

Type: bugfix
Priority: medium
Created by: knishioka-pm (automated)
