# CLAUDE.md — limbic plugin

## What This Is

A Claude Code plugin that provides GitHub-native project management. It creates wiki PRDs and meta pages, structures versioned epics into GitHub Milestones with story/task sub-issue hierarchies, dispatches parallel implementation agents (each in its own git worktree branching from a feature branch), manages the PR review cycle with polling and lessons learned, and integrates completed work with retrospectives and token-based sizing calibration.

## Plugin Structure

```
limbic/
├── .claude-plugin/plugin.json     # Plugin metadata (v0.2.0)
├── hooks/                         # SessionStart hook loads using-limbic (gateway that routes to all other skills)
├── skills/                        # 6 skills: using-limbic, structure, dispatch, status, review, integrate
│   ├── using-limbic/              # Gateway router — brainstorming entry, capability detection
│   ├── structure/                 # PRD → Wiki + Milestone + Issues + feature branch
│   │   ├── story-template.md      # Product story template
│   │   ├── task-template.md       # Dev task sub-issue template
│   │   ├── bug-template.md        # Bug sub-issue template
│   │   ├── prd-template.md        # Wiki PRD page template
│   │   ├── meta-template.md       # Wiki meta page template
│   │   ├── pr-body-template.md    # PR body template
│   │   └── gherkin-guide.md       # BDD scenario writing guide
│   ├── dispatch/                  # Spawn parallel agents on feature branch
│   ├── status/                    # Progress dashboard with sub-issue grouping
│   ├── review/                    # Task PR polling, merge to feature branch, lessons learned
│   │   └── polling-prompt.md      # Polling sub-agent prompt template
│   └── integrate/                 # Feature→main PR, retro, wiki update, calibration
│       └── retro-template.md      # Retrospective wiki page template
├── agents/implementer.md          # Subordinate agent: 9-phase TDD workflow
├── templates/limbic.yaml          # Configuration schema with sizing buckets
├── CLAUDE.md                      # This file
├── LICENSE
└── README.md
```

## Skill Flow

```
brainstorming → PRD file
→ limbic:structure → Wiki PRD + Meta page + Milestone + Issues + feature branch
→ limbic:dispatch → Spawn agents (task branches off feature branch)
→ limbic:status (anytime) → Dashboard from GitHub state
→ limbic:review → Task PRs reviewed, merged into feature branch, lessons learned
→ limbic:integrate → Feature branch → main, retro, wiki update, calibration, close
```

## Key Conventions

1. **GitHub Issues + Wiki are the durable state machine** — all progress survives session crashes
2. **Two-wave PR model** — task PRs → feature branch (wave 1, review), feature → main (wave 2, integrate)
3. **Dependencies encoded as HTML comments** — `<!-- limbic:blocked-by #12, #15 -->` and `<!-- limbic:parent #10 -->`
4. **Label taxonomy** — `epic:`, `priority:`, `meta:`, `size:`, `status:` prefixes (`:` delimiter)
5. **Versioned epics** — lower-kebab-case naming: `{epic}-v{Major}.{Minor}`
6. **PRD lifecycle** — Draft → In Review → Active → Approved → Superseded
7. **Token-based sizing** — configurable buckets in `.github/limbic.yaml`, calibrated via retros
8. **Each agent gets its own worktree** — branching from the feature branch, not main

## Prerequisites

- **superpowers plugin** — provides brainstorming, TDD, debugging, worktree, and plan skills
- **GitHub MCP server** — for issue/PR/milestone management
- **gh CLI** — for labels, milestones, wiki, and operations not covered by MCP
- **Wiki enabled** on the GitHub repository

## Skill Reference

| Skill | When to Use |
|-------|------------|
| `limbic:using-limbic` | Gateway — loaded on session start, kicks off brainstorming, routes to PM skills |
| `limbic:structure` | Convert a PRD into Wiki pages + Milestone + Issues + feature branch |
| `limbic:dispatch` | Spawn parallel implementer agents for ready issues |
| `limbic:status` | View progress dashboard from GitHub state |
| `limbic:review` | Poll task PRs for reviews, merge into feature branch, capture lessons learned |
| `limbic:integrate` | Merge feature branch to main, create retro, update wiki, calibrate sizing |
