#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
LOCAL_DOTFILES_DIR="$(cd -- "$SCRIPT_DIR/.." && pwd)"
DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"

echo "🚀 Installing dotfiles..."

if [ -d "$LOCAL_DOTFILES_DIR/.git" ]; then
  DOTFILES_DIR="$LOCAL_DOTFILES_DIR"
fi

# Клонирование (если нет)
if [ ! -d "$DOTFILES_DIR/.git" ]; then
  git clone https://github.com/slytry/dotfiles.git "$DOTFILES_DIR"
fi

# Запуск setup
bash "$DOTFILES_DIR/scripts/setup.sh"

# Применение dotfiles
bash "$DOTFILES_DIR/scripts/stow.sh"

echo "✅ Done! Restart your shell."
