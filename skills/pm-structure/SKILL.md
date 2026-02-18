---
name: pm-structure
description: Use when converting a PRD or design document into a GitHub Milestone with dependency-ordered Issues containing Gherkin acceptance criteria, size labels, and implementation notes
---

# pm-structure — PRD to GitHub Issues

**Type:** Rigid. Follow this process exactly.

## Inputs

- A PRD file (in `docs/plans/` or provided by user)
- Access to the project repository (GitHub MCP + gh CLI)

## Process

### Step 1: Read and Parse the PRD

Read the PRD file. Extract:
- **Project title** — becomes the Milestone title
- **Project description** — becomes the Milestone description
- **Epics / major sections** — each becomes a group of issues
- **User stories / features** — each becomes a GitHub Issue
- **Dependencies** — which stories depend on which
- **Shared infrastructure** — foundation work needed before feature work (these become issues labeled `type/infra`)

If the PRD is ambiguous, ask the user for clarification before proceeding.

### Step 2: Read Configuration

Read `.github/pm-config.yaml` from the project root. If it doesn't exist, use defaults:
```yaml
project:
  owner: (from git remote)
  repo: (from git remote)
  base_branch: (from git default branch)
labels: []
templates:
  issue_body: ""  # uses built-in template
```

Auto-detect owner/repo from git remote if not configured:
```bash
gh repo view --json owner,name --jq '.owner.login + "/" + .name'
```

### Step 3: Create Label Taxonomy

Create these labels via `gh label create` (skip any that already exist — `gh label create` will error on duplicates, which is fine):

**Type labels:**
- `type/feature` (color: `0e8a16`, description: "New feature or enhancement")
- `type/infra` (color: `d4c5f9`, description: "Infrastructure, setup, or foundation work")
- `type/bug` (color: `d73a4a`, description: "Bug fix")
- `type/docs` (color: `0075ca`, description: "Documentation")
- `type/test` (color: `bfd4f2`, description: "Test-only changes")

**Size labels (T-shirt sizing):**
- `size/xs` (color: `ededed`, description: "Extra small — < 30 min")
- `size/s` (color: `c2e0c6`, description: "Small — 30 min to 1 hour")
- `size/m` (color: `bfd4f2`, description: "Medium — 1 to 3 hours")
- `size/l` (color: `f9d0c4`, description: "Large — 3 to 8 hours")
- `size/xl` (color: `e99695`, description: "Extra large — should be split")

**Status labels:**
- `status/ready` (color: `0e8a16`, description: "Ready for implementation")
- `status/in-progress` (color: `fbca04`, description: "Agent is working on this")
- `status/in-review` (color: `1d76db`, description: "PR created, awaiting review")
- `status/blocked` (color: `d73a4a`, description: "Blocked by dependency or question")
- `status/done` (color: `333333`, description: "Completed and merged")

**Priority labels:**
- `priority/critical` (color: `b60205`, description: "Must have — blocks project")
- `priority/high` (color: `d93f0b`, description: "Should have — core functionality")
- `priority/medium` (color: `fbca04`, description: "Nice to have — enhances project")
- `priority/low` (color: `0e8a16`, description: "Could defer — not blocking")

Also create any custom labels from `pm-config.yaml`.

Run label creation as a batch:
```bash
gh label create "type/feature" --color "0e8a16" --description "New feature or enhancement" --force
# ... repeat for all labels
```

Use `--force` to update existing labels rather than error.

### Step 4: Create Milestone

Create the Milestone via gh CLI:
```bash
gh api repos/{owner}/{repo}/milestones --method POST \
  -f title="{project title}" \
  -f description="{project description}" \
  -f state="open"
```

Capture the milestone number from the response for use in Step 5.

If a milestone with this title already exists, use it instead of creating a duplicate.

### Step 5: Generate Issues in Dependency Order

For each user story / feature extracted from the PRD:

1. **Foundation / infra issues first** — no dependencies
2. **Feature issues next** — may depend on infra
3. **Integration / polish issues last** — depend on features

For each issue, compose the body using `issue-body-template.md` from this skill's directory. Read the template, then fill in:

- **User Story** — from the PRD
- **Acceptance Criteria** — write Gherkin scenarios following `gherkin-guide.md`
- **Definition of Done** — standard checklist (customize per issue if needed)
- **Implementation Notes** — technical guidance from the PRD + your analysis
- **Files Likely Affected** — best-effort list based on codebase exploration
- **Size label** — estimate based on scope
- **Type label** — feature, infra, bug, docs, or test
- **Priority label** — from PRD priority or inferred

Create issues via GitHub MCP:
```
Use mcp__github tools or gh CLI to create each issue with:
- title: concise imperative description
- body: filled-in template
- labels: [type/X, size/X, priority/X, status/ready or status/blocked]
- milestone: milestone number from Step 4
```

### Step 6: Annotate Dependencies

For each issue that depends on other issues, ensure the body contains:
```html
<!-- pm:blocked-by #12, #15 -->
```

This must be present in the issue body (added during creation in Step 5). These HTML comments are invisible to human readers but machine-parseable by `pm-dispatch`.

Also label dependent issues as `status/blocked` (not `status/ready`).

### Step 7: Present Summary

Output a summary for the user:

```markdown
## Project Structured: {project title}

**Milestone:** #{milestone_number} — {title}
**Issues created:** {count}

### Dependency Graph
{visual representation using indentation or ASCII}

### Ready for Dispatch (no blockers)
| # | Title | Size | Priority |
|---|-------|------|----------|
| {number} | {title} | {size} | {priority} |

### Blocked (waiting on dependencies)
| # | Title | Blocked By |
|---|-------|-----------|
| {number} | {title} | #{deps} |

**Next step:** Invoke `claude-pm:pm-dispatch` to start implementation.
```

## Important Rules

1. **Never create duplicate issues** — check existing milestone issues first
2. **Every issue must have Gherkin acceptance criteria** — no exceptions
3. **Dependencies must be annotated both ways** — HTML comment in body + status/blocked label
4. **Size XL issues must be split** — create sub-issues instead
5. **Foundation first** — infrastructure issues have no dependencies and are created first
6. **One behavior per issue** — if an issue covers multiple behaviors, split it
