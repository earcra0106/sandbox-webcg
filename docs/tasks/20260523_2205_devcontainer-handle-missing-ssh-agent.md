# devcontainer-handle-missing-ssh-agent

## 背景

`.devcontainer/devcontainer.json` で `${localEnv:SSH_AUTH_SOCK}` を mount 元として使っている。

## 問題

ホスト側で `SSH_AUTH_SOCK` が未設定の場合、mount 元が空になり devcontainer 起動に失敗する可能性がある。SSH agent を使っていない環境でも devcontainer 自体は起動できるべきである。

## 対処方針

- SSH agent が存在しない環境でも devcontainer 起動を阻害しない構成にする。
- 必須 mount と任意 mount を分ける。
- SSH agent 連携は失敗時に警告またはスキップできる形にする。

## 変更候補

- `${localEnv:SSH_AUTH_SOCK}` を直接 mount する設計を見直す。
- 必要ならホスト側に固定パスを作る運用、または Dev Containers の標準 SSH agent forwarding を利用する。
- entrypoint では `/host_config/ssh_auth_sock` が存在しない場合に何もせず続行する。

## 検証

- ホスト側 `SSH_AUTH_SOCK` が未設定でも devcontainer が起動すること。
- SSH agent が設定済みの環境では SSH 認証が利用できること。
