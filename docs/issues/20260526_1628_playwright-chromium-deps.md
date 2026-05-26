# Playwright Chromium dependencies

## タイトル

Playwright Chromium が共有ライブラリ不足と sandbox 制約で起動できなかった

## 発生日時

2026/05/26 16:28

## 分類

env

## 原因

Playwright の Chromium を初回実行した際、コンテナ内に `libnspr4.so` などの OS 依存ライブラリが不足していた。

依存ライブラリ導入後も、コンテナの sandbox 制約により Chromium が `sandbox_host_linux.cc` のエラーで終了した。

## 解決方法

`pnpm exec playwright install-deps chromium` を権限昇格して実行し、Chromium 実行に必要な OS 依存ライブラリを導入した。

検証時は Playwright の Chromium 起動に `chromiumSandbox: false` と sandbox 無効化オプションを指定した。

## 代替案

同じ制約が残る環境では、ユーザー側のブラウザで Vite 開発サーバーにアクセスして表示を確認する。
