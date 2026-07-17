#!/usr/bin/env bash
# List files changed since the last OpenWiki sync commit recorded in openwiki/_meta.md.
# Usage:
#   scripts/changed-files.sh                 # since last_sync_commit (fallback: HEAD~20)
#   scripts/changed-files.sh <base-sha>      # since explicit commit
#   scripts/changed-files.sh --stat          # include diffstat

set -euo pipefail

STAT=0
BASE=""

for arg in "$@"; do
  case "$arg" in
    --stat) STAT=1 ;;
    -*) echo "Unknown flag: $arg" >&2; exit 2 ;;
    *) BASE="$arg" ;;
  esac
done

ROOT="$(git rev-parse --show-toplevel 2>/dev/null || true)"
if [[ -z "$ROOT" ]]; then
  echo "Not inside a git repository" >&2
  exit 1
fi
cd "$ROOT"

META="openwiki/_meta.md"
if [[ -z "$BASE" && -f "$META" ]]; then
  BASE="$(grep -E '^[[:space:]]*-[[:space:]]*last_sync_commit:' "$META" | head -1 | sed -E 's/.*last_sync_commit:[[:space:]]*//' | tr -d '`' | tr -d '\r')"
  if [[ "$BASE" == "unknown" || "$BASE" == "" ]]; then
    BASE=""
  fi
fi

if [[ -z "$BASE" ]]; then
  if git rev-parse --verify HEAD~20 >/dev/null 2>&1; then
    BASE="$(git rev-parse HEAD~20)"
    echo "# fallback_base=$BASE (no last_sync_commit; using HEAD~20)" >&2
  else
    BASE="$(git rev-parse --keep-empty HEAD 2>/dev/null || git rev-parse HEAD)"
    echo "# fallback_base=$BASE (shallow history)" >&2
  fi
fi

if ! git cat-file -e "${BASE}^{commit}" 2>/dev/null; then
  echo "Base commit not found: $BASE" >&2
  exit 1
fi

echo "# base=$BASE"
echo "# head=$(git rev-parse HEAD)"

if [[ "$STAT" -eq 1 ]]; then
  git diff --stat "${BASE}...HEAD"
  echo "----"
fi

git diff --name-only "${BASE}...HEAD"
