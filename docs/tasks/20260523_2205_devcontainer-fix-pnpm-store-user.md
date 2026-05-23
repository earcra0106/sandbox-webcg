# devcontainer-fix-pnpm-store-user

## 背景

`.devcontainer/entrypoint.sh` で `pnpm config set store-dir /workspaces/.pnpm-store` を実行している。

## 問題

entrypoint は root で実行される可能性が高い一方、devcontainer の作業ユーザーは `node` である。root 側の pnpm 設定に store-dir を書いても、`node` ユーザーで実行する `pnpm store path` に反映されない可能性がある。

## 対処方針

- pnpm の store-dir はユーザー設定に依存しない形で指定する。
- `compose.yaml` の環境変数で `NPM_CONFIG_STORE_DIR=/workspaces/.pnpm-store` を設定する案を優先する。
- 併せて `/workspaces/.pnpm-store` の mount と権限を確認する。

## 変更候補

- `.devcontainer/compose.yaml` の `environment` に `NPM_CONFIG_STORE_DIR: /workspaces/.pnpm-store` を追加する。
- `.devcontainer/entrypoint.sh` の `pnpm config set store-dir` は削除、または `node` ユーザー側に明示して実行する。

## 実装結果

- `.devcontainer/compose.yaml` の `environment` に `NPM_CONFIG_STORE_DIR: /workspaces/.pnpm-store` を追加した。
- `.devcontainer/entrypoint.sh` の `pnpm config set store-dir /workspaces/.pnpm-store` を削除し、実行ユーザーごとの pnpm 設定に依存しない形にした。

## 検証

- devcontainer 内の `node` ユーザーで `pnpm store path` が `/workspaces/.pnpm-store/v11` を返すこと。
- `pnpm install` または `pnpm add -g` が store 権限エラーなく成功すること。
