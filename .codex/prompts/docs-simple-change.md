# docs-simple-change

以下の手順で、単純なドキュメント変更を行ってください。

## 目的

ブランチ作成や `git add` を行わず、ユーザーに依頼された小さなドキュメント変更だけを実施します。

## 適用条件

このコマンドは、以下をすべて満たす場合に使ってください。

- 変更対象がドキュメントのみである。
- 変更が単純な文言修正、追記、整理である。
- ブランチ作成、タスクファイル作成、`git add`、コミットが不要であるとユーザーが明示または文脈上期待している。

## 禁止事項

```bash
git checkout -b <branch-name>
git add <changed-files>
git commit -m "<message>"
git push
```

## 更新ルール

- 依頼されたファイルだけを編集してください。
- 追加の仕様整理が必要な場合は、`docs/PROJECT_SPEC.md` を目次として扱い、詳細は `docs/specs/` に分割してください。
- 各コマンドでしか使わないルールは `AGENTS.md` に追記せず、該当する `.codex/prompts/*.md` に記載してください。

## 完了確認

```bash
git diff
git status --short --branch
```

