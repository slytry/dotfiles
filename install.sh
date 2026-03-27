#!/usr/bin/env bash

set -e

DOTFILES_DIR="$HOME/.dotfiles"

echo "🚀 Installing dotfiles..."

# Клонирование (если нет)
if [ ! -d "$DOTFILES_DIR" ]; then
  git clone https://github.com/slytry/dotfiles.git "$DOTFILES_DIR"
fi

cd "$DOTFILES_DIR"

# Запуск setup
bash setup.sh

# Применение dotfiles
bash stow.sh

echo "✅ Done! Restart your shell."