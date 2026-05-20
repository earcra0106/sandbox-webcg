---
name: code-simple-change
description: 小さなコード変更を行う。ブランチ作成、タスクファイル作成、git add、コミットが不要な既存ファイルへの軽微で範囲が明確な修正で、ユーザーが code-simple-change や軽微なコード変更を指定したときに使う。
---

# Code Simple Change

以下の手順で、単純なコード変更を行う。

## 目的

ブランチ作成や `git add` を行わず、ユーザーに依頼された小さなコード変更だけを実施する。

## 適用条件

この skill は、以下をすべて満たす場合に使う。

- 変更範囲が明確で小さい。
- 既存ファイルへの軽微な修正である。
- ブランチ作成、タスクファイル作成、`git add`、コミットが不要であるとユーザーが明示または文脈上期待している。

## 禁止事項

```bash
git checkout -b <branch-name>
git add <changed-files>
git commit -m "<message>"
git push
```

## 実装ルール

- 既存の構成、命名、実装パターンを優先する。
- 依頼範囲外のリファクタリングは行わない。
- WebGPU を触る場合は `navigator.gpu` の存在確認と未対応時の表示を維持する。
- WebGL を触る場合は WebGL 2 優先の方針を維持する。

## 完了確認

必要最小限の検証を行う。実行できるテストや型チェックがある場合は、変更の規模に応じて実行する。

```bash
git diff
git status --short --branch
```
