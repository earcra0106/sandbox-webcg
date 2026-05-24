#!/usr/bin/env sh
set -eu

if ! ssh-add -l >/dev/null; then
    echo "SSH Agent の登録が確認できませんでした。" >&2
fi

if [ -z "$SSH_AUTH_SOCK" ]; then
    echo "SSH_AUTH_SOCK がホストマシンに設定されていません。" >&2
    exit 1
fi

if command -v gh >/dev/null; then
    gh auth token | xargs -I {} echo "GH_TOKEN="{} > .devcontainer/.env.devcontainer
fi
