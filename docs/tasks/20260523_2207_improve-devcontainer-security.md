# improve-devcontainer-security

## 作業タイトル

env/improve-devcontainer-security

## 作業の目的と概要

devcontainer 関連のレビュー指摘を同一ブランチで改善する。今回は優先度が高い `devcontainer-avoid-ssh-secret-copy` を対象に、ホスト側 SSH 秘密鍵が devcontainer 内へ複製されない構成へ変更する。

## 作成・編集するファイルのスコープ

- `.devcontainer/entrypoint.sh`
- `docs/tasks/20260523_2205_devcontainer-avoid-ssh-secret-copy.md`

## 実装するモジュールの概要

- `/host_config/.ssh` の一括コピーを廃止する。
- SSH 接続の既知ホスト情報として必要な `known_hosts` のみを限定コピーする。
- コピー後の所有者と権限を `node` ユーザー向けに整える。

## アクセス方法・操作説明

VS Code の Dev Containers 拡張機能から、このリポジトリをコンテナで再オープンする。SSH 認証は秘密鍵のコピーではなく SSH agent ソケット経由で利用する。
