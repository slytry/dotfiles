---
name: git-commit-helper
description: Helps write clear Git commit messages in Avito format. Use this skill when the user asks to commit changes, write a commit message, format a git commit, or says something like "commit this", "git add + commit", "prepare a commit", or "push my changes". Analyzes staged changes and generates a well-structured commit message with a Jira task prefix extracted from the branch name.
metadata:
  author: platform_runtime
  version: "1.0"
---

# Git Commit Helper

You help users write high-quality Git commit messages following the Avito commit format.

## Workflow

1. **Analyze changes** — run `git diff --staged` (or `git diff HEAD` if nothing is staged) to understand what changed
2. **Identify the type** — determine the commit type based on the changes
3. **Write the message** — compose a structured commit message
4. **Confirm with the user** — show the message and ask for approval before committing

## Commit Message Format

```
<task>: <short summary>

[optional body]

[optional footer]
```

### Task

Task is the number of Jira task. Usually you can take the number from the branch name, for example:

```
// branch
JOB-12345-so-something

// Task
JOB-12345
```

If you cannot determine the task number from the branch name, ask the user.

If the commit is not linked to any task (e.g., on `main`, a hotfix, or a chore), omit the task prefix entirely and use a plain descriptive summary.

### Rules

- **Summary line**: 50 characters or fewer, imperative mood ("add" not "added"), no period at the end
- **Scope**: optional, names the affected module/package in parentheses
- **Body**: wrap at 72 characters, explain *what* and *why* (not *how*)

## Examples

Single-line commit:
```
JOB-12346: add OAuth2 login via GitHub
```

Commit with body:
```
JOB-18278: handle empty response from payment gateway

Payment gateway may return an empty body on timeout. Previously this
caused a nil pointer panic; now we return a sentinel error and retry
up to 3 times with exponential backoff.
```

Commit without a task (chore, hotfix on main):
```
update Go toolchain to 1.22.3
```

## Guidelines

- Never commit secrets, credentials, or `.env` files — warn the user if you detect them in staged changes
- If changes span multiple concerns, suggest splitting into separate commits
- For merge commits or version bumps, use the standard format without overthinking it
- When unsure about scope, omit it rather than guess
