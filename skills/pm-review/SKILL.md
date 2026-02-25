---
name: pm-review
description: Use after pm-dispatch agents create PRs — polls for human review activity on task PRs targeting the feature branch, addresses feedback, merges approved PRs, captures micro-retros with token calibration
---

# pm-review — Poll Reviews, Address Feedback, Merge Task PRs

**Type:** Rigid. Follow this process exactly.

## Inputs

- A feature branch with open task PRs (created by `claude-pm:pm-dispatch`)
- Access to the project repository (GitHub MCP + gh CLI)
- Configuration from `.github/pm-config.yaml` (review section)

## Process

### Step 1: Identify Open Task PRs

Find all open PRs targeting the feature branch:
```bash
gh pr list --base feature/{epic}-v{Major} --state open --json number,title,headRefName,reviews,statusCheckRollup
```

For each PR, collect: PR number, linked issue number (from branch name or PR body), CI status, review state. Present a table showing current state:

```markdown
## Open Task PRs

| PR | Issue | Title | CI | Review State |
|----|-------|-------|----|--------------|
| #{pr} | #{issue} | {title} | pass/fail/pending | approved/changes_requested/pending |
```

### Step 2: Spawn Polling Sub-Agent

Use the Task tool to spawn a lightweight polling agent:
- Model: `review.polling_model` from config (default: haiku)
- The sub-agent polls GitHub API at `review.polling_interval` seconds (default: 60)
- Endpoints polled:
  - `gh api repos/{owner}/{repo}/pulls/{pr}/reviews` — review status
  - `gh api repos/{owner}/{repo}/pulls/{pr}/comments` — inline comments
  - `gh api repos/{owner}/{repo}/pulls/{pr}/reviews/{id}/comments` — review comments
- When new activity detected (new review, new comments, status change), sub-agent returns the review data and terminates
- Sub-agent does NOT reason about code — only detects changes and returns raw data

### Step 3: On Activity Detected

Main agent receives review data. Route based on review state:
- **Approved** -> proceed to Step 5
- **Changes Requested** -> proceed to Step 4
- **Comments only** (no formal review verdict) -> address comments, push, resume polling (back to Step 2)

### Step 4: Address Feedback

For each requested change or comment:

1. Read the review comment/inline comment
2. Navigate to the task's worktree (or re-create if cleaned up)
3. Make the requested code changes
4. Run tests to verify the fix doesn't break anything
5. Commit with descriptive message referencing the review
6. Push updated commits to the task branch
7. Post a reply on the PR addressing each comment: "Fixed in {commit_sha}" or explaining why an alternative approach was taken
8. Resume polling (back to Step 2)

### Step 5: On Approval — Merge Task PR

1. Check PR is up-to-date with feature branch:
   ```bash
   gh pr view {pr_number} --json mergeable,mergeStateStatus
   ```
   If behind, rebase onto feature branch and wait for CI.

2. If `review.require_codeowners` is true, verify a matching CODEOWNER has approved

3. Merge using rebase strategy (task PRs always rebase into feature branch):
   ```bash
   gh pr merge {pr_number} --rebase --delete-branch
   ```
   (respect `merge.delete_branch` config)

4. Update linked issue: remove `status:in-review`, add `status:done`, close issue

### Step 6: Capture Micro-Retro

After merge, post a lessons-learned comment on the **task issue** (not the PR):

```markdown
## Micro-Retro: #{issue_number}

- **Estimated size:** {size label from issue labels}
- **Actual tokens:** ~{N}K
- **Review rounds:** {count of review cycles}
- **What went well:** {summary of smooth implementation areas}
- **What went wrong:** {summary of issues encountered}
- **Surprises:** {unexpected challenges or discoveries}
- **Patterns discovered:** {reusable insights for future tasks}
```

Also update the parent story's Scenario Acceptance Tracker:
- Find parent story (from `<!-- pm:parent #NN -->` or sub-issue relationship)
- Update the scenarios this task addressed from `-` to `✅` (or `🐛` if bugs were found)

### Step 7: Check for Next Batch

After all current PRs in this cycle are processed:

1. Check if new tasks are unblocked (their `blocked-by` dependencies are now closed)
2. Present cycle summary:

```markdown
## Review Cycle Complete

| PR | Issue | Title | Review Rounds | Merged |
|----|-------|-------|---------------|--------|
| #{pr} | #{issue} | {title} | {N} | Yes/No |

**Micro-retros captured:** {count}
**Tasks still open:** {count}
**Dependencies newly unblocked:** {count}
```

3. Recommend next action:
   - If newly unblocked tasks: "Run `claude-pm:pm-dispatch` to start next batch"
   - If all task PRs merged: "Run `claude-pm:pm-integrate` to merge feature branch to main"
   - If PRs still awaiting review: "Waiting for human review on {list}"

## Important Rules

1. **Never merge without approval** — or CODEOWNERS approval if `review.require_codeowners` is true
2. **Always rebase onto feature branch** before merging — ensures clean history
3. **Run tests after addressing feedback** — before pushing updated commits
4. **Capture micro-retro on every merged PR** — no exceptions, this feeds the full retrospective
5. **Polling sub-agent uses cheapest model** — it only detects changes, doesn't reason about code
6. **If PR is closed/rejected** — report to user and stop processing that PR
7. **All skill references** use `claude-pm:pm-{skill}` format
8. **All label references** use `:` delimiter
