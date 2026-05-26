# Vite dev server の host 公開設定

## 作業タイトル

Vite dev server の host 公開設定

## 確認した現在変更の概要

- `pnpm run dev` で起動する Vite dev server に `--host 0.0.0.0` を指定する。
- devcontainer 外からも Vite のポートへアクセスしやすくする。

## 対象ファイル

- `package.json`

## 検証内容

- `pnpm run dev` で Vite dev server が起動することを確認した。
- `curl -I http://127.0.0.1:5173/` で `HTTP/1.1 200 OK` が返ることを確認した。
- この環境ではポート待ち受けに sandbox 外権限が必要なため、権限昇格して検証した。

## コミット予定内容

- `dev` スクリプトを `vite --host 0.0.0.0` に変更する。
