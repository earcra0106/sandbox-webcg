# update-devcontainer-tools

## 作業タイトル

devcontainer のツールとポート設定を更新

## 確認した現在変更の概要

- `.devcontainer/Dockerfile` に `iproute2` を追加し、コンテナ内でネットワーク確認用コマンドを使えるようにする。
- `.devcontainer/devcontainer.json` に `forwardPorts: [5173]` を追加し、Vite などの開発サーバーポートを転送する。

## 対象ファイル

- `.devcontainer/Dockerfile`
- `.devcontainer/devcontainer.json`

## 検証内容

- `.devcontainer/` 配下の差分を確認する。
- ステージ対象が `.devcontainer/` 配下とこの作業記録のみであることを確認する。

## コミット予定内容

devcontainer のパッケージ追加とポート転送設定のみをコミットする。`dist/` と `node_modules/` は対象外とする。
