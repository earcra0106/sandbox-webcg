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

exec "$@"
