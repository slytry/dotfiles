#!/usr/bin/env bash

set -e

echo "🔗 Applying dotfiles..."

if ! command -v stow >/dev/null 2>&1; then
  echo "📦 Installing stow..."
  brew install stow
fi

cd "$(dirname "$0")"

stow zsh
stow git
stow ghostty
stow fnm
stow opencode
stow opencode-profiles

echo "✅ Dotfiles applied"