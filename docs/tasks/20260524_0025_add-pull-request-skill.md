# add-pull-request-skill

## 作業タイトル

feature/add-pull-request-skill

## 作業の目的と概要

`gh` コマンドで GitHub のプルリクエストを作成できるようになったため、PR 作成手順を `.codex/skills/` の skill として追加する。

## 作成・編集するファイルのスコープ

- `.codex/skills/pull-request/SKILL.md`
- `.codex/skills/pull-request/agents/openai.yaml`
- `docs/tasks/20260524_0025_add-pull-request-skill.md`

## 実装するモジュールの概要

- 特にブランチ指定がなければ現在のブランチの PR を作成する。
- ブランチ指定がある場合は、そのブランチを head として PR を作成する。
- `gh pr create --title ... --body ... --base main --head ...` を使う。
- PR タイトルは日本語で分かりやすく書く。
- PR 説明文は `目的`、`概要`、任意の `補足` のフォーマットで作成する。

## アクセス方法・操作説明

ユーザーが `$pull-request` または PR 作成を明示したときに、この skill を使って GitHub のプルリクエストを作成する。
