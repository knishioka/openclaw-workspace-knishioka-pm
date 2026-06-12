# workflow-engine Knowledge Base

## Overview

- Repo: knishioka/workflow-engine
- Description: Convert Zapier workflows to Claude Code, Agent SDK, or API implementations
- Primary language (GitHub): Python
- License: MIT
- Default branch: master
- Created: 2025-10-19
- Updated: 2026-06-11
- Collected: 2026-06-12

## Tech Stack

- package.json: not found (or not accessible via GitHub contents API)
- pyproject.toml: present
- requirements.txt: present

## Architecture / Patterns

- (No clear patterns inferred from README/dependencies in this snapshot)

## Tech Decisions (from PRs/commits)

- [2026-06-11] Use AWS billing role for cloud cost reporting -- ## Summary - Replace the stored AWS Cost Explorer access key path with GCP runtime SA OIDC -> AWS STS `AssumeRoleWithWebIdentity`. - Configure Cloud Run deploys with `AWS_COST_ROLE_ARN=arn:aws:iam::980831117329:role/nishioka-hermes-cloud-co (source: PR #164)
- [2026-06-11] fix(deploy): run service as workflow-runner SA and stop clobbering env vars -- The auto-deploy for #162 (run 27334264476) failed: revision `workflow-runner-00165-cvl` crashed at startup with `403 storage.objects.get` on `gs://nishioka-workflow-engine-state/config/workflows.yaml`. Root cause is **not** the merged code  (source: PR #163)
- [2026-06-11] feat(cloud-cost): add group_by enum (service|sku|day) for finer cost analysis -- Follow-up to #161. The personal-agent (Hermes on mm) hit the granularity ceiling of `/cloud-cost` in a real conversation: it could see a Vertex AI spike (¥784 of a ¥795 month, concentrated on 4 days) but could **not** answer "was this image (source: PR #162)
- [2026-06-10] feat(cloud-cost): read-only /cloud-cost endpoint (AWS CE + GCP billing export) -- Hermes Agent（Telegram経由のパーソナルエージェント、Mac mini `mm` 上で稼働）から「今月のAWS/GCPの費用は？」に答えられるようにする。クラウド認証情報をエージェント側ホストに置かないため、**workflow-engine を認証境界（credential proxy）にする** — `/generate-image` が確立した「高権限アクセスはサーバー側、呼び出し側はキーを持たない」パターンの踏襲です。 (source: PR #161)
- [2026-06-06] fix(gmail): harden /gmail/bookings (sender-spoofing, thread-safety, retry, path) -- マージ済み #158/#159 への gemini/codex レビュー指摘に対応するフォローアップ。 (source: PR #160)
- [2026-06-06] fix(gmail): build read-only Gmail service directly (no userinfo scope) -- ## 背景 初回デプロイ後、`/gmail/bookings` が `gmail_init_failed`（`KeyError: 'email'`）になった。 (source: PR #159)
