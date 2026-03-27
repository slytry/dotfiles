# zsh/

## Responsibility
Acts as the interactive shell runtime layer: environment bootstrapping, developer aliases, completions, and plugin orchestration.

## Design
- Split initialization model:
  - `.zprofile` handles login-shell concerns (base `PATH`, non-interactive `fnm` setup).
  - `.zshrc` handles interactive concerns (aliases, functions, completion, prompt, plugins).
- Plugin lifecycle uses Zinit with lazy loading (`wait`, `lucid`) to reduce startup overhead.
- Local command abstraction via shell functions (`mkcd`, `op`) and custom completion hooks (`_op_complete`).

## Flow
1. Login shell loads `.zprofile` and exports baseline path/toolchain variables.
2. Interactive shell loads `.zshrc` and builds runtime environment (`PATH`, language/tool vars).
3. CLI ergonomics layer applies aliases, navigation helpers (`zoxide`), and OpenCode profile launcher.
4. Completion and plugin subsystems initialize (`compinit`, Zinit plugins, OpenCode completion).
5. Prompt and fuzzy finder settings finalize (`starship`, `FZF_DEFAULT_OPTS`).

## Integration
- Depends on: `fnm`, `zoxide`, `eza`, `bat`, `ripgrep`, `fd`, `fzf`, `starship`, `zinit`.
- Consumed by: user shell sessions and terminal-based development workflows.
- Interacts with: `~/.config/opencode-profiles` through the `op` profile-selection function.
