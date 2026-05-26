# pnpm ignored builds

## タイトル

pnpm install 時に esbuild の build script 承認が必要になった

## 発生日時

2026/05/26 16:23

## 分類

build

## 原因

pnpm 11 の build script 承認機構により、`esbuild` の install script が初回インストール時に保留され、`pnpm install` が失敗扱いになった。

また、通常権限では pnpm の store index 用 SQLite DB を開けず、通常権限での `pnpm install` と `pnpm approve-builds --all` が失敗した。

## 解決方法

権限昇格したうえで `pnpm install` を実行し、依存関係を取得した。

その後、`pnpm approve-builds --all` を権限昇格して実行し、`pnpm-workspace.yaml` に `esbuild` の build script 承認を記録した。

## 代替案

同じエラーが再発する場合は、ユーザー側で `pnpm install` と `pnpm approve-builds --all` を実行する。
