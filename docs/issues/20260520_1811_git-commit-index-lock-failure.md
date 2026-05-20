# git commit index.lock 作成失敗

## 発生日時

2026/05/20 18:11

## 分類

env

## 内容

`git commit -m "作業再開用skillを追加"` を実行したところ、以下のエラーで失敗した。

```text
fatal: Unable to create '/home/earcra/project/sandbox-webcg/.git/index.lock': Read-only file system
```

## 原因

サンドボックス環境から `.git/index.lock` を作成できず、Git のメタデータ更新が read-only filesystem として拒否された。

## 解決方法

コミット操作は作業に必要な Git メタデータ更新を伴うため、権限昇格して `git commit` を再実行する。

## 代替案

権限昇格が許可されない場合は、ステージ済みの変更内容を維持したまま、ユーザー側で `git commit -m "作業再開用skillを追加"` を実行する。
