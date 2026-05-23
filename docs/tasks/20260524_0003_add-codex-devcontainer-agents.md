# add-codex-devcontainer-agents

## 作業タイトル

env/add-codex-devcontainer-agents

## 作業の目的と概要

devcontainer 内で動く Codex に開発環境の前提を伝えるため、コンテナ起動時に `/home/node/.codex/AGENTS.md` へ環境情報を追記する。

## 作成・編集するファイルのスコープ

- `.devcontainer/entrypoint.sh`
- `docs/tasks/20260524_0003_add-codex-devcontainer-agents.md`

## 実装するモジュールの概要

- `/home/node/.codex/AGENTS.md` を作成または更新する。
- devcontainer 内であることを記載する。
- Node.js と pnpm のバージョンを記載する。
- パッケージ操作では npm ではなく pnpm を使うことを記載する。
- entrypoint の再実行で同じ内容が重複しないよう、管理ブロックを差し替える。

## アクセス方法・操作説明

VS Code の Dev Containers 拡張機能からコンテナを起動すると、entrypoint により Codex 用の `/home/node/.codex/AGENTS.md` が更新される。
