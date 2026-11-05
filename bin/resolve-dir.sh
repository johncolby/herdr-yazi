#!/usr/bin/env bash
set -euo pipefail

if [ -n "${1:-}" ]; then
  printf '%s\n' "$1"
  exit 0
fi
if [ -n "${HERDR_EXPLORER_DIR:-}" ]; then
  printf '%s\n' "$HERDR_EXPLORER_DIR"
  exit 0
fi
if [ -n "${HERDR_PLUGIN_CONTEXT_JSON:-}" ]; then
  DIR="$(jq -r 'first(.focused_pane_cwd, .workspace_cwd | strings | select(length > 0))' \
    <<<"$HERDR_PLUGIN_CONTEXT_JSON" 2>/dev/null || true)"
  if [ -n "$DIR" ]; then
    printf '%s\n' "$DIR"
    exit 0
  fi
fi
pwd
