# Vite ポート公開

## 確認した現在変更の概要

- devcontainer の compose 設定で Vite 開発サーバー用の `5173` ポートを公開する。
- `ports` の YAML インデントを既存構成に合わせて調整する。

## 対象ファイル

- `.devcontainer/compose.yaml`

## 検証内容

- `pnpm run build` 成功
  - Vite から 500 kB 超のチャンクサイズ警告が出るが、ビルドは成功。

## コミット予定内容

- devcontainer から Vite の `5173` ポートへアクセスできるようにする。
