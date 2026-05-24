# remove-devcontainer-auth-config

## 作業の目的と概要

devcontainer 起動時に `/home/node/.codex/config.toml` へ `preferred_auth_method = "apikey"` を自動設定する処理を削除する。

ホスト側の Codex 設定をコンテナへコピーした後に認証方式を書き換えないようにし、ユーザー側の既存設定を保持する。

## 作成・編集するファイルのスコープ

- `.devcontainer/entrypoint.sh`

## 実装する関数、クラス、モジュールの概要

シェルスクリプト内の Codex 設定ファイル生成および `preferred_auth_method` 書き換え処理を削除する。追加の関数やクラスは作成しない。

## アクセス方法・確認方法

devcontainer 起動時に `.devcontainer/entrypoint.sh` が実行される。起動後、ホスト側からコピーされた `/home/node/.codex/config.toml` の認証方式が entrypoint によって上書きされないことを確認する。
