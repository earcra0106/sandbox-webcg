# git branch creation failed

- 発生日時: 2026/05/23 16:43
- 分類: env
- タイトル: git branch creation failed

## 内容

`git checkout -b env/add-devcontainer` を実行したところ、以下のエラーで作業ブランチを作成できなかった。

```text
fatal: cannot lock ref 'refs/heads/env/add-devcontainer': unable to create directory for .git/refs/heads/env/add-devcontainer
```

## 原因

`.git/refs/heads/` 配下に新しいブランチ参照用ディレクトリを作成できず、Git メタデータ更新が失敗した。既知の環境制約として、`.git/` 配下のロックファイルや参照更新が実行環境で拒否される場合がある。

## 解決方法

通常権限で同じ Git 操作を繰り返さず、権限昇格でブランチ作成を再実行する。

## 代替案

権限昇格でも失敗する場合は、ユーザー側で作業ブランチを作成してから作業を継続する。
