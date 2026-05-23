# add-branch-operation-skills

## 作業タイトル

feature/add-branch-operation-skills

## 作業の目的と概要

現在のブランチ上で追加作業を行いコミットする skill と、現在のブランチをリモートへ push する skill を追加する。

## 作成・編集するファイルのスコープ

- `.codex/skills/branch-work/SKILL.md`
- `.codex/skills/branch-work/agents/openai.yaml`
- `.codex/skills/current-branch-push/SKILL.md`
- `.codex/skills/current-branch-push/agents/openai.yaml`

## 実装するモジュールの概要

- `branch-work`: 既存ブランチ上で作業、検証、ステージ、コミットを行うための手順を定義する。
- `current-branch-push`: 現在のブランチを `origin` へ push するための手順を定義する。

## アクセス方法・操作説明

Codex で `$branch-work` または `$current-branch-push` を指定して使用する。
