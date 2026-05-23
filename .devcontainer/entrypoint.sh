#!/usr/bin/env sh
set -eu

PNPM_VERSION="${PNPM_VERSION:-11.1.1}"
CODEX_PACKAGE="${CODEX_PACKAGE:-@openai/codex}"
CODEX_CONFIG_FILE="/home/node/.codex/config.toml"

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

if [ ! -f "$CODEX_CONFIG_FILE" ]; then
  touch "$CODEX_CONFIG_FILE"
fi

if grep -q '^preferred_auth_method[[:space:]]*=' "$CODEX_CONFIG_FILE"; then
  sed -i 's/^preferred_auth_method[[:space:]]*=.*/preferred_auth_method = "apikey"/' "$CODEX_CONFIG_FILE"
else
  printf '\npreferred_auth_method = "apikey"\n' >> "$CODEX_CONFIG_FILE"
fi

chown -R node:node /home/node/.ssh /home/node/.codex
chmod 700 /home/node/.ssh

ssh_auth_sock_path="/home/node/.ssh/ssh_auth_sock"
rm -f "$ssh_auth_sock_path"

host_ssh_auth_sock=""
if [ -n "${HOST_SSH_AUTH_SOCK:-}" ]; then
  case "$HOST_SSH_AUTH_SOCK" in
    /tmp/*)
      host_ssh_auth_sock="/host_tmp/${HOST_SSH_AUTH_SOCK#/tmp/}"
      ;;
  esac
fi

if [ -n "$host_ssh_auth_sock" ] && [ -S "$host_ssh_auth_sock" ]; then
  ln -s "$host_ssh_auth_sock" "$ssh_auth_sock_path"
  chown -h node:node "$ssh_auth_sock_path"
fi

exec "$@"
