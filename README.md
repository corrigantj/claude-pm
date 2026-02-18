# claude-pm

GitHub Issues-based project management for Claude Code. Turn PRDs into GitHub Milestones + Issues, dispatch parallel implementation agents (each in its own git worktree), track progress via a live dashboard, and merge PRs in dependency order.

## How It Works

1. **You brainstorm** a design and save it as a PRD
2. **`pm:structure`** converts the PRD into a GitHub Milestone with Issues (Gherkin acceptance criteria, dependency annotations, T-shirt sizing)
3. **`pm:dispatch`** spawns parallel pm-implementer agents — each in its own worktree, implementing with TDD, creating PRs
4. **`pm:status`** shows a live dashboard from GitHub state (works across session crashes)
5. **`pm:integrate`** merges PRs in dependency order with test verification between each merge, then closes the milestone

GitHub Issues are the durable state machine — session crashes are fully recoverable.

## Prerequisites

- [superpowers](https://github.com/obra/superpowers) plugin installed (provides brainstorming, TDD, worktrees, debugging)
- GitHub MCP server configured (for issue/PR/milestone management)
- `gh` CLI authenticated (`gh auth status`)
- A repository with a GitHub remote

## Installation

### Claude Code (via Plugin Marketplace)

```bash
/plugin install claude-pm
```

### Manual Installation

Clone this repository and register it as a Claude Code plugin:

```bash
git clone https://github.com/traviscorrigan/claude-pm.git
cd your-project
# Add to your project's .claude/plugins or global plugins
```

## Quick Start

### 1. Create a PRD

Use superpowers brainstorming to design your project, then save to `docs/plans/`:

```
Let's brainstorm a user authentication system
```

### 2. Structure into GitHub Issues

```
Use pm:structure to break down docs/plans/auth-system.md
```

This creates:
- A GitHub Milestone
- Issues with Gherkin acceptance criteria and dependency annotations
- Labels (`type/`, `size/`, `status/`, `priority/`)

### 3. Dispatch Implementation Agents

```
Use pm:dispatch to start implementing
```

This spawns parallel agents (default: 3), each:
- Working in its own git worktree
- Following TDD (tests first from Gherkin scenarios)
- Creating a PR when done

### 4. Check Progress

```
What's the project status?
```

Dashboard shows: progress bar, issue categorization, CI status, blockers, next actions.

### 5. Merge and Ship

```
Use pm:integrate to merge everything
```

Merges PRs in topological order, verifies tests after each merge, closes the milestone.

## Configuration

Create `.github/pm-config.yaml` in your project repository:

```yaml
# Agent execution
agents:
  max_parallel: 3    # Max concurrent agents
  model: opus        # Model for agents

# Branch naming
branches:
  prefix: pm         # Branches: pm/{issue}-{slug}

# Worktree management
worktrees:
  directory: .worktrees

# Approval gates
approval_gates:
  before_dispatch: false
  before_merge: false
  before_close_milestone: false

# Merge strategy
merge:
  strategy: squash   # squash | merge | rebase
  delete_branch: true

# Build commands (auto-detected if omitted)
commands:
  test: ""
  lint: ""
  build: ""
```

All values have sensible defaults. The file is optional.

## Skill Reference

| Skill | Purpose |
|-------|---------|
| `claude-pm:using-pm` | Gateway — routes to PM skills based on intent |
| `claude-pm:pm-structure` | Convert PRD → GitHub Milestone + Issues |
| `claude-pm:pm-dispatch` | Spawn parallel agents for ready issues |
| `claude-pm:pm-status` | Live progress dashboard from GitHub |
| `claude-pm:pm-integrate` | Merge PRs in dependency order |

## Architecture

**State machine:** GitHub Issues (labels track status: `ready` → `in-progress` → `in-review` → `done`)

**Dependencies:** HTML comments in issue bodies: `<!-- pm:blocked-by #12, #15 -->` — machine-parseable, invisible to readers

**Parallelism:** Each agent gets its own git worktree and branch. File overlap detection prevents merge conflicts.

**Recovery:** `pm:status` reconstructs full project state from GitHub. No conversation memory needed.

**Context budget:** The coordinator session stays under ~113k/200k tokens for a 10-issue project. Each agent gets its own fresh 200k window.

## Plugin Structure

```
claude-pm/
├── .claude-plugin/plugin.json   # Plugin metadata
├── hooks/
│   ├── hooks.json               # SessionStart hook registration
│   └── session-start.sh         # Injects using-pm skill on startup
├── skills/
│   ├── using-pm/SKILL.md        # Gateway skill
│   ├── pm-structure/
│   │   ├── SKILL.md             # PRD → Issues process
│   │   ├── issue-body-template.md
│   │   ├── pr-body-template.md
│   │   └── gherkin-guide.md
│   ├── pm-dispatch/
│   │   ├── SKILL.md             # Agent dispatch process
│   │   └── implementer-prompt.md
│   ├── pm-status/SKILL.md       # Progress dashboard
│   └── pm-integrate/SKILL.md    # Merge + close process
├── agents/
│   └── pm-implementer.md        # Implementation agent definition
├── templates/
│   └── pm-config.yaml           # Default configuration
├── CLAUDE.md
├── LICENSE
└── README.md
```

## License

MIT
