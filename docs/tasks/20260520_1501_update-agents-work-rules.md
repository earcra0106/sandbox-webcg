# refactor/update-agents-work-rules

## 作業の目的と概要

`AGENTS.md` の作業ルールについて、ドキュメント更新にも適用しやすい表現へ改善する。

## 作業方針

- 「実装中」の表現を「作業中」に変更する。
- タスクファイル名に使う日時コマンドを、ファイル名形式へ直接対応する `date +"%Y%m%d_%H%M"` に修正する。
- ブランチ作成に失敗した場合の例外規定を追加する。
- issue レポートの発生日時に使うコマンドを明記する。

## 作成・編集するファイルのスコープ

- `AGENTS.md`
- `docs/tasks/20260520_1501_update-agents-work-rules.md`

## Git 作業メモ

- 想定ブランチ名: `refactor/update-agents-work-rules`
- 作業開始時のブランチ: `main`
- この環境では既に `.git/HEAD.lock` を作成できないことを確認済みのため、ブランチ作成は行わず文書更新のみ実施する。
- 関連 issue: `docs/issues/20260520_1440_git-branch-creation-failed.md`
