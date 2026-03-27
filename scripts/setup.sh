#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd -- "$SCRIPT_DIR/.." && pwd)"
BREWFILE_PATH="$REPO_ROOT/Brewfile"

echo "⚙️ Running setup..."

# =========================
# Homebrew
# =========================
if ! command -v brew >/dev/null 2>&1; then
  echo "🍺 Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo "📦 Installing Brew packages..."
if [ -f "$BREWFILE_PATH" ]; then
  brew bundle --file="$BREWFILE_PATH" || true
else
  echo "⚠️ Brewfile not found at $BREWFILE_PATH"
fi

# =========================
# fnm
# =========================
if ! command -v fnm >/dev/null 2>&1; then
  brew install fnm
fi

# =========================
# zinit
# =========================
if [ ! -d "$HOME/.zinit" ]; then
  echo "🧩 Installing zinit..."
  git clone https://github.com/zdharma-continuum/zinit.git ~/.zinit/bin
fi

# =========================
# directories
# =========================
mkdir -p \
  ~/.config/opencode \
  ~/.config/opencode-profiles \
  ~/.local/bin \
  ~/.opencode/bin \
  ~/bin

echo "✅ Setup complete"
