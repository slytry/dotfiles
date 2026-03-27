# fnm/

## Responsibility
Provides runtime version pinning for Node.js via a repository-local `.nvmrc` contract.

## Design
- Uses the Version File pattern: a single declarative file (`.nvmrc`) as source of truth.
- Runtime selection is delegated to `fnm` with recursive version-file resolution.

## Flow
1. Shell startup evaluates `fnm env --version-file-strategy recursive`.
2. `fnm` searches upward/downward for `.nvmrc` in the current working tree.
3. The declared version (`24.13.0`) is activated in the shell process.

## Integration
- Consumed by: `zsh/.zprofile`, `zsh/.zshrc`.
- Depends on: `fnm` binary installed through Homebrew (`Brewfile`, `setup.sh`).
