# devcontainer-fix-node-home-permissions

## 背景

`.devcontainer/entrypoint.sh` で `/home/node/.ssh` と `/home/node/.codex` を作成し、ホスト側設定をコピーしている。

## 問題

entrypoint が root で動く場合、作成・コピーされたファイルの所有者が root になる。`remoteUser` は `node` のため、`node` ユーザーから設定を更新できない、SSH がファイル権限を拒否する、などの問題につながる。

## 対処方針

- `/home/node/.ssh` と `/home/node/.codex` 配下は最終的に `node:node` 所有にする。
- `.ssh` は SSH が要求する permission に整える。
- コピー対象を限定したうえで権限を設定する。

## 変更候補

- `chown -R node:node /home/node/.ssh /home/node/.codex` を追加する。
- `.ssh` ディレクトリを `700`、通常ファイルを必要に応じて `600` または `644` にする。
- 秘密鍵をコピーしない方針と合わせて permission 設計を整理する。

## 実装結果

- `.devcontainer/entrypoint.sh` で `/home/node/.ssh` と `/home/node/.codex` の owner を `node:node` に整えるようにした。
- `/home/node/.ssh` の permission を `700` に設定するようにした。
- 秘密鍵はコピーしない前提のため、限定コピーしている `known_hosts` は `644` のまま扱う。

## 検証

- `node` ユーザーで `.codex` を読み書きできること。
- `ssh` 実行時に permission warning が出ないこと。
- root 所有の不要ファイルが `/home/node/.ssh` や `/home/node/.codex` に残らないこと。
