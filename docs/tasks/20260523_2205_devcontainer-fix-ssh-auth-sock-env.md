# devcontainer-fix-ssh-auth-sock-env

## 背景

`.devcontainer/entrypoint.sh` で `SSH_AUTH_SOCK` を export し、`/etc/profile.d` にも書き出している。

## 問題

entrypoint 内の `export SSH_AUTH_SOCK=...` は、後から起動する VS Code のターミナルや拡張機能プロセスへ確実に伝わるとは限らない。`docker exec` 相当で起動されるプロセスは PID 1 の環境変数変更を継承しない場合がある。

## 対処方針

- `SSH_AUTH_SOCK` は `devcontainer.json` の `remoteEnv` で固定パスへ明示する。
- ホストの SSH agent ソケットは devcontainer 内の固定パスへ mount する。
- entrypoint では必要に応じて固定パスの存在確認だけを行う。

## 変更候補

- `devcontainer.json` に `"SSH_AUTH_SOCK": "/host_config/ssh_auth_sock"` を設定する。
- entrypoint 内の `export SSH_AUTH_SOCK` と `/etc/profile.d` 書き込みを整理する。
- `/home/node/.ssh` 配下へソケットリンクを置く必要があるか再検討する。

## 検証

- devcontainer 内の新規ターミナルで `echo "$SSH_AUTH_SOCK"` が期待値を返すこと。
- `ssh-add -l` がホスト側 agent の鍵一覧を取得できること。
- VS Code の Git 操作でも SSH 認証が利用できること。
