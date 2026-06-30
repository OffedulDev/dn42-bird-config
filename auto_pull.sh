#!/usr/bin/env bash
set -euo pipefail

# Configuration
TARGET_DIR="/etc/bird/kit"
REPO_URL="https://github.com/OffedulDev/dn42-bird-config"

# Ensure the parent directory exists
mkdir -p /etc/bird

if [ ! -d "$TARGET_DIR" ]; then
    echo "Directory $TARGET_DIR does not exist. Cloning repository..."
    # --quiet suppresses output, GIT_TERMINAL_PROMPT=0 prevents hanging on auth prompts
    GIT_TERMINAL_PROMPT=0 git clone --quiet "$REPO_URL" "$TARGET_DIR"
else
    echo "Directory $TARGET_DIR exists. Updating repository..."
    # Move into the directory to execute git commands
    cd "$TARGET_DIR"
    
    # Fetch and pull headlessly, automatically merging if fast-forward is possible
    GIT_TERMINAL_PROMPT=0 git fetch --quiet
    GIT_TERMINAL_PROMPT=0 git pull --quiet --ff-only
fi

echo "Sync completed successfully."
