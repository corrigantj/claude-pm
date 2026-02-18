---
name: pm-dispatch
description: Use when ready to start implementation — spawns parallel pm-implementer agents for issues that have no unresolved dependencies, respecting max parallelism and file overlap constraints
---

# pm-dispatch — Spawn Implementation Agents

**Type:** Rigid. Follow this process exactly.

## Inputs

- A GitHub Milestone with issues created by `pm-structure`
- Access to the project repository (GitHub MCP + gh CLI)

## Process

### Step 1: Read Configuration

Read `.github/pm-config.yaml` from the project root. Extract or use defaults:
```yaml
agents:
  max_parallel: 3
  model: opus
branches:
  prefix: pm
worktrees:
  directory: .worktrees
approval_gates:
  before_dispatch: false
commands:
  test: ""   # auto-detect if empty
  lint: ""
  build: ""
```

**Auto-detect build commands** if not configured:
- `package.json` exists → `npm test`, `npm run lint`, `npm run build`
- `Cargo.toml` exists → `cargo test`, `cargo clippy`, `cargo build`
- `pyproject.toml` exists → `pytest`, `ruff check .`, (no build)
- `go.mod` exists → `go test ./...`, `golangci-lint run`, `go build ./...`
- `Makefile` exists → `make test`, `make lint`, `make build`

### Step 2: Fetch All Issues in Milestone

Use GitHub MCP to fetch all open issues in the milestone:
```
mcp__github__list_issues with owner, repo, state: "OPEN"
```

Filter to issues belonging to the target milestone. Collect:
- Issue number, title, body, labels
- Parse `<!-- pm:blocked-by #N, #M -->` from each issue body

### Step 3: Build Dependency Graph

For each issue, extract dependencies from `<!-- pm:blocked-by ... -->` comments.

Build a directed acyclic graph (DAG):
- Nodes = issues
- Edges = "blocked-by" relationships
- Closed issues count as resolved dependencies

Verify the graph is acyclic. If cycles detected, report to user and stop.

### Step 4: Identify Parallelizable Batch

An issue is **ready** if:
1. All its `blocked-by` issues are closed (or have `status/done` label)
2. It has the `status/ready` label (not `status/in-progress`, `status/blocked`, `status/in-review`)
3. It is not assigned to another agent already

From the ready set, select up to `max_parallel` issues. Selection criteria:
1. **Priority sort** — `priority/critical` > `priority/high` > `priority/medium` > `priority/low`
2. **File overlap check** — if two ready issues list the same files in "Files Likely Affected", only dispatch one per batch (to avoid merge conflicts)
3. **Size preference** — prefer smaller issues when priority is equal (faster feedback)

### Step 5: Approval Gate

If `approval_gates.before_dispatch` is true, present the batch plan and wait for human approval:

```markdown
## Dispatch Batch Plan

**Milestone:** {title}
**Batch size:** {count} of {max_parallel} max
**Remaining issues:** {total_open - count}

| # | Title | Size | Priority | Branch |
|---|-------|------|----------|--------|
| {n} | {title} | {size} | {priority} | {branch_prefix}/{n}-{slug} |

**File overlap check:** {PASS or list conflicts}

Approve dispatch? (The agents will create branches, implement with TDD, and create PRs.)
```

If approval gate is off, announce the batch but proceed immediately.

### Step 6: Dispatch Agents

For each issue in the batch:

1. **Generate branch name:** `{branch_prefix}/{issue_number}-{slug}`
   - `slug` = issue title, lowercased, spaces → hyphens, max 50 chars, alphanumeric + hyphens only

2. **Generate worktree path:** `{worktree_dir}/{branch_prefix}/{issue_number}-{slug}`

3. **Label the issue** `status/in-progress` (remove `status/ready`)

4. **Read the implementer prompt template** from `skills/pm-dispatch/implementer-prompt.md` in this plugin

5. **Read the PR body template** from `skills/pm-structure/pr-body-template.md` in this plugin

6. **Fill the prompt template** with:
   - Issue number, title, body
   - Owner, repo, base branch
   - Branch name, worktree path
   - Test/lint/build commands
   - PR body template content

7. **Spawn the agent** using the Task tool:
   ```
   Task tool with subagent_type: "pm-implementer"
   prompt: {filled implementer prompt}
   model: {from config, default opus}
   ```

Spawn all agents in a single message (parallel tool calls) for maximum concurrency.

### Step 7: Monitor and Report

After all agents in the batch complete:

1. **Collect results** — parse each agent's structured YAML result
2. **Update issue labels** based on results:
   - `status: success` → issue already labeled `status/in-review` by agent
   - `status: error` → label `status/blocked`, post failure details
   - `status: blocked` → already labeled by agent
3. **Present batch report:**

```markdown
## Dispatch Batch Complete

| # | Title | Status | PR | Tests |
|---|-------|--------|-----|-------|
| {n} | {title} | {status} | #{pr} | {pass/fail} |

**Succeeded:** {count}
**Failed/Blocked:** {count}
```

4. **Check for next batch** — re-run Step 4 to identify newly-unblocked issues
   - If more issues are ready, ask: "Ready to dispatch next batch?" (or auto-dispatch if gate is off)
   - If no more issues ready and some are blocked, suggest investigating blockers
   - If all issues are in-review or done, suggest `claude-pm:pm-integrate`

## Slug Generation

```
title = "Add user authentication middleware"
slug  = "add-user-authentication-middleware"

title = "Fix: Handle NULL values in CSV export (#42)"
slug  = "fix-handle-null-values-in-csv-export"
```

Rules:
- Lowercase
- Replace spaces and special chars with hyphens
- Remove consecutive hyphens
- Strip leading/trailing hyphens
- Truncate to 50 characters at word boundary
- Alphanumeric and hyphens only

## Important Rules

1. **Never dispatch more than `max_parallel` agents** — even if more issues are ready
2. **File overlap = sequential** — issues touching the same files must be in different batches
3. **Check dependencies are truly resolved** — a closed issue with a reverted PR is NOT resolved
4. **Each agent gets a fresh context** — pass all needed information in the prompt, don't assume shared state
5. **Use the Task tool** — agents are spawned via `Task` with `subagent_type: "pm-implementer"`, NOT via bash
