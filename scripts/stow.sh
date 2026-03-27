#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd -- "$SCRIPT_DIR/.." && pwd)"
STOW_DIR="$REPO_ROOT/stow"
DRY_RUN="${STOW_DRY_RUN:-0}"
BACKUP_ROOT="${STOW_BACKUP_ROOT:-$HOME/.dotfiles-backup}"
BACKUP_TIMESTAMP="$(date +"%Y%m%d-%H%M%S")-$$"
BACKUP_DIR="$BACKUP_ROOT/$BACKUP_TIMESTAMP"
BACKUP_DIR_READY=0
BACKUP_COUNT=0
PREFLIGHT_WARNING_COUNT=0
PREFLIGHT_WARNING_PACKAGES=()

echo "🔗 Applying dotfiles..."

if ! command -v stow >/dev/null 2>&1; then
  if command -v brew >/dev/null 2>&1; then
    echo "📦 stow not found, installing via brew..."
    brew install stow
  else
    echo "❌ stow is required, but Homebrew is not installed."
    echo "👉 Install Homebrew first (https://brew.sh), then rerun this script."
    exit 1
  fi
fi

if ! command -v stow >/dev/null 2>&1; then
  echo "❌ Failed to install stow. Install it manually and rerun the script."
  exit 1
fi

if [ ! -d "$STOW_DIR" ]; then
  echo "❌ Stow directory not found: $STOW_DIR"
  exit 1
fi

ensure_backup_dir() {
  if [ "$BACKUP_DIR_READY" = "1" ]; then
    return
  fi

  if [ "$DRY_RUN" = "1" ]; then
    echo "🔍 [dry-run] Would create backup dir: $BACKUP_DIR"
  else
    mkdir -p "$BACKUP_DIR"
    echo "💾 Backup dir: $BACKUP_DIR"
  fi

  BACKUP_DIR_READY=1
}

is_expected_target() {
  local target="$1"
  local source="$2"

  [ "$target" -ef "$source" ]
}

path_exists() {
  local path="$1"

  [ -e "$path" ] || [ -L "$path" ]
}

build_unique_backup_path() {
  local base_path="$1"
  local unique_path="$base_path"
  local duplicate_index=1

  while path_exists "$unique_path"; do
    unique_path="${base_path}.dup${duplicate_index}"
    duplicate_index=$((duplicate_index + 1))
  done

  printf '%s\n' "$unique_path"
}

backup_conflicting_target() {
  local target="$1"
  local rel_path="${target#$HOME/}"
  local backup_path_base="$BACKUP_DIR/$rel_path"
  local backup_path

  ensure_backup_dir
  backup_path="$(build_unique_backup_path "$backup_path_base")"

  if [ "$DRY_RUN" = "1" ]; then
    echo "🔍 [dry-run] Would move conflict to backup: $target -> $backup_path"
  else
    mkdir -p "$(dirname "$backup_path")"
    mv "$target" "$backup_path"
    echo "💾 Moved conflict to backup: $target -> $backup_path"
  fi

  BACKUP_COUNT=$((BACKUP_COUNT + 1))
}

run_stow_preflight() {
  local package="$1"

  echo "🧪 Preflight: stow --simulate for $package"
  if stow --simulate --dir "$STOW_DIR" --target "$HOME" --restow "$package"; then
    return 0
  fi

  echo "⚠️ Preflight reported issues for package '$package'."
  echo "↪️ Continuing: will try backup conflicting targets, then restow."
  PREFLIGHT_WARNING_COUNT=$((PREFLIGHT_WARNING_COUNT + 1))
  PREFLIGHT_WARNING_PACKAGES+=("$package")
  return 0
}

stow_with_backup() {
  local package="$1"
  local package_path="$STOW_DIR/$package"
  local rel
  local src
  local target

  run_stow_preflight "$package"

  echo "🔍 Scanning conflicts for $package..."

  while IFS= read -r src; do
    rel="${src#$package_path/}"
    target="$HOME/$rel"

    if ! path_exists "$target"; then
      continue
    fi

    if [ -d "$target" ]; then
      continue
    fi

    backup_conflicting_target "$target"
  done < <(find "$package_path" -mindepth 1 -type d)

  while IFS= read -r src; do
    rel="${src#$package_path/}"
    target="$HOME/$rel"

    if ! path_exists "$target"; then
      continue
    fi

    if is_expected_target "$target" "$src"; then
      echo "✅ Already managed: $target"
      continue
    fi

    backup_conflicting_target "$target"
  done < <(find "$package_path" -mindepth 1 ! -type d)

  if [ "$DRY_RUN" = "1" ]; then
    echo "🔍 [dry-run] Skipping apply step for package: $package"
    return
  fi

  stow --dir "$STOW_DIR" --target "$HOME" --restow "$package"
}

for package_dir in "$STOW_DIR"/*/; do
  [ -d "$package_dir" ] || continue
  package="$(basename "$package_dir")"
  stow_with_backup "$package"
done

if [ "$BACKUP_COUNT" -gt 0 ]; then
  if [ "$DRY_RUN" = "1" ]; then
    echo "🔍 [dry-run] Would backup $BACKUP_COUNT conflicting target(s) to $BACKUP_DIR"
  else
    echo "💾 Backed up $BACKUP_COUNT conflicting target(s) to $BACKUP_DIR"
  fi
fi

if [ "$DRY_RUN" = "1" ]; then
  echo "✅ Dotfiles dry-run complete"
else
  echo "✅ Dotfiles applied"
fi

if [ "$PREFLIGHT_WARNING_COUNT" -gt 0 ]; then
  echo "⚠️ Preflight had warnings for $PREFLIGHT_WARNING_COUNT package(s): ${PREFLIGHT_WARNING_PACKAGES[*]}"
fi
