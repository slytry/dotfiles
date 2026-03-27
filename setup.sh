#!/usr/bin/env bash

set -e

echo "⚙️ Running setup..."

# =========================
# Homebrew
# =========================
if ! command -v brew >/dev/null 2>&1; then
  echo "🍺 Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo "📦 Installing Brew packages..."
brew bundle || true

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