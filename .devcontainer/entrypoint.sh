#!/usr/bin/env sh
set -eu

PNPM_VERSION="${PNPM_VERSION:-11.1.1}"
CODEX_PACKAGE="${CODEX_PACKAGE:-@openai/codex}"
CODEX_AGENTS_FILE="/home/node/.codex/AGENTS.md"

export PNPM_HOME="${PNPM_HOME:-/usr/local/share/pnpm}"
export PATH="$PNPM_HOME:$PATH"

mkdir -p "$PNPM_HOME"

if ! command -v pnpm >/dev/null 2>&1 || [ "$(pnpm --version)" != "$PNPM_VERSION" ]; then
  npm install -g "pnpm@$PNPM_VERSION"
fi

pnpm config set global-bin-dir "$PNPM_HOME"

if ! command -v codex >/dev/null 2>&1; then
  pnpm add -g "$CODEX_PACKAGE"
fi

mkdir -p /home/node/.ssh /home/node/.codex

if [ -f /host_config/.ssh/known_hosts ]; then
  cp /host_config/.ssh/known_hosts /home/node/.ssh/known_hosts
  chown node:node /home/node/.ssh/known_hosts
  chmod 644 /home/node/.ssh/known_hosts
fi

if [ -f /host_config/.ssh/config ]; then
  cp /host_config/.ssh/config /home/node/.ssh/config
  chown node:node /home/node/.ssh/config
  chmod 600 /home/node/.ssh/config
fi

if [ -f /host_config/.gitconfig ]; then
  cp /host_config/.gitconfig /home/node/.gitconfig
  chown node:node /home/node/.gitconfig
  chmod 644 /home/node/.gitconfig
fi

if [ -d /host_config/.codex ]; then
  cp -R /host_config/.codex/. /home/node/.codex/
fi

node_version="$(node --version)"
pnpm_version="$(pnpm --version)"

if [ ! -f "$CODEX_AGENTS_FILE" ]; then
  touch "$CODEX_AGENTS_FILE"
fi

sed -i '/^<!-- devcontainer-env:start -->$/,/^<!-- devcontainer-env:end -->$/d' "$CODEX_AGENTS_FILE"
cat <<EOF >> "$CODEX_AGENTS_FILE"

<!-- devcontainer-env:start -->
## Devcontainer Environment

- この Codex セッションはプロジェクトの devcontainer 内で実行されています。
- Node.js バージョン: $node_version
- pnpm バージョン: $pnpm_version
- パッケージ管理には pnpm を使用してください。プロジェクト依存関係の追加・更新に npm を使用してはいけません。
<!-- devcontainer-env:end -->
EOF

chown -R node:node /home/node/.ssh /home/node/.codex
chmod 700 /home/node/.ssh

ssh_auth_sock_path="/home/node/.ssh/ssh_auth.sock"
rm -f "$ssh_auth_sock_path"

if [ ! -S /host_config/ssh_auth.sock ]; then
  echo "SSH agent socket is not mounted at /host_config/ssh_auth.sock." >&2
  exit 1
fi

ln -s /host_config/ssh_auth.sock "$ssh_auth_sock_path"
chown -h node:node "$ssh_auth_sock_path"

exec "$@"
