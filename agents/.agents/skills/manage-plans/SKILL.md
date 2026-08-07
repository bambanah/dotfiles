---
name: manage-plans
description: Save the current plan to plans/, resume a saved plan, or review and prune old ones.
argument-hint: "save | resume <plan> | review"
disable-model-invocation: true
---

A plan outlives the session that made it. Plans live as markdown in `plans/` at the root of the working directory, one file per plan, named `plans/YYYY-MM-DD-<slug>.md` - the date it was created, so age reads at a glance.

Three branches: **save** the plan from this conversation, **resume** a saved one, **review** what has piled up. Pick by what the user asked for; default to save.

## Cold start

A saved plan is written for a **cold start**: an agent that has none of this conversation - not the files read, the constraints the user stated, the alternatives rejected, or the reasoning that fixed the shape. Everything the conversation supplied is on the page or reachable from a path, command, or URL on the page.

That is the bar for saving: an agent opening only this file executes the plan end to end without asking a question. Walk each section and name what it assumes the reader already knows; write that in.

## Save

1. Get the date: `date +%F`.
2. Write `plans/YYYY-MM-DD-<slug>.md` using the template below, creating `plans/` if it is missing.
3. Tell the user the path.

```markdown
---
created: YYYY-MM-DD
---

# <plan title>

## Goal

<what this plan achieves, and why it is worth doing - the user's words where they had them>

## Context

<what a cold-start agent needs before step one: the files and directories in play with their paths, the
commands to run things, the state of the work when the plan was written, the constraints the user stated.>

## Decisions

<the choices already settled, each with its reasoning, and the alternatives ruled out with why -
so a later agent extends the plan instead of re-litigating it>

## Steps

- [ ] <step, specific enough to act on without inventing the details>

## Verification

<how to know the plan worked: the commands to run, the behaviour to observe>

## Open questions

<what is unresolved, and who or what answers it - omit the section when nothing is open>
```

## Resume

1. Read the plan file named by the user; when they named none, `ls plans/` and ask which.
2. Execute the unchecked steps.
3. Keep the file current as you go: tick steps as they complete, and record any decision made or question answered during execution in its section. The plan stays cold-start executable for the session after this one.

## Review

1. `ls plans/` and read each file's `created` date and title.
2. Report them oldest first, with age in days and a one-line gist, marking any whose steps are all ticked.
3. Delete only the plans the user names.
