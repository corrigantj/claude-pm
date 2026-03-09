---
name: using-limbic
description: Use when managing multi-issue projects — mounts PM capabilities, routes to brainstorming for new work, then PM skills for structuring, dispatching, reviewing, and integrating
---

# Project Management with limbic

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
| **Sub-issues API** | Test `gh api repos/{owner}/{repo}/issues/1/sub_issues` (404 is fine, check for 422 vs 404) | Use `<!-- limbic:blocked-by -->` comments for dependencies |
| **Wiki enabled** | `gh api repos/{owner}/{repo} --jq '.has_wiki'` returns `true` | Warn user; PRD storage falls back to `docs/plans/` |

Store results so subsequent skill invocations within the same session skip re-detection.

## Skill Table

| User Intent | Skill | When |
|---|---|---|
| New feature / project / "plan this" | `superpowers:brainstorming` then `limbic:structure` | Always start with brainstorming for new work, then structure |
| "Break this down" / has a PRD | `limbic:structure` | Convert PRD into Wiki page + Milestone + Issues + feature branch |
| "Start working" / "Dispatch" | `limbic:dispatch` | Spawn parallel agents, task branches off feature branch |
| "What's the status?" | `limbic:status` | Dashboard from GitHub state (anytime, crash recovery) |
| "Review PRs" / "Check feedback" | `limbic:review` | Poll task PRs, merge into feature branch, capture lessons learned |
| "Merge" / "Ship it" / "Integrate" | `limbic:integrate` | Feature branch to main PR, retro, wiki update, close milestone |

## The Flow

```
1. brainstorming → PRD file (use superpowers:brainstorming)
2. limbic:structure → Wiki PRD + Meta page + Milestone + Issues + feature branch
3. limbic:dispatch → Spawn agents (task branches off feature branch)
4. limbic:status → Progress dashboard (run anytime, crash recovery)
5. limbic:review → Task PRs reviewed, merged into feature branch, lessons learned
6. limbic:integrate → Feature branch → main PR, retro, wiki update, close milestone
```

## Configuration

PM skills read `.github/limbic.yaml` from the project root. If absent, sensible defaults apply. The file is optional.

Key configuration sections:
- **wiki** — PRD storage format, meta-page template, auto-publish settings
- **sizing** — Token-based bucket definitions (XS/S/M/L/XL thresholds and parallelism limits)
- **review** — Polling interval, auto-merge criteria, lessons learned format
- **validation** — Pre-dispatch checks, acceptance criteria enforcement, PR quality gates

See `templates/limbic.yaml` in this plugin for the full schema and defaults.

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

If a session crashes mid-project, run `limbic:status` in a new session. It reconstructs full project state from GitHub Issues and PRs — no context lost.
