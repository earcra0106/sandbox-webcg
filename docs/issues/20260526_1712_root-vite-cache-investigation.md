# プロジェクトルート直下の .vite 生成調査

- 発生日時: 2026/05/26 17:12
- 分類: env

## 調査対象

`git status` で未追跡の `.vite/` がプロジェクトルート直下に作成されていることを確認した。

## 調査内容

### vite.config.ts の cacheDir 指定

- `vite.config.ts` には `cacheDir` 指定はない。
- `vitest.config.ts` にも `cacheDir` 指定はない。
- `rg -n --hidden "cacheDir|\\.vite|VITE_|VITEST|NODE_OPTIONS|--host|5173" . -g '!.git/*' -g '!node_modules/*' -g '!.vite/*'` で確認した範囲では、ルート `.vite/` を明示する設定は見つからなかった。

### 環境変数や起動オプション

- 環境変数には `VITE_*`、`VITEST_*`、`NODE_OPTIONS` などキャッシュ先を変える値は見つからなかった。
- 起動に使った `pnpm exec vite --host 0.0.0.0` は `cacheDir` を変更しない。
- `node --input-type=module -e "import { resolveConfig } from 'vite'; const c = await resolveConfig({}, 'serve'); console.log(c.cacheDir);"` で確認した現在の解決結果は `/workspaces/sandbox-webcg/node_modules/.vite` だった。

### 他ツールによる生成の可能性

- ルート `.vite/deps/` には `package.json` と `_metadata.json` のみがあり、内容は Vite の依存関係最適化キャッシュ形式だった。
- `node_modules/.vite/deps/` には通常の Vite キャッシュが存在している。
- Vite 本体の実装では、`cacheDir` 未指定時に `package.json` を見つけられる場合は `<package-root>/node_modules/.vite`、見つけられない場合は `<root>/.vite` を使う。

## 推定原因

Vite 開発サーバーを起動したまま `main` に切り替えた時点で、当時の `main` には Vite アプリ一式と `package.json` がまだ取り込まれていなかった。そのため、稼働中の Vite がプロジェクトルートから `package.json` を見つけられず、既定値のフォールバックとして `.vite/` をルート直下に作成した可能性が高い。

## 解決方法

- ルート `.vite/` はキャッシュ生成物であり、リポジトリ管理対象にしない。
- 不要であれば削除してよい。
- 再発を避けるには、Vite 開発サーバーを停止してから、Vite アプリが存在しないブランチへ切り替える。

## 代替案

同様の未追跡キャッシュが再発する場合は、`.gitignore` に `.vite/` を追加する。ただし通常の Vite キャッシュは `node_modules/.vite/` に作成されるため、現時点では必須ではない。
