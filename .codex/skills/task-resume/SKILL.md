---
name: task-resume
description: temp/task.md を読み込んで前回の作業状況を把握し、続きから作業を再開する。他の skill と組み合わせて使うことを前提とし、ユーザーが「続きから」「前回の続き」「temp/task.md を読んで再開」などを求めたときに使う。
---

# Task Resume

`temp/task.md` を作業再開用メモとして読み込み、現在の依頼と組み合わせて続きを進める。

## 前提

この skill は単独の実装方針ではなく、`$docs-update`、`$code-implementation`、`$docs-simple-change`、`$code-simple-change` など他の skill と併用する。

## 手順

1. `temp/task.md` が存在するか確認する。
2. 存在する場合は内容を読み、前回の作業目的、実施済み事項、未実施事項、除外対象を把握する。
3. 存在しない場合は、再開用メモがないことをユーザーに短く伝え、現在の依頼から作業を進める。
4. `git status --short --branch` を確認し、メモの内容と現在のワークツリーが矛盾していないか確認する。
5. 併用する skill の手順に従って作業を続ける。

## 判断ルール

- 最新のユーザー依頼を優先する。`temp/task.md` の内容が古い、または依頼と矛盾する場合は、矛盾点を短く説明して最新依頼に従う。
- `temp/task.md` に「コミット対象から外す」と記載されたファイルは、ユーザーが明示しない限り `git add` しない。
- `temp/` が `.gitignore` されている場合、`temp/task.md` をコミット対象にしない。
- 作業完了時に再開用メモを更新する必要がある場合は、`$task-progress` を併用する。
