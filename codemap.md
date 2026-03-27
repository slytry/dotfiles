# Repository Atlas: .dotfiles

## Project Responsibility
Provides a reproducible macOS developer environment through declarative shell/git settings, package manifests, and bootstrap automation scripts.

## System Entry Points
- `install.sh`: One-shot bootstrap script for new machines (clone + setup + apply links).
- `setup.sh`: Dependency provisioning (Homebrew, `fnm`, `zinit`, config directories).
- `stow.sh`: Idempotent symlink deployment for managed packages.
- `Brewfile`: Package dependency manifest for CLI tooling.
- `apple.sh`: macOS defaults customization script.

## Design
- Uses the Configuration-as-Code pattern: each package directory mirrors `$HOME` structure for GNU Stow.
- Bootstrapping is staged and compositional:
  1. Provision host prerequisites.
  2. Materialize required directories.
  3. Link package trees into the home directory.
- Runtime behavior is mostly declarative (dotfiles + manifests) with imperative orchestration in shell scripts.

## Flow
1. User runs `install.sh` (or manually runs setup/apply steps).
2. `setup.sh` ensures package manager and key tools exist, then creates target config directories.
3. `stow.sh` removes conflicting targets and symlinks package content (`zsh`, `git`, `ghostty`, `fnm`, `opencode`, `opencode-profiles`).
4. New shell sessions consume linked configs; Git and CLI tools adopt policy/aliases automatically.

## Directory Map (Aggregated)
| Directory | Responsibility Summary | Detailed Map |
|-----------|------------------------|--------------|
| `fnm/` | Declares Node.js runtime version policy via `.nvmrc` for `fnm`-managed shells. | [View Map](fnm/codemap.md) |
| `git/` | Centralizes Git identity, aliases, and optional commit-template standards. | [View Map](git/codemap.md) |
| `zsh/` | Implements shell startup pipeline, aliases, completions, and plugin stack. | [View Map](zsh/codemap.md) |

## Integration
- External dependencies: Homebrew ecosystem, GNU Stow, Zinit, FNM, and macOS `defaults` APIs.
- Primary consumers: interactive shell sessions, Git workflows, and OpenCode profile launch commands.
