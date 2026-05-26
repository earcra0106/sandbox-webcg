# add-commit-current-changes-skill

## 作業タイトル

現在の変更を確認してコミットする skill の追加

## 確認した現在変更の概要

`.codex/skills/commit-current-changes/` に、既存の未コミット変更を確認して作業ブランチ作成、タスク記録、検証、ステージ、コミットまで行う skill が追加されている。

## 対象ファイル

- `.codex/skills/commit-current-changes/SKILL.md`
- `.codex/skills/commit-current-changes/agents/openai.yaml`

## 検証内容

- skill ディレクトリに必要ファイルが存在することを確認する。
- `SKILL.md` の frontmatter に `name` と `description` があることを確認する。
- `agents/openai.yaml` に UI メタデータがあることを確認する。

## コミット予定内容

追加した `commit-current-changes` skill と作業記録のみをコミットする。既存の `.devcontainer/` 変更、`AGENTS.md` 変更、`dist/`、`node_modules/` は対象外とする。
