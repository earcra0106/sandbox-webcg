# skill directory write failure

- 発生日時: 2026/05/23 16:49
- 分類: env
- タイトル: skill directory write failure

## 内容

`.codex/skills/branch-work/agents` と `.codex/skills/current-branch-push/agents` を作成するために `mkdir -p` を実行したところ、以下のエラーでディレクトリを作成できなかった。

```text
mkdir: cannot create directory '.codex/skills/branch-work': Read-only file system
mkdir: cannot create directory '.codex/skills/current-branch-push': Read-only file system
```

## 原因

`.codex/skills/` 配下へのディレクトリ作成が実行環境で読み取り専用ファイルシステムとして拒否された。

## 解決方法

通常権限で同じ操作を繰り返さず、権限昇格でディレクトリ作成とファイル追加を行う。

## 代替案

権限昇格でも失敗する場合は、ユーザー側で `.codex/skills/` 配下へ skill ディレクトリを作成してから作業を継続する。
