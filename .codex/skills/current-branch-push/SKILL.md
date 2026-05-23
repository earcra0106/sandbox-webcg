---
name: current-branch-push
description: 現在のブランチを origin に push する。ユーザーが現在ブランチの push を明示的に依頼したときに使う。
---

# Current Branch Push

以下の手順で、現在のブランチをリモートへ push する。

## 目的

現在チェックアウトされているブランチを `origin` に push する。

## 前提

- ユーザーが「現在のブランチを push」「このブランチを push」「$current-branch-push」など、リモート操作を明示的に依頼したときにのみ使う。
- 作業ツリーに未コミットの変更がある場合は、push 前にユーザーへ確認する。
- `main` を push する場合は、ユーザーが明示的に `main` の push を依頼している場合を除き、実行前に確認する。

## 手順

```bash
git branch --show-current
git status --short --branch
```

1. 現在のブランチ名を確認する。
2. 作業ツリーに未コミットの変更がないことを確認する。
3. 現在のブランチを `origin` に push する。

## 実行コマンド

```bash
git push origin HEAD
```

## 完了確認

push 後に以下を確認する。

```bash
git status --short --branch
```
