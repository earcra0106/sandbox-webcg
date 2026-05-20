---
name: docs-update
description: 通常のドキュメント更新作業を行う。ブランチ作成、タスク記録、ファイル編集、git add、コミットまでを含む docs 更新で、ユーザーが docs-update や通常のドキュメント更新を指定したときに使う。
---

# Docs Update

以下の手順で、ドキュメント更新作業を行う。

## 目的

ブランチ作成、タスク記録、ファイル編集、`git add`、コミットまでを含む通常のドキュメント更新を行う。

## 前提

作業前に `$requirements` を使い、作業ブランチと `docs/tasks/` の記録を作成する。

## 更新ルール

- 実行環境に関する情報提供があった場合は、`docs/specs/` に記載する。
- 環境構築中にインストールした主要パッケージは、`docs/specs/` に記載する。
- トークンの肥大化を避けるため、各パッケージごとに記載ファイルを分割する。
- `docs/PROJECT_SPEC.md` は `docs/specs/` 配下の目次として更新する。
- 各 skill でしか使わないルールは `AGENTS.md` に追記せず、該当する `.codex/skills/<skill-name>/SKILL.md` に記載する。

## 完了手順

変更内容を確認し、適切な単位でステージしてコミットする。

```bash
git status --short --branch
git diff
git add <changed-files>
git commit -m "<変更内容がわかる具体的な日本語メッセージ>"
```

`git push` などのリモート操作は、ユーザーが明示的に許可または依頼した場合のみ行う。
