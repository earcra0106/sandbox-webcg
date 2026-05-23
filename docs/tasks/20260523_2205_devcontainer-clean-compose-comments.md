# devcontainer-clean-compose-comments

## 背景

`.devcontainer/compose.yaml` にコメントアウトされた未完成の `volumes` 設定と末尾空白が残っている。

## 問題

`git diff --check -- .devcontainer` が trailing whitespace で失敗している。未完成のコメントは、現在有効な構成が `compose.yaml` と `devcontainer.json` のどちらにあるのかを分かりにくくしている。

## 対処方針

- 不要なコメントアウト済み設定を削除する。
- 現在有効な mount 設定の置き場所を `devcontainer.json` または `compose.yaml` のどちらかに整理する。
- trailing whitespace と EOF の空白行をなくす。

## 変更候補

- `.devcontainer/compose.yaml` のコメントアウト済み `volumes` ブロックを削除する。
- entrypoint の指定も、使わない旧設定コメントを削除する。
- `git diff --check -- .devcontainer` が通る状態にする。

## 検証

- `docker compose -f .devcontainer/compose.yaml config` が通ること。
- `git diff --check -- .devcontainer` が通ること。
