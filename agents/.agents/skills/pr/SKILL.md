---
name: pr
description: Use when the user asks you to create or update a PR.
---

# PR

## 1. Read the template

Find this repo's PR template - `.github/PULL_REQUEST_TEMPLATE.md`, `.github/PULL_REQUEST_TEMPLATE/`, `docs/`, or the repo root - and read it. Several templates: ask which. No template: the body is a `## Description` heading over the change bullets.

## 2. Read the change

Diff the branch against its merge-base with the base branch, and read its commit titles. The diff is the source of the description; the conversation supplies only what the diff cannot show - reasons, rejected approaches, manual testing. Harvest ticket IDs from the branch name and commit titles.

## 3. Write the body to a scratch file

Reproduce the template **verbatim**: every heading in its original order, wording, and level; every checkbox item with its original text. Drop the HTML comments - they are instructions to you, and you have followed them.

Fill it **terse**:

- Bullets, one line each. Say what changed, plus the why when the why isn't visible in the diff
- A handful of bullets for a typical branch; a long branch earns more bullets, never paragraphs
- Tick each checkbox from evidence in the diff (touched endpoints, envars, tests). An item you cannot settle from the diff goes to the user.
- Infrastructure-as-code changes go tersest of all. The reader knows the repo, so name what changed in the repo's own words - module, path, version, dependency - and stop: "Bump ANZTCT auth0 module to `tenancy-v5.11.6`", never a sentence explaining what that module does
- A section the diff and conversation cannot fill - screenshots, ticket links - keeps its heading and carries a bare `-`, and you name it when you report

## 4. Open it

Push the branch, then `gh pr create --base <base> --title <title> --body-file <scratch file>`. Title follows the convention of the branch's commit titles. Report the URL, plus every section left bare and every checkbox the user must settle.
