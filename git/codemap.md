# git/

## Responsibility
Implements VCS policy and ergonomics: author identity, default behaviors, and high-frequency Git workflow aliases.

## Design
- Centralized configuration via `.gitconfig` for deterministic developer behavior across repositories.
- Alias-driven Command pattern for repeatable multi-step operations (`job`, `upm`, `sync-staged`, `sc`).
- Optional commit-template policy (`.stCommitMsg`) for commit-message conventions.

## Flow
1. Git CLI reads `~/.gitconfig` (symlinked from this directory).
2. Command aliases expand into porcelain/plumbing invocations.
3. Workflow aliases orchestrate branch sync, amend/push, or branch bootstrap logic.
4. If enabled, commit template seeds commit message drafting with imperative style rules.

## Integration
- Provisioned by: `stow.sh` (`stow_with_force git`).
- Depends on: Git binary, `git-lfs` filter hooks, local editor command (`code --wait`).
- Influences: any repository operated from this machine.
