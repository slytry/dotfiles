#!/usr/bin/env bash

set -e

echo "🔗 Applying dotfiles..."

if ! command -v stow >/dev/null 2>&1; then
  echo "📦 Installing stow..."
  brew install stow
fi

cd "$(dirname "$0")"

stow_with_force() {
  package="$1"

  echo "🧹 Nuking targets for $package..."

  find "$package" -type f | while read -r src; do
    rel="${src#$package/}"
    target="$HOME/$rel"

    rm -rf "$target"
  done

  stow "$package"
}

stow_with_force zsh
stow_with_force git
stow_with_force ghostty
stow_with_force fnm
stow_with_force opencode
stow_with_force opencode-profiles

echo "✅ Dotfiles applied"