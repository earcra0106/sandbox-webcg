# skill initializer write failure

## 発生日時

2026/05/20 15:49

## 分類

env

## 原因

旧カスタムコマンドから `.codex/skills/` へ移行するため、skill 作成用スクリプトで `.codex/skills/` 配下へのファイル生成を試みたが、実行環境では Python の利用やインストールが許可されていない。また、初回実行時に `.codex/skills/` の作成が読み取り専用ファイルシステムとして拒否された。

2026/05/20 15:52 には、`git commit` 実行時に `.git/index.lock` の作成が読み取り専用ファイルシステムとして拒否された。

## 解決方法

Python スクリプトによる自動生成を中止し、`.codex/skills/` 配下の `SKILL.md` と `agents/openai.yaml` を `apply_patch` で直接作成した。Git 操作で `.git/` への書き込みが必要な場合は、権限昇格で実行する。

## 代替案

今後この環境で skill を追加・更新する場合は、Python ベースの補助スクリプトに依存せず、既存 skill の構成を参考に手動で `SKILL.md` と必要最小限のメタデータを編集する。
