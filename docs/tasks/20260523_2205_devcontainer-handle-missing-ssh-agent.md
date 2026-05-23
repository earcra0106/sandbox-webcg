# devcontainer-handle-missing-ssh-agent

## 背景

`.devcontainer/devcontainer.json` で `${localEnv:SSH_AUTH_SOCK}` を mount 元として使っている。

## 当初の問題

ホスト側で `SSH_AUTH_SOCK` が未設定の場合、mount 元が空になり devcontainer 起動に失敗する可能性がある。SSH agent を使っていない環境でも devcontainer 自体は起動できるべきである。

## 当初の対処方針

- SSH agent が存在しない環境でも devcontainer 起動を阻害しない構成にする。
- 必須 mount と任意 mount を分ける。
- SSH agent 連携は失敗時に警告またはスキップできる形にする。

## 当初の変更候補

- `${localEnv:SSH_AUTH_SOCK}` を直接 mount する設計を見直す。
- 必要ならホスト側に固定パスを作る運用、または Dev Containers の標準 SSH agent forwarding を利用する。
- entrypoint では `/host_config/ssh_auth_sock` が存在しない場合に何もせず続行する。

## 当初の実装結果

- `${localEnv:SSH_AUTH_SOCK}` を直接 mount する構成をやめ、`/tmp` を `/host_tmp` へ readonly mount する構成に変更した。
- `HOST_SSH_AUTH_SOCK` が `/tmp/...` を指す場合のみ、対応する `/host_tmp/...` のソケットを検出して `/home/node/.ssh/ssh_auth_sock` へシンボリックリンクするようにした。
- `HOST_SSH_AUTH_SOCK` が未設定、または対応ソケットが存在しない場合は、リンクを作らずに処理を続行するようにした。

## 方針変更

ホスト側で `SSH_AUTH_SOCK` が未設定の場合は、SSH agent 連携なしで続行せず devcontainer 起動前に明示的に失敗させる。

## 方針変更後の実装結果

- `.devcontainer/devcontainer.json` の `initializeCommand` で、ホスト側 `SSH_AUTH_SOCK` が未設定の場合にエラー終了するようにした。
- SSH agent ソケットの mount は `source=${localEnv:SSH_AUTH_SOCK},target=/host_config/ssh_auth_sock` に戻した。
- `.devcontainer/entrypoint.sh` でも `/host_config/ssh_auth_sock` が Unix ソケットとして存在しない場合はエラー終了するようにした。
- `/home/node/.ssh/ssh_auth_sock` は `/host_config/ssh_auth_sock` への固定シンボリックリンクとして作成するようにした。

## 検証

- ホスト側 `SSH_AUTH_SOCK` が未設定の場合、devcontainer 起動前に明示エラーになること。
- SSH agent が設定済みの環境では SSH 認証が利用できること。
