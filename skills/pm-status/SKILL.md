---
name: pm-status
description: Use anytime to view project progress — builds a dashboard from GitHub Issue and PR state, categorizes by status, shows blockers and CI results, enables session crash recovery
---

# pm-status — Progress Dashboard

**Type:** Rigid. Follow this process exactly.

## Inputs

- A GitHub Milestone (provide milestone title or number, or auto-detect the most recent open milestone)
- Access to the project repository (GitHub MCP + gh CLI)

## Process

### Step 1: Fetch All Issues in Milestone

Fetch all issues (open AND closed) in the milestone:
```
mcp__github__list_issues with owner, repo (both OPEN and CLOSED state)
```

Filter to the target milestone. For each issue, collect:
- Number, title, state (open/closed), labels, assignee
- Parse `<!-- pm:blocked-by #N, #M -->` from body

If no milestone is specified, find the most recent open milestone:
```bash
gh api repos/{owner}/{repo}/milestones --jq '.[0]'
```

### Step 2: Categorize Issues by Status

Categorize each issue into exactly one bucket based on labels and state:

| Bucket | Criteria | Display |
|--------|----------|---------|
| **Done** | Closed + `status/done` label | Checkmark |
| **In Review** | Open + `status/in-review` label | Arrow-right |
| **In Progress** | Open + `status/in-progress` label | Spinner |
| **Blocked** | Open + `status/blocked` label | X |
| **Ready** | Open + `status/ready` label + all deps resolved | Circle |
| **Pending** | Open + deps unresolved (no actionable status) | Dot |

If an issue's labels conflict (e.g., both `status/ready` and `status/blocked`), use the highest-priority bucket: Blocked > In Progress > In Review > Ready > Pending.

### Step 3: Fetch PR Status for In-Review Issues

For each issue labeled `status/in-review`:

1. Find the linked PR (search for PRs mentioning `Closes #{issue_number}` or with branch name matching `pm/{issue_number}-*`)
2. Fetch CI status:
   ```
   mcp__github__pull_request_read(method: "get_status", owner, repo, pullNumber)
   ```
3. Record: PR number, CI status (passing/failing/pending), review state (approved/changes-requested/pending)

### Step 4: Present Dashboard

Output a formatted dashboard:

```markdown
## Project Status: {milestone_title}

**Progress:** {done_count}/{total_count} issues complete ({percentage}%)
```
███████████░░░░░░░░░ 55%
```

### Summary
| Status | Count | Issues |
|--------|-------|--------|
| Done | {n} | #{list} |
| In Review | {n} | #{list} |
| In Progress | {n} | #{list} |
| Blocked | {n} | #{list} |
| Ready | {n} | #{list} |
| Pending | {n} | #{list} |

### CI Status (In-Review PRs)
| Issue | PR | CI | Review |
|-------|----|----|--------|
| #{issue} | #{pr} | {pass/fail/pending} | {approved/changes-requested/pending} |

### Blockers
{For each blocked issue:}
- **#{number}: {title}** — {reason from latest issue comment or label}
  - Blocked by: #{deps that are still open}

### Remaining Dependency Graph
{Show only unresolved portions of the DAG}

### Recommended Next Actions
{Based on current state:}
- {If issues are ready: "Dispatch next batch with `pm:dispatch`"}
- {If all in-review: "Review PRs, then `pm:integrate`"}
- {If blockers exist: "Resolve blocker on #{N}: {description}"}
- {If all done: "Run `pm:integrate` to merge and close milestone"}
```

## Session Recovery

This skill is the **session crash recovery mechanism**. When starting a new session after a crash:

1. Run `pm:status` — it reads all state from GitHub, not from conversation memory
2. The dashboard shows exactly where the project stands
3. Based on the dashboard, the user can:
   - Re-dispatch blocked or failed issues
   - Continue with `pm:integrate` if PRs are ready
   - Manually fix blockers and re-dispatch

No state is lost because GitHub Issues and PRs are the durable state machine.

## Progress Bar Rendering

Use block characters for the progress bar:
```
Full block:  █ (U+2588)
Light shade: ░ (U+2591)
Width: 20 characters
Each character = 5%
```

Example at 55% (11 full, 9 light):
```
███████████░░░░░░░░░ 55%
```

## Important Rules

1. **Always show all issues** — including closed ones (they're the "done" count)
2. **Parse dependencies fresh** — don't cache from a previous session
3. **CI status is live** — always fetch current status, not cached
4. **Be actionable** — the "Recommended Next Actions" section must give concrete next steps
5. **Handle milestone not found** — if no milestone exists, tell the user to run `pm:structure` first
