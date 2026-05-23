# devcontainer-stabilize-mount-paths

## 背景

`.devcontainer/devcontainer.json` の `mounts` で `source=../..` や `source=~/.codex` を使っている。

## 問題

相対パスや `~` は、Dev Containers と Docker の解釈差により環境によって不安定になる可能性がある。特に Docker の mount 指定ではシェル展開が行われないため、`~` が期待通りホームディレクトリにならない場合がある。

## 対処方針

- Dev Containers の変数を使い、mount 元を明示する。
- リポジトリルートには `${localWorkspaceFolder}` を使う。
- ホームディレクトリ配下には `${localEnv:HOME}` を使う。

## 変更候補

- `source=../..` を `source=${localWorkspaceFolder}/../..` など、意図が明確な指定へ変更する。
- `source=~/.codex` を `source=${localEnv:HOME}/.codex` へ変更する。
- `source=~/.ssh` を `source=${localEnv:HOME}/.ssh` へ変更する。

## 検証

- `Dev Containers: Rebuild Container` で mount エラーが発生しないこと。
- コンテナ内で `/workspaces/sandbox-webcg`、`/host_config/.codex`、`/host_config/.ssh` が期待通り見えること。
