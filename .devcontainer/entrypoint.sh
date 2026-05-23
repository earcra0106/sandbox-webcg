#!/usr/bin/env sh
set -eu

PNPM_VERSION="${PNPM_VERSION:-11.1.1}"
CODEX_PACKAGE="${CODEX_PACKAGE:-@openai/codex}"
CODEX_CONFIG_DIR="${CODEX_CONFIG_DIR:-/home/node/.codex}"
CODEX_CONFIG_FILE="$CODEX_CONFIG_DIR/config.toml"

export PNPM_HOME="${PNPM_HOME:-/usr/local/share/pnpm}"
export PATH="$PNPM_HOME:$PATH"

mkdir -p "$PNPM_HOME"
mkdir -p "$CODEX_CONFIG_DIR"

if [ ! -f "$CODEX_CONFIG_FILE" ]; then
  touch "$CODEX_CONFIG_FILE"
fi

if grep -q '^preferred_auth_method[[:space:]]*=' "$CODEX_CONFIG_FILE"; then
  sed -i 's/^preferred_auth_method[[:space:]]*=.*/preferred_auth_method = "apikey"/' "$CODEX_CONFIG_FILE"
else
  printf '\npreferred_auth_method = "apikey"\n' >> "$CODEX_CONFIG_FILE"
fi

if [ "$(id -u)" = "0" ] && id node >/dev/null 2>&1; then
  chown -R node:node "$CODEX_CONFIG_DIR"
fi

if ! command -v pnpm >/dev/null 2>&1 || [ "$(pnpm --version)" != "$PNPM_VERSION" ]; then
  npm install -g "pnpm@$PNPM_VERSION"
fi

pnpm config set global-bin-dir "$PNPM_HOME"

if ! command -v codex >/dev/null 2>&1; then
  pnpm add -g "$CODEX_PACKAGE"
fi

exec "$@"
