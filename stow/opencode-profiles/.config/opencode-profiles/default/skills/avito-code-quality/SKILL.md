---
name: code-quality
description: Runs code formatting and linting in Avito projects using `avito fmt` and `avito lint`. Use this skill whenever the user wants to format code, run a linter, fix code style, clean up before committing, or ensure code quality — even if they don't say "fmt" or "lint" explicitly. Also use after any code modification to keep quality high.
metadata:
  author: platform_runtime
  version: "1.0"
---

# Code Quality

Avito projects use the `avito` CLI for all standard project operations, including formatting and linting.

To format code, run:

```
avito fmt
```

To lint code, run:

```
avito lint
```

## Rules

- Commands take no parameters
- Always run them from the project root
- Both commands can be run together: `avito fmt && avito lint`
- Run everything through `avito fmt` and `avito lint`, not directly via `gofmt`, `golangci-lint`, `prettier`, etc. — Avito projects configure all formatters and linters in `actions.toml`, and bypassing it produces inconsistent results
- Do NOT edit `actions.toml` — there is a separate skill for that

## Instructions

- On the first run, append `| tail -50` to see only a brief summary
- If commands fail, re-run without `| tail -50` to see the full output
- Analyze all errors returned by the commands
- After any code modification, offer to run `avito fmt && avito lint` to ensure quality
