#!/usr/bin/env sh
set -eu

# Install UV if not present
if ! command -v uv >/dev/null 2>&1; then
    printf '%s\n' "UV package manager not found. Installing UV..."
    if command -v curl >/dev/null 2>&1; then
        curl -fsSL https://astral.sh/uv/install.sh | sh
    fi

    # Add uv install location to PATH for this session
    PATH="$PATH:$HOME/.local/bin"
    export PATH
fi

# Change to the script directory
SCRIPT_DIR="$(cd "$(dirname "$0")" >/dev/null 2>&1 && pwd)"
cd "$SCRIPT_DIR" || exit 1

# Derive python script name from this script's filename (replace extension with .py)
BASE="$(basename "$0")"
SCRIPTNAME="${BASE%.*}.py"

uv run "$SCRIPTNAME"

# Pause (wait for Enter)
printf 'Press Enter to continue...'
# POSIX-safe read
{ IFS= read -r _; } || true
