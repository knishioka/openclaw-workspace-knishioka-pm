<!--
per-repo AGENTS.md skeleton.

役割分担 (CLAUDE.md と並走させる場合):
- AGENTS.md = ポリシー / アーキ / 検証 / レビュー観点 (汎用、ツール非依存)。
- CLAUDE.md = Claude Code 固有設定 (sub-agent / skills / hooks / slash command) のみ。
- それ以外はすべて AGENTS.md に書き、CLAUDE.md からは `See AGENTS.md` で参照する。

このファイルを各リポにコピーし、`{...}` プレースホルダを置換し、
「(任意)」の節は不要なら丸ごと削除すること。`{省略可}` 行は削除して構わない。
出典 SSOT: workspace `docs/codex-playbook.md` "PR Description Standards"。
-->

# AGENTS.md - {repo-name}

## Mission (必須)

{このリポが解いている問題を 1〜2 文で。プロダクト目的・対象ユーザー・成功条件}

## Stack (必須)

- 言語: {例 TypeScript / Python 3.12 / Rust 1.81 / Go 1.23}
- フレームワーク: {例 Next.js 15 / FastAPI / Axum}
- パッケージマネージャ: {例 pnpm / uv / cargo / go modules}
- 主要ツール: {linter / formatter / typechecker / test runner を 1 行で}
- ランタイム/インフラ: {例 Vercel / Cloudflare Workers / 自前 docker。任意}

## Verification (必須)

このリポの検証エントリポイントは `./scripts/verify.sh` に統一する。

```bash
./scripts/verify.sh           # 人間可読 (text)
./scripts/verify.sh --json    # 構造化結果 (CI / Codex 用)
```

- 内部で build / lint / format / typecheck / test を順に実行する。
- 失敗時の exit code: `0` 全 pass / `1` 1 つ以上 fail / `2` 環境エラー。
- lint 未導入の項目は `n/a` を出力する (黙って省略しない)。
- 詳細は `scripts/verify.sh` 冒頭コメント、または `docs/templates/verify-sh-template.sh` を参照。

## PR conventions (必須)

PR 本文は **日本語**、ブランチ名 / コミット / PR タイトルは英語。
本文の構造は workspace `docs/codex-playbook.md` の **"PR Description Standards"** に従う
(概要 / 変更内容 / 動作確認 / 受け入れ条件 / スコープ外 / 影響範囲 / レビュー観点)。

- リポ直下の `.github/PULL_REQUEST_TEMPLATE.md` は `docs/templates/pull-request-template.md` をコピーして利用する。
- このリポ固有の追加チェック項目があれば、テンプレに足してこの節に列挙する: {例: スクリーンショット必須 / migration 確認 など}

## Never touch (必須)

エージェントが触ってはいけないファイル / ディレクトリ:

- {自動生成: 例 `pnpm-lock.yaml`, `Cargo.lock`, `*.snap`, `dist/`}
- {手動メンテ: 例 `AGENTS.md`, `docs/policy.md`, secrets template}
- {データ: 例 `migrations/<applied>/`, `fixtures/golden/`}

> 削除・破壊的変更が必要なときは PR 本文の "影響範囲 / リスク" に明示してから提案する。

## Architectural invariants (必須)

崩したら設計が壊れる不変条件を 3〜5 個。新人が違反しがちな順に並べる:

- {例: ドメイン層は I/O に依存しない (handlers/ → services/ → domain/ の単方向)}
- {例: API レスポンスはすべて `Result<T, AppError>` 経由で返す}
- {例: feature flag を読むのは `config/flags.ts` のみ}

## Known pitfalls (任意・推奨)

- {例: dev 環境では `XXX` が mock になっており、実 API との挙動差で踏みやすい}
- {例: テスト並列実行時に DB ポートが衝突するため `--test-threads=1`}

## Quality bar (必須)

- テストカバレッジ目標: {例 line 70% / branch 60%}
- 必須チェック: build / lint / format / typecheck / test がすべて pass
- パフォーマンス予算: {該当時のみ。例 p95 < 200ms / bundle < 300KB}
- セキュリティ: {例 secret scan / `npm audit` high 0 件}

---

<!--
削除可否ガイド:
- 必須セクション (Mission/Stack/Verification/PR conventions/Never touch/Architectural invariants/Quality bar): 残す。空でも見出しは残し「該当なし」を明記。
- 任意セクション (Known pitfalls): 不要なら見出しごと削除して構わない。

サイズ目安: 全体 100 行以内。超えそうなら個別ドキュメントに分離して参照する。
-->
