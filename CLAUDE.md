# CLAUDE.md — claude-pm plugin

## What This Is

A Claude Code plugin that provides GitHub-native project management. It creates wiki PRDs and meta pages, structures versioned epics into GitHub Milestones with story/task sub-issue hierarchies, dispatches parallel implementation agents (each in its own git worktree branching from a feature branch), manages the PR review cycle with polling and micro-retros, and integrates completed work with retrospectives and token-based sizing calibration.

## Plugin Structure

```
claude-pm/
├── .claude-plugin/plugin.json     # Plugin metadata (v0.2.0)
├── hooks/                         # SessionStart hook injects using-pm skill
├── skills/                        # 6 skills: using-pm, pm-structure, pm-dispatch, pm-status, pm-review, pm-integrate
│   ├── using-pm/                  # Gateway router — brainstorming entry, capability detection
│   ├── pm-structure/              # PRD → Wiki + Milestone + Issues + feature branch
│   │   ├── story-template.md      # Product story template
│   │   ├── task-template.md       # Dev task sub-issue template
│   │   ├── bug-template.md        # Bug sub-issue template
│   │   ├── prd-template.md        # Wiki PRD page template
│   │   ├── meta-template.md       # Wiki meta page template
│   │   ├── pr-body-template.md    # PR body template
│   │   └── gherkin-guide.md       # BDD scenario writing guide
│   ├── pm-dispatch/               # Spawn parallel agents on feature branch
│   ├── pm-status/                 # Progress dashboard with sub-issue grouping
│   ├── pm-review/                 # Task PR polling, merge to feature branch, micro-retros
│   └── pm-integrate/              # Feature→main PR, retro, wiki update, calibration
│       └── retro-template.md      # Retrospective wiki page template
├── agents/pm-implementer.md       # Subordinate agent: 10-phase TDD workflow
├── templates/pm-config.yaml       # Configuration schema with sizing buckets
├── CLAUDE.md                      # This file
├── LICENSE                        # MIT
└── README.md                      # User documentation
```

## Skill Flow

```
brainstorming → PRD file
→ claude-pm:pm-structure → Wiki PRD + Meta page + Milestone + Issues + feature branch
→ claude-pm:pm-dispatch → Spawn agents (task branches off feature branch)
→ claude-pm:pm-status (anytime) → Dashboard from GitHub state
→ claude-pm:pm-review → Task PRs reviewed, merged into feature branch, micro-retros
→ claude-pm:pm-integrate → Feature branch → main, retro, wiki update, calibration, close
```

## Key Conventions

1. **GitHub Issues + Wiki are the durable state machine** — all progress survives session crashes
2. **Two-wave PR model** — task PRs → feature branch (wave 1, pm-review), feature → main (wave 2, pm-integrate)
3. **Dependencies encoded as HTML comments** — `<!-- pm:blocked-by #12, #15 -->` and `<!-- pm:parent #10 -->`
4. **Label taxonomy** — `epic:`, `priority:`, `agent:`, `meta:`, `size:`, `status:` prefixes (`:` delimiter)
5. **Versioned epics** — lower-kebab-case naming: `{epic}-v{Major}.{Minor}`
6. **PRD lifecycle** — Draft → In Review → Active → Approved → Superseded
7. **Token-based sizing** — configurable buckets in `.github/pm-config.yaml`, calibrated via retros
8. **Each agent gets its own worktree** — branching from the feature branch, not main

## Prerequisites

- **superpowers plugin** — provides brainstorming, TDD, debugging, worktree, and plan skills
- **GitHub MCP server** — for issue/PR/milestone management
- **gh CLI** — for labels, milestones, wiki, and operations not covered by MCP
- **Wiki enabled** on the GitHub repository

## Skill Reference

| Skill | When to Use |
|-------|------------|
| `claude-pm:using-pm` | Gateway — loaded on session start, kicks off brainstorming, routes to PM skills |
| `claude-pm:pm-structure` | Convert a PRD into Wiki pages + Milestone + Issues + feature branch |
| `claude-pm:pm-dispatch` | Spawn parallel pm-implementer agents for ready issues |
| `claude-pm:pm-status` | View progress dashboard from GitHub state |
| `claude-pm:pm-review` | Poll task PRs for reviews, merge into feature branch, capture micro-retros |
| `claude-pm:pm-integrate` | Merge feature branch to main, create retro, update wiki, calibrate sizing |
