---
name: using-pm
description: Use when managing multi-issue projects — mounts PM capabilities, routes to brainstorming for new work, then PM skills for structuring, dispatching, reviewing, and integrating
---

# Project Management with claude-pm

You have project management capabilities. When the user's task involves planning, decomposing, tracking, or delivering a multi-issue project, use the PM skills below.

## Prerequisites

Before using PM skills, verify:
1. **superpowers plugin** is installed (provides brainstorming, TDD, worktrees, plans)
2. **GitHub MCP server** is available (test: can you call `mcp__github__get_me`?)
3. **gh CLI** is available and authenticated (test: `gh auth status`)
4. **Repository has a GitHub remote** (PM skills create GitHub Issues, Milestones, PRs)
5. **Wiki enabled** — run `gh api repos/{owner}/{repo} --jq '.has_wiki'` and confirm it returns `true`

## Capability Detection

On first invocation of any PM skill in a session, detect and cache these capabilities for the rest of the session:

| Capability | How to Detect | Fallback |
|---|---|---|
| **Issue Types** | Org-owned repo: attempt `gh api repos/{owner}/{repo}/issue-types`; 200 = available | Skip issue type assignment |
| **Sub-issues API** | Test `gh api repos/{owner}/{repo}/issues/1/sub_issues` (404 is fine, check for 422 vs 404) | Use `<!-- pm:blocked-by -->` comments for dependencies |
| **Wiki enabled** | `gh api repos/{owner}/{repo} --jq '.has_wiki'` returns `true` | Warn user; PRD storage falls back to `docs/plans/` |

Store results so subsequent skill invocations within the same session skip re-detection.

## Skill Table

| User Intent | Skill | When |
|---|---|---|
| New feature / project / "plan this" | `superpowers:brainstorming` then `claude-pm:pm-structure` | Always start with brainstorming for new work, then structure |
| "Break this down" / has a PRD | `claude-pm:pm-structure` | Convert PRD into Wiki page + Milestone + Issues + feature branch |
| "Start working" / "Dispatch" | `claude-pm:pm-dispatch` | Spawn parallel agents, task branches off feature branch |
| "What's the status?" | `claude-pm:pm-status` | Dashboard from GitHub state (anytime, crash recovery) |
| "Review PRs" / "Check feedback" | `claude-pm:pm-review` | Poll task PRs, merge into feature branch, capture micro-retros |
| "Merge" / "Ship it" / "Integrate" | `claude-pm:pm-integrate` | Feature branch to main PR, retro, wiki update, close milestone |

## The Flow

```
1. brainstorming → PRD file (use superpowers:brainstorming)
2. claude-pm:pm-structure → Wiki PRD + Meta page + Milestone + Issues + feature branch
3. claude-pm:pm-dispatch → Spawn agents (task branches off feature branch)
4. claude-pm:pm-status → Progress dashboard (run anytime, crash recovery)
5. claude-pm:pm-review → Task PRs reviewed, merged into feature branch, micro-retros
6. claude-pm:pm-integrate → Feature branch → main PR, retro, wiki update, close milestone
```

## Configuration

PM skills read `.github/pm-config.yaml` from the project root. If absent, sensible defaults apply. The file is optional.

Key configuration sections:
- **wiki** — PRD storage format, meta-page template, auto-publish settings
- **sizing** — Token-based bucket definitions (XS/S/M/L/XL thresholds and parallelism limits)
- **review** — Polling interval, auto-merge criteria, micro-retro format
- **validation** — Pre-dispatch checks, acceptance criteria enforcement, PR quality gates

See `templates/pm-config.yaml` in this plugin for the full schema and defaults.

## When to Route to PM Skills

**Use PM skills when:**
- The user has a PRD or design doc to implement
- Work involves 3+ distinct issues or features
- Parallel agent execution would save time
- The user asks about project status or wants to merge completed work
- The user asks to review PRs or check feedback on task branches

**Don't use PM skills when:**
- Single-issue work that doesn't need decomposition (one bug fix, one feature file)
- User wants to implement something directly without multi-issue planning
- No GitHub remote configured

## Recovery

If a session crashes mid-project, run `claude-pm:pm-status` in a new session. It reconstructs full project state from GitHub Issues and PRs — no context lost.
