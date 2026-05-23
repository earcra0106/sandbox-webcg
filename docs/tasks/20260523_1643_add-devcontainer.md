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
