# Git ブランチ作成失敗

## 発生日時

2026/05/20 14:40

## 分類

env

## 内容

`AGENTS.md` の作業ルールに従って `git checkout -b refactor/split-project-spec-docs` を実行したところ、`.git/HEAD.lock` を作成できず失敗した。

## 原因

`.git` 配下が現在の実行環境から書き込みできない状態だったため、Git のブランチ切り替えに必要なロックファイルを作成できなかった。

## 解決方法

この作業では Git ブランチの作成は行わず、ワークツリー内のドキュメント更新のみ実施した。

## 代替案

Git 操作が必要な場合は、`.git` 配下へ書き込み可能な環境で以下を実行する。

```bash
git checkout -b refactor/split-project-spec-docs
```

