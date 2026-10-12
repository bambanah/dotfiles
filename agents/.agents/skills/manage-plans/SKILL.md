---
name: manage-plans
description: Save the current plan to plans/, implement or resume a saved plan, mark one complete, or review and prune old ones. Use when the user asks to do anything with a plan.
argument-hint: "save | resume <plan> | complete <plan> | review"
---

A plan outlives the session that made it. Plans live as markdown in `plans/` at the root of the working directory, one file per plan, named `plans/NNNN-<slug>.md` - a zero-padded sequence number, so the latest sorts last. Completed plans move to `plans/complete/`, keeping their filename.

Four branches: **save** the plan from this conversation, **resume** a saved one, **complete** one the user declares done, **review** what has piled up. Pick by what the user asked for; default to save.

## Cold start

A saved plan is written for a **cold start**: an agent that has none of this conversation - not the files read, the constraints the user stated, the alternatives rejected, or the reasoning that fixed the shape. Everything the conversation supplied is on the page or reachable from a path, command, or URL on the page.

That is the bar for saving: an agent opening only this file executes the plan end to end without asking a question. Walk each section and name what it assumes the reader already knows; write that in.

## Save

1. Get the date: `date +%F`, and the next number: one past the highest `NNNN` across `plans/` and `plans/complete/`, or `0001`.
2. Write `plans/NNNN-<slug>.md` using the template below, creating `plans/` if it is missing.
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

1. Read the plan file named by the user; when they named none, list the plan files in `plans/` and ask which.
2. Execute the unchecked steps.
3. Keep the file current as you go: tick steps as they complete, and record any decision made or question answered during execution in its section. The plan stays cold-start executable for the session after this one.
4. When every step is ticked, tell the user the plan is ready to complete and leave the file where it is.

## Complete

Completion is the user's call: run this branch only when they declare a plan done.

1. Resolve the plan file they named in `plans/`.
2. `mkdir -p plans/complete && mv plans/<file> plans/complete/`.
3. Tell the user the new path.

## Review

1. List the plan files in `plans/` and read each one's `created` date and title.
2. Report them oldest first, with age in days and a one-line gist, marking any whose steps are all ticked as ready to complete.
3. Delete only the plans the user names.
