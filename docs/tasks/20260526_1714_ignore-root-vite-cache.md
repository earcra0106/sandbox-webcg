# ルート .vite キャッシュの除外

## 確認した現在変更の概要

- プロジェクトルート直下に生成された未追跡の `.vite/` キャッシュを削除した。
- 再発時に Git の未追跡として残らないよう、`.gitignore` に `.vite/` を追加した。
- ルート `.vite/` 生成原因の調査記録を `docs/issues/` に追加済み。

## 対象ファイル

- `.gitignore`
- `docs/issues/20260526_1712_root-vite-cache-investigation.md`

## 検証内容

- `pnpm run build` 成功
  - Vite から 500 kB 超のチャンクサイズ警告が出るが、ビルドは成功。

## コミット予定内容

- ルート `.vite/` キャッシュを Git 管理対象外にする。
- `.vite/` 生成原因の調査記録を残す。
