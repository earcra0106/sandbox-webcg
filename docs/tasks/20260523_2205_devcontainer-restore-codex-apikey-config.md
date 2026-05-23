# devcontainer-restore-codex-apikey-config

## 背景

以前の実装では `/home/node/.codex/config.toml` に `preferred_auth_method = "apikey"` を設定していたが、現在の `.devcontainer/entrypoint.sh` からはその処理が消えている。

## 問題

ホスト側の `.codex/config.toml` に設定がない場合、devcontainer 内で Codex が API key 認証を優先しない可能性がある。

## 対処方針

- devcontainer 内の `/home/node/.codex/config.toml` に `preferred_auth_method = "apikey"` が存在する状態を保証する。
- ホスト側 `.codex` をコピーまたは mount する場合でも、devcontainer 内で必要な設定を補完する。
- 既存の config がある場合は他の設定を壊さず、該当キーだけ追加または更新する。

## 変更候補

- `.devcontainer/entrypoint.sh` に `config.toml` の作成と `preferred_auth_method` の upsert 処理を戻す。
- `/home/node/.codex` の owner を `node:node` に整える。

## 実装結果

- `.devcontainer/entrypoint.sh` で `/home/node/.codex/config.toml` を作成する処理を追加した。
- `preferred_auth_method` が既にある場合は `apikey` に更新し、ない場合は `preferred_auth_method = "apikey"` を追記するようにした。
- ホスト側 `.codex` をコピーした後に upsert することで、ホスト設定を残しつつ API key 認証優先を保証するようにした。

## 検証

- devcontainer 内で `/home/node/.codex/config.toml` に `preferred_auth_method = "apikey"` が存在すること。
- 既存の Codex 設定が消えないこと。
- `OPENAI_API_KEY` が設定された状態で Codex が API key 認証を利用できること。
