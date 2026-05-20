# 作業タイトル

docs/add-task-resume-skills

## 作業の目的と概要

作業途中の進行状況を `temp/task.md` に記録する skill と、`temp/task.md` を読み込んで続きから作業を再開する skill を追加する。

あわせて、再開用メモを置く `temp/` フォルダを Git 管理対象外にする。

## 作成・編集するファイルのスコープ

- `.codex/skills/` 配下に進行状況記録用 skill を追加する。
- `.codex/skills/` 配下に続きから開始するための skill を追加する。
- `.gitignore` を追加または更新し、`temp/` を ignore する。
- `docs/tasks/` に本作業記録を追加する。

## 実装する関数、クラス、モジュールの概要

ドキュメントおよび Codex skill の追加のみ。アプリケーションコードの関数、クラス、モジュールは追加しない。

## アクセス方法や UI 操作

UI 変更なし。
