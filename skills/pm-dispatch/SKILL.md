---
name: pm-dispatch
description: Use when ready to start implementation — spawns parallel pm-implementer agents for issues that have no unresolved dependencies, targeting the feature branch and injecting mustread context into each agent
---

# pm-dispatch — Spawn Implementation Agents

**Type:** Rigid. Follow this process exactly.

## Inputs

- A GitHub Milestone with issues created by `claude-pm:pm-structure`
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
  feature: ""        # e.g. feature/auth-v1 — REQUIRED
worktrees:
  directory: .worktrees
approval_gates:
  before_dispatch: false
commands:
  test: ""   # auto-detect if empty
  lint: ""
  build: ""
wiki:
  meta_page: ""      # path or URL to the feature's wiki meta page
  prd: ""            # path or URL to the PRD document
sizing:
  token_ranges: {}   # e.g. { "size:xs": [0, 4000], "size:s": [4000, 12000], ... }
review:
  auto_request: false
  reviewers: []      # GitHub usernames to request review from
```

**Auto-detect build commands** if not configured:
- `package.json` exists -> `npm test`, `npm run lint`, `npm run build`
- `Cargo.toml` exists -> `cargo test`, `cargo clippy`, `cargo build`
- `pyproject.toml` exists -> `pytest`, `ruff check .`, (no build)
- `go.mod` exists -> `go test ./...`, `golangci-lint run`, `go build ./...`
- `Makefile` exists -> `make test`, `make lint`, `make build`

### Step 2: Fetch All Issues in Milestone

Use GitHub MCP to fetch all open issues in the milestone:
```
mcp__github__list_issues with owner, repo, state: "OPEN"
```

Filter to issues belonging to the target milestone. Then:

1. **Filter out `meta:ignore`** — any issue with the `meta:ignore` label is excluded completely from all processing.
2. **Collect `meta:mustread` issues separately** — issues with the `meta:mustread` label are context documents, not work items. Read their full bodies; these will be injected into each agent's prompt context.
3. **For remaining work items**, collect:
   - Issue number, title, body, labels
   - Parse `<!-- pm:blocked-by #N, #M -->` from each issue body
   - Parse `<!-- pm:parent #NN -->` from each issue body

### Step 3: Build Dependency Graph

For each work item issue, extract dependencies from `<!-- pm:blocked-by ... -->` comments.

Parse `<!-- pm:parent #NN -->` comments to understand story-to-task hierarchy. Walk parent-to-child relationships for task-level dependency resolution: if a parent story has a `blocked-by`, all its child tasks inherit that dependency.

Build a directed acyclic graph (DAG):
- Nodes = issues (work items only, not mustread or ignore)
- Edges = "blocked-by" relationships (both explicit and inherited from parent)
- Closed issues count as resolved dependencies

Verify the graph is acyclic. If cycles detected, report to user and stop.

### Step 4: Identify Parallelizable Batch

An issue is **ready** if:
1. All its `blocked-by` issues are closed (or have `status:done` label)
2. It has the `status:ready` label (not `status:in-progress`, `status:blocked`, `status:in-review`)
3. It is not assigned to another agent already
4. It does **not** have `meta:ignore` or `meta:mustread` labels (these are not work items)

From the ready set, select up to `max_parallel` issues. Selection criteria:
1. **Priority sort** — `priority:critical` > `priority:high` > `priority:medium` > `priority:low`
2. **File overlap check** — if two ready issues list the same files in "Files Likely Affected", only dispatch one per batch (to avoid merge conflicts)
3. **Token-based sizing preference** — when priorities are equal, prefer smaller token estimates (`size:xs` < `size:s` < `size:m` < `size:l` < `size:xl`) for faster feedback

### Step 5: Approval Gate

If `approval_gates.before_dispatch` is true, present the batch plan and wait for human approval:

```markdown
## Dispatch Batch Plan

**Milestone:** {title}
**Feature Branch:** {feature_branch}
**Batch size:** {count} of {max_parallel} max
**Remaining issues:** {total_open - count}

| # | Title | Size | Priority | Branch |
|---|-------|------|----------|--------|
| {n} | {title} | {size} | {priority} | {branch_prefix}/{n}-{slug} from {feature_branch} |

**File overlap check:** {PASS or list conflicts}

Approve dispatch? (The agents will create branches off the feature branch, implement with TDD, and create PRs targeting the feature branch.)
```

If approval gate is off, announce the batch but proceed immediately.

### Step 6: Dispatch Agents

For each issue in the batch:

1. **Generate branch name:** `{branch_prefix}/{issue_number}-{slug}`
   - `slug` = issue title, lowercased, spaces -> hyphens, max 50 chars, alphanumeric + hyphens only

2. **Generate worktree path:** `{worktree_dir}/{branch_prefix}/{issue_number}-{slug}`

3. **Create worktree from feature branch:**
   ```bash
   git checkout -b {branch_prefix}/{issue_number}-{slug} {feature_branch}
   ```
   The worktree is created from the feature branch, NOT from main.

4. **Label the issue** `status:in-progress` (remove `status:ready`)

5. **Read the implementer prompt template** from `skills/pm-dispatch/implementer-prompt.md` in this plugin

6. **Read the PR body template** from `skills/pm-structure/pr-body-template.md` in this plugin

7. **Read `meta:mustread` issue bodies** collected in Step 2 and prepare them as a combined block for injection into the agent prompt under "Must-Read Context"

8. **Read wiki context** — fetch the wiki meta page and PRD (from config `wiki.meta_page` and `wiki.prd`) and prepare excerpts for injection under "Context Chain"

9. **Fill the prompt template** with:
   - Issue number, title, body
   - Owner, repo, feature branch
   - Branch name, worktree path
   - Test/lint/build commands
   - PR body template content
   - Must-Read Context (mustread issue bodies, or "None" if no mustread issues)
   - Context Chain (wiki meta page excerpt, PRD excerpt)
   - Size label and token range from `sizing.token_ranges`

10. **Spawn the agent** using the Task tool:
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
   - `status: success` -> issue already labeled `status:in-review` by agent
   - `status: error` -> label `status:blocked`, post failure details
   - `status: blocked` -> already labeled by agent
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
   - If all issues are in-review or done, suggest `claude-pm:pm-review`

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
6. **Branch from the feature branch** — never branch from main; agents PR back to the feature branch
7. **Inject mustread context** — every agent receives the bodies of all `meta:mustread` issues as context
