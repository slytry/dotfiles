---
name: unit-tests-ts-js
description: |
  This skill is for writing Jest unit tests for TypeScript and JavaScript.
metadata:
  author: vgpinevich
  version: "1.0"
---

## When To Use This Skill

- The user asks to write, add, or extend unit tests for TS/JS modules.
- The request mentions .ts, .js, .cjs, .mjs, .spec.ts, or .spec.js files

---
# Rules

## Mocking & Teardown

- Reuse existing repository mock data and fixture files where possible.
- Never mock the function or class you are directly testing.
- Use jest.mocked() to type mock functions correctly
- Mock external dependencies using the most appropriate Jest tool: prefer `jest.mock()` for full module mocks and `jest.spyOn()` for partial mocking or call tracking.
- Use jest.clearAllMocks() for fresh call counts.
- Use jest.resetAllMocks() only when a test changes mock implementations.
- Use jest.restoreAllMocks() after tests that use jest.spyOn() or replace properties.
- Restore explicitly manually mutated global objects in afterEach.

## Best Practices

- Write atomic tests using the Arrange-Act-Assert pattern, testing initial and final states in separate it blocks.
- Don't test types and constants
- Avoid `any` and non-null assertions; if you must cast, do it carefully and minimally.
- Do not use `if` statements in tests.
- Do not use snapshots for unit tests.
- Do not rely on shared mutable state between tests

---

## Step-By-Step Flow For Generating Unit Tests

### 1. Clarify Target And Context

Before writing tests, read the exact file being tested to understand its internal branches, exported members, and typings. Do not write tests blindly.

### 2. Design And Write Tests

Follow all rules above when creating the test file and writing the tests

### 3. Validation

- Determine how to run tests in this repository based on the project rules in your context. Inspect package.json if necessary.
- Run the narrowest relevant command, ideally scoped to the affected test file.
- If tests fail, fix the tests or imports, then rerun the affected tests until they pass. You MUST follow testing rules described above
- If execution is blocked by missing scripts, dependencies, or environment issues, clearly report the blocker instead of claiming success.
- Do not present the tests to the user until you have confirmed they pass in the terminal.
