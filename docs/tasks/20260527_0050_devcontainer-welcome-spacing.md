# devcontainer welcome spacing

## 作業タイトル

env/devcontainer-welcome-spacing

## 作業の目的と概要

Devcontainer 起動時に表示される welcome メッセージの前に空行を追加し、シェル開始直後の表示を読みやすくする。

## 作成・編集するファイルのスコープ

- `.devcontainer/Dockerfile`
- `docs/tasks/20260527_0050_devcontainer-welcome-spacing.md`

## 実装する関数、クラス、モジュールの概要

関数、クラス、モジュールの追加は行わない。bash 起動時に実行される welcome 表示用の `echo` 内容だけを調整する。

## アクセス方法や UI 操作

Devcontainer を起動し、ターミナルを開くと welcome メッセージの表示を確認できる。
