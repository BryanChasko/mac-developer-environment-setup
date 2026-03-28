#!/usr/bin/env bash
# install-haunting-terminal.sh
# Adds Ghostty, bottom, and zellij to an existing setup (see macOS-dev-setup.md).
# Run from the repo root after cloning.
set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"

# --- Install new tools ---
brew install --cask ghostty
brew install bottom zellij  # 'bottom' provides the btm binary

# --- Ghostty base config ---
mkdir -p ~/.config/ghostty
cp "$REPO_DIR/ghostty-config" ~/.config/ghostty/config
echo "Ghostty base config installed."

# --- Ghostty workload profiles ---
mkdir -p ~/.config/ghostty/profiles
cp "$REPO_DIR/ghostty-profiles/"*.conf ~/.config/ghostty/profiles/
echo "Ghostty workload profiles installed: inference, aws, otel, ssh-rocm, chrome-ext, mcp-forge"

# --- Starship config ---
mkdir -p ~/.config
cp "$REPO_DIR/starship-copy.toml" ~/.config/starship.toml
echo "Starship config installed."

# --- SSH config (non-destructive) ---
if [ ! -f ~/.ssh/config ]; then
  mkdir -p ~/.ssh && chmod 700 ~/.ssh
  cp "$REPO_DIR/ssh-config-template" ~/.ssh/config
  chmod 600 ~/.ssh/config
  echo "SSH config installed — edit ~/.ssh/config with your host details."
else
  echo "~/.ssh/config already exists — see ssh-config-template for reference."
fi

echo "Done. Open Ghostty and run: source ~/.zshrc"
echo "Workload aliases: gt-inference | gt-aws | gt-otel | gt-rocm | gt-ext | gt-forge"
