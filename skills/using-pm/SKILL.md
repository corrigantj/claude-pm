---
name: using-pm
description: Use when managing multi-issue projects — routes to PM skills for structuring PRDs into GitHub Issues, dispatching parallel agents, tracking progress, and integrating completed work
---

# Project Management with claude-pm

You have project management capabilities. When the user's task involves planning, decomposing, tracking, or delivering a multi-issue project, use the PM skills below.

## Prerequisites

Before using PM skills, verify:
1. **superpowers plugin** is installed (provides brainstorming, TDD, worktrees, plans)
2. **GitHub MCP server** is available (test: can you call `mcp__github__get_me`?)
3. **gh CLI** is available (test: `gh auth status`)
4. **Repository has a remote** (PM skills create GitHub Issues, Milestones, PRs)

## Skill Table

| User Intent | Skill to Invoke | When |
|---|---|---|
| "Plan this project" / "Break this down" / has a PRD | `claude-pm:pm-structure` | Convert PRD → GitHub Milestone + Issues with dependencies |
| "Start working" / "Dispatch agents" / "Build this" | `claude-pm:pm-dispatch` | Spawn parallel pm-implementer agents for ready issues |
| "What's the status?" / "Show progress" | `claude-pm:pm-status` | Dashboard from GitHub Issue/PR state |
| "Merge everything" / "Integrate" / "Ship it" | `claude-pm:pm-integrate` | Merge PRs in dependency order, close milestone |

## The Flow

```
1. brainstorming → PRD file (use superpowers:brainstorming, save to docs/plans/)
2. pm:structure  → GitHub Milestone + Issues (with Gherkin acceptance criteria)
3. pm:dispatch   → Spawn agents in worktrees (batched by dependency + parallelism)
4. pm:status     → Progress dashboard (run anytime, recovers from session crashes)
5. pm:integrate  → Merge PRs in order → Close milestone → Done
```

## Configuration

PM skills read `.github/pm-config.yaml` from the project root. If absent, defaults apply:
- `max_parallel: 3` agents
- `branches.prefix: pm`
- `merge.strategy: squash`
- All approval gates off

See `templates/pm-config.yaml` in this plugin for the full schema.

## When to Route to PM Skills

**Use PM skills when:**
- The user has a PRD or design doc to implement
- Work involves 3+ distinct issues or features
- Parallel agent execution would save time
- The user asks about project status or wants to merge completed work

**Don't use PM skills when:**
- Single file change or bug fix
- User wants to implement something directly (no decomposition needed)
- No GitHub remote configured

## Recovery

If a session crashes mid-project, run `pm:status` in a new session. It reconstructs full project state from GitHub Issues and PRs — no context lost.
