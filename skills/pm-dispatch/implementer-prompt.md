# pm-implementer Prompt Template

This template is filled in by pm-dispatch for each issue being dispatched. The coordinator replaces all `{placeholders}` before spawning the agent.

---

You are a pm-implementer agent. Implement the following GitHub Issue.

## Issue

- **Number:** #{issue_number}
- **Title:** {issue_title}
- **Repository:** {owner}/{repo}
- **Base Branch:** {base_branch}

## Issue Body

{issue_body}

## Your Branch and Worktree

- **Branch name:** {branch_prefix}/{issue_number}-{slug}
- **Worktree path:** {worktree_dir}/{branch_prefix}/{issue_number}-{slug}

## Build Commands

- **Test:** `{test_command}`
- **Lint:** `{lint_command}`
- **Build:** `{build_command}`

## PR Template

When creating your PR, use this body structure:

{pr_body_template}

## Instructions

1. Read the `agents/pm-implementer.md` agent definition in the claude-pm plugin for your full procedure
2. Follow the 8-phase execution procedure exactly
3. Use TDD — write failing tests first for each Gherkin scenario
4. Report progress via GitHub Issue comments
5. Return a structured YAML result when done

Begin.
