# add-devcontainer

## 作業タイトル

env/add-devcontainer

## 作業の目的と概要

WSL 上で Docker コマンドを利用できる前提の devcontainer 構成を追加する。Node.js 24.15.0 をベースに、corepack や Node.js バージョン管理ツールを使わず、entrypoint で pnpm 11.1.1 と codex をインストールするたたき台を作成する。

## 作成・編集するファイルのスコープ

- `.devcontainer/devcontainer.json`
- `.devcontainer/compose.yaml`
- `.devcontainer/entrypoint.sh`

## 実装するモジュールの概要

- devcontainer の VS Code 設定と Docker Compose サービス定義を追加する。
- コンテナ起動時に pnpm と codex を準備する entrypoint を追加する。

## アクセス方法・操作説明

VS Code の Dev Containers 拡張機能から、このリポジトリをコンテナで再オープンする。コンテナ内では `node`、`npm`、`pnpm`、`codex` を使用する。

## 追加作業 2026/05/23

- devcontainer 内で Codex が API キー認証を優先するように、起動時に `/home/node/.codex/config.toml` へ `preferred_auth_method = "apikey"` を設定する処理を追加した。
- 当初は `.devcontainer/.env` の `OPENAI_API_KEY_FOR_CODEX` を `OPENAI_API_KEY` として読み込む構成を追加したが、機密情報をリポジトリ配下の env ファイルで管理しない方針に変更した。
- `.devcontainer/devcontainer.json` の `remoteEnv` で、ホスト側の `OPEN_AI_API_KEY` を devcontainer 内の `OPENAI_API_KEY` として渡す構成に変更した。
- `.devcontainer/.env.example` は削除し、誤って `.devcontainer/.env` を追加しないための `.devcontainer/.gitignore` は残した。
