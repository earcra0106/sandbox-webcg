---
name: done
description: 作業完了後に main ブランチへ戻して最新化する。ユーザーが done、完了後の main 最新化、作業終了後の同期を指定したときに使う。
---

# Done

以下のコマンドを実行して、`main` ブランチを最新の状態に更新する。

```bash
git branch --show-current
git checkout main
git pull origin main
```
