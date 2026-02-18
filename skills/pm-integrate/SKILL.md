---
name: pm-integrate
description: Use when implementation is complete and PRs need merging — performs pre-integration audit, topological merge ordering, sequential merge with test verification, conflict resolution, and milestone closure
---

# pm-integrate — Merge PRs and Close Milestone

**Type:** Rigid. Follow this process exactly.

## Inputs

- A GitHub Milestone with completed issues and PRs
- Access to the project repository (GitHub MCP + gh CLI)

## Process

### Step 1: Pre-Integration Audit

Run `pm:status` mentally (or invoke it) to verify readiness:

1. Fetch all issues in the milestone
2. Verify: **every issue** is either:
   - Closed with `status/done` (already merged)
   - Open with `status/in-review` and a PR with passing CI
3. If any issues are `status/blocked`, `status/in-progress`, or `status/ready`:
   - Report them and ask user how to proceed
   - Options: "Wait for completion", "Exclude from integration", "Cancel"

Fetch all linked PRs and verify:
```
For each in-review issue:
  1. Find PR (branch pattern pm/{issue_number}-*)
  2. Check CI: mcp__github__pull_request_read(method: "get_status")
  3. Check review: mcp__github__pull_request_read(method: "get_reviews")
```

If any PR has failing CI, report it and ask user whether to proceed or fix first.

### Step 2: Build Merge Order

Parse `<!-- pm:blocked-by #N, #M -->` from all issue bodies to build the dependency graph.

**Topological sort** the dependency DAG:
- Issues with no dependencies merge first
- Issues depending on others merge after their dependencies
- Break ties by PR creation date (oldest first)

Already-merged issues (closed + `status/done`) are skipped.

Present the merge order:
```markdown
## Merge Order

| Order | Issue | PR | Dependencies | CI |
|-------|-------|-----|-------------|-----|
| 1 | #{n}: {title} | #{pr} | none | pass |
| 2 | #{n}: {title} | #{pr} | #{dep} | pass |
| 3 | #{n}: {title} | #{pr} | #{dep1}, #{dep2} | pass |
```

### Step 3: Approval Gate

If `approval_gates.before_merge` is true (or as a safety default), present the merge plan and wait:

```markdown
## Merge Plan

**Strategy:** {squash|merge|rebase} (from config)
**PRs to merge:** {count}
**Order:** Dependency-first, then by creation date
**Post-merge test verification:** Yes (after each merge)

Approve merge sequence?
```

Even if the gate is off, **always announce** what you're about to do before starting.

### Step 4: Sequential Merge with Verification

For each PR in merge order:

#### 4a. Check PR is up-to-date
```bash
gh pr view {pr_number} --json mergeable,mergeStateStatus
```

If the PR is behind the base branch (because a previous PR was just merged):
```bash
# Rebase the PR branch onto the updated base
git fetch origin
git checkout {branch_name}
git rebase origin/{base_branch}
git push --force-with-lease origin {branch_name}
```

Wait for CI to re-run after rebase. Check status:
```
mcp__github__pull_request_read(method: "get_status")
```

#### 4b. Check for Conflicts
If the PR has merge conflicts after rebase:
- **Additive conflicts** (different sections of same file): attempt auto-resolve with rebase
- **Overlapping conflicts** (same lines): present to user with both versions, ask for resolution
- **Never force-resolve conflicts** — always present to user if auto-resolve fails

#### 4c. Merge PR
Use the configured merge strategy:
```bash
gh pr merge {pr_number} --{strategy} --delete-branch
```

Where `{strategy}` is `squash`, `merge`, or `rebase` from config (default: `squash`).

If `merge.delete_branch` is false, omit `--delete-branch`.

#### 4d. Post-Merge Test Verification
After merging, verify the base branch is healthy:
```bash
git checkout {base_branch}
git pull origin {base_branch}
{test_command}
```

If tests fail after merge:
- **STOP merging immediately**
- Report which PR caused the failure
- Present options: "Revert last merge", "Debug and fix", "Continue anyway (dangerous)"
- Do NOT continue merging unless the user explicitly says so

#### 4e. Update Issue
Close the related issue and update labels:
```bash
gh issue close {issue_number} --reason completed
gh issue edit {issue_number} --remove-label "status/in-review" --add-label "status/done"
```

### Step 5: Close Milestone

After all PRs are merged and all issues closed:

1. Verify all issues in the milestone are closed
2. Close the milestone:
   ```bash
   gh api repos/{owner}/{repo}/milestones/{milestone_number} \
     --method PATCH -f state="closed"
   ```

If `approval_gates.before_close_milestone` is true, ask for confirmation first.

### Step 6: Final Report

```markdown
## Integration Complete

**Milestone:** {title} — CLOSED
**PRs merged:** {count}
**Issues closed:** {count}
**Merge strategy:** {strategy}

### Merge Log
| Order | Issue | PR | Status |
|-------|-------|-----|--------|
| 1 | #{n}: {title} | #{pr} | Merged |
| 2 | #{n}: {title} | #{pr} | Merged |

### Test Results
- **Post-merge test suite:** PASSING
- **Total tests:** {count}

### Conflicts Resolved
{list any conflicts that were resolved, or "None"}

### Cleanup
- Branches deleted: {list}
- Worktrees to clean up: `rm -rf {worktree_dir}/{branch_prefix}/`
```

## Conflict Resolution Strategies

| Conflict Type | Detection | Resolution |
|---|---|---|
| **Additive** — different files or non-overlapping sections | `git rebase` succeeds | Automatic via rebase |
| **Overlapping** — same lines in same file | `git rebase` fails with conflict markers | Present both versions to user, ask for resolution |
| **Semantic** — no textual conflict but broken behavior | Tests fail after merge | Revert merge, dispatch fix agent to reconcile |

## Worktree Cleanup

After integration, remind the user to clean up worktrees:
```bash
rm -rf {worktree_dir}/{branch_prefix}/
```

Or if using git worktree tracking:
```bash
git worktree list
git worktree remove {path}  # for each completed worktree
git worktree prune
```

## Important Rules

1. **Always merge in dependency order** — never merge a dependent before its dependency
2. **Always verify tests after EACH merge** — catch integration failures early
3. **Never force-merge conflicts** — present to user
4. **Stop on test failure** — do not continue merging if the base branch is broken
5. **Rebase before merge** — ensure each PR is up-to-date with base before merging
6. **Close issues via the merge** — `Closes #N` in PR body triggers auto-close, but verify and update labels explicitly
