# workflow-engine Design Decisions

## 2026-06-11: Use AWS billing role for cloud cost reporting

- **What**: Use AWS billing role for cloud cost reporting
- **Why**: ## Summary - Replace the stored AWS Cost Explorer access key path with GCP runtime SA OIDC -> AWS STS `AssumeRoleWithWebIdentity`. - Configure Cloud Run deploys with `AWS_COST_ROLE_ARN=arn:aws:iam::980831117329:role/nishioka-hermes-cloud-co
- **Source**: PR #164

## 2026-06-11: fix(deploy): run service as workflow-runner SA and stop clobbering env vars

- **What**: fix(deploy): run service as workflow-runner SA and stop clobbering env vars
- **Why**: The auto-deploy for #162 (run 27334264476) failed: revision `workflow-runner-00165-cvl` crashed at startup with `403 storage.objects.get` on `gs://nishioka-workflow-engine-state/config/workflows.yaml`. Root cause is **not** the merged code
- **Source**: PR #163

## 2026-06-11: feat(cloud-cost): add group_by enum (service|sku|day) for finer cost analysis

- **What**: feat(cloud-cost): add group_by enum (service|sku|day) for finer cost analysis
- **Why**: Follow-up to #161. The personal-agent (Hermes on mm) hit the granularity ceiling of `/cloud-cost` in a real conversation: it could see a Vertex AI spike (¥784 of a ¥795 month, concentrated on 4 days) but could **not** answer "was this image
- **Source**: PR #162

## 2026-06-10: feat(cloud-cost): read-only /cloud-cost endpoint (AWS CE + GCP billing export)

- **What**: feat(cloud-cost): read-only /cloud-cost endpoint (AWS CE + GCP billing export)
- **Why**: Hermes Agent（Telegram経由のパーソナルエージェント、Mac mini `mm` 上で稼働）から「今月のAWS/GCPの費用は？」に答えられるようにする。クラウド認証情報をエージェント側ホストに置かないため、**workflow-engine を認証境界（credential proxy）にする** — `/generate-image` が確立した「高権限アクセスはサーバー側、呼び出し側はキーを持たない」パターンの踏襲です。
- **Source**: PR #161

## 2026-06-06: fix(gmail): harden /gmail/bookings (sender-spoofing, thread-safety, retry, path)

- **What**: fix(gmail): harden /gmail/bookings (sender-spoofing, thread-safety, retry, path)
- **Why**: マージ済み #158/#159 への gemini/codex レビュー指摘に対応するフォローアップ。
- **Source**: PR #160

## 2026-06-06: fix(gmail): build read-only Gmail service directly (no userinfo scope)

- **What**: fix(gmail): build read-only Gmail service directly (no userinfo scope)
- **Why**: ## 背景 初回デプロイ後、`/gmail/bookings` が `gmail_init_failed`（`KeyError: 'email'`）になった。
- **Source**: PR #159
