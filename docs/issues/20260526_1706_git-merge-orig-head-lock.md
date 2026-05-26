# git merge の ORIG_HEAD lock 作成失敗

- 発生日時: 2026/05/26 17:06
- 分類: env

## 原因

通常権限で `git merge env/expose-vite-port --no-edit` を実行した際、`.git/ORIG_HEAD.lock` を作成できず、読み取り専用ファイルシステムとして拒否された。

## 解決方法

AGENTS.md の既知の環境制約に従い、同じ通常権限コマンドを繰り返さず、権限昇格で `git merge env/expose-vite-port --no-edit` を再実行した。

## 結果

権限昇格後のマージは fast-forward で成功した。
