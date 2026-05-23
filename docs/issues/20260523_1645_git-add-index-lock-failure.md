# git add index lock failure

- 発生日時: 2026/05/23 16:45
- 分類: env
- タイトル: git add index lock failure

## 内容

`git add .devcontainer/devcontainer.json .devcontainer/compose.yaml .devcontainer/entrypoint.sh docs/issues/20260523_1643_git-branch-creation-failed.md docs/tasks/20260523_1643_add-devcontainer.md` を実行したところ、以下のエラーでステージできなかった。

```text
fatal: Unable to create '/home/haji1/projects/sandbox-webcg/.git/index.lock': Read-only file system
```

## 原因

`.git/index.lock` を作成できず、Git インデックス更新が失敗した。既知の環境制約として、`.git/` 配下のロックファイルや参照更新が実行環境で拒否される場合がある。

## 解決方法

通常権限で同じ Git 操作を繰り返さず、権限昇格でステージを再実行する。

## 代替案

権限昇格でも失敗する場合は、ユーザー側で `git add` と `git commit` を実行する。
