#!/usr/bin/env sh
set -eu

PNPM_VERSION="${PNPM_VERSION:-11.1.1}"
CODEX_PACKAGE="${CODEX_PACKAGE:-@openai/codex}"

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

if [ -d /host_config/.codex ]; then
  cp -R /host_config/.codex/. /home/node/.codex/
fi

if [ -S /host_config/ssh_auth_sock ]; then
  ssh_auth_sock_filename="$(basename "${HOST_SSH_AUTH_SOCK:-ssh_auth_sock}")"
  ssh_auth_sock_path="/home/node/.ssh/$ssh_auth_sock_filename"

  rm -f "$ssh_auth_sock_path"
  ln -s /host_config/ssh_auth_sock "$ssh_auth_sock_path"
  chown -h node:node "$ssh_auth_sock_path"

  export SSH_AUTH_SOCK="$ssh_auth_sock_path"
  printf 'export SSH_AUTH_SOCK=%s\n' "$ssh_auth_sock_path" > /etc/profile.d/devcontainer-ssh-auth-sock.sh
fi

exec "$@"
