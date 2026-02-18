# CLAUDE.md — claude-pm plugin

## What This Is

A Claude Code plugin that provides GitHub Issues-based project management. It turns PRDs into GitHub Milestones + Issues, dispatches parallel pm-implementer agents (each in its own git worktree), tracks progress via a dashboard, and merges PRs in dependency order.

## Plugin Structure

```
claude-pm/
├── .claude-plugin/plugin.json   # Plugin metadata
├── hooks/                       # SessionStart hook injects using-pm skill
├── skills/                      # 5 skills: using-pm, pm-structure, pm-dispatch, pm-status, pm-integrate
├── agents/pm-implementer.md     # Subordinate agent spawned per issue
├── templates/pm-config.yaml     # Default configuration template
├── CLAUDE.md                    # This file
├── LICENSE                      # MIT
└── README.md                    # User documentation
```

## Skill Flow

```
brainstorming → PRD file → pm:structure → GitHub Milestone + Issues
→ pm:dispatch → Spawn pm-implementer agents (each in own worktree)
→ pm:status (anytime) → Progress dashboard from GitHub
→ pm:integrate → Merge PRs in dependency order → Close milestone
```

## Key Conventions

1. **GitHub Issues are the durable state machine** — all progress survives session crashes
2. **Dependencies encoded as HTML comments** — `<!-- pm:blocked-by #12, #15 -->` in issue body
3. **Label taxonomy** — `type/`, `size/`, `status/`, `priority/` prefixes
4. **Each agent gets its own worktree** — no shared working directory
5. **Configuration via `.github/pm-config.yaml`** — see `templates/pm-config.yaml` for schema

## Prerequisites

- **superpowers plugin** — provides brainstorming, TDD, debugging, worktree, and plan skills
- **GitHub MCP server** — for issue/PR/milestone management
- **gh CLI** — for operations not covered by MCP (label creation, milestone management)

## Skill Reference

| Skill | When to Use |
|-------|------------|
| `claude-pm:using-pm` | Gateway — loaded on session start, routes to other PM skills |
| `claude-pm:pm-structure` | Convert a PRD into GitHub Milestone + Issues |
| `claude-pm:pm-dispatch` | Spawn parallel pm-implementer agents for ready issues |
| `claude-pm:pm-status` | View progress dashboard from GitHub state |
| `claude-pm:pm-integrate` | Merge completed PRs in dependency order, close milestone |
