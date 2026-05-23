# devcontainer-avoid-ssh-secret-copy

## 背景

`.devcontainer/entrypoint.sh` で `/host_config/.ssh` を `/home/node/.ssh` に丸ごとコピーしている。

## 問題

ホスト側の秘密鍵などの機密ファイルが devcontainer 内へ複製される可能性がある。AI ツールが参照可能なワークスペースやホームディレクトリに秘密情報を置く構成は避ける。

## 対処方針

- SSH 秘密鍵はコピーしない。
- GitHub などへの認証は SSH agent ソケット経由を優先する。
- 必要な場合のみ `known_hosts` や `config` など、秘密情報を含まないファイルを限定的にコピーする。
- コピー対象を明示的に列挙し、ワイルドカードによる一括コピーを避ける。

## 実装結果

- `/host_config/.ssh` の一括コピーを廃止した。
- `/host_config/.ssh/known_hosts` が存在する場合のみ `/home/node/.ssh/known_hosts` へコピーするようにした。
- コピーした `known_hosts` の owner と permission を `node` ユーザー向けに整えるようにした。

## 変更候補

- `.devcontainer/entrypoint.sh` の `/host_config/.ssh` 一括コピーを削除する。
- `known_hosts` が存在する場合だけ `/home/node/.ssh/known_hosts` へコピーする。
- コピー後の owner と permission を `node` ユーザー向けに整える。

## 検証

- devcontainer 内に秘密鍵ファイルが作成されないこと。
- SSH agent 経由で `git fetch` などが成功すること。
- `ssh` が permission warning を出さないこと。
