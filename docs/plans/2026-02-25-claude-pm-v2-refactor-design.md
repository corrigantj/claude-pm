# claude-pm v2 Refactor Design

**Date:** 2026-02-25
**Approach:** Evolutionary Refactor (preserve proven dispatch/integrate/status logic, rewrite structure + templates, add pm-review skill)
**Scope:** Full implementation of agile-system-design_4.md, minus GitHub Projects v2 (deferred)

## Decision Log

| Decision | Choice | Rationale |
|----------|--------|-----------|
| Scope | Full implementation in one pass | Complete alignment with design doc |
| GitHub Projects v2 | Deferred | Core state machine (Milestones + Labels + Issues) works independently; Projects v2 is a presentation layer that can be added later without breaking changes |
| Wiki management | Plugin manages wiki repo | Auto-clones, creates/updates pages, commits and pushes |
| Issue Types + Sub-issues | Support both (detect availability) | Detect GitHub Issue Types/Sub-issues; fall back to labels + linked issues |
| PR review workflow | New pm-review skill | Separate skill keeps concerns clean; handles task PR polling + merge into feature branch |
| Wave 2 review (feature→main) | pm-integrate handles it | pm-integrate creates feature→main PR, polls for review, merges on approval |
| Integrate timing | User decides each time | pm-integrate asks whether to merge to main or keep feature branch open for more work |
| meta:mustread | Context document | Injected into agent context chain, not dispatched as work |
| Refactor approach | Evolutionary (A) | Preserves proven DAG/merge/recovery logic; changes content not architecture |

---

## Section 1: Foundation — Config, Labels, Capability Detection

### 1a. Extended pm-config.yaml

```yaml
# Existing (unchanged)
project:
  owner: ""
  repo: ""
  base_branch: ""
agents:
  max_parallel: 3
  model: opus
branches:
  prefix: pm
worktrees:
  directory: .worktrees
merge:
  strategy: squash
  delete_branch: true
commands:
  test: ""
  lint: ""
  build: ""

# NEW sections
wiki:
  directory: .wiki
  auto_clone: true

epics:
  naming: kebab-case

validation:
  enabled: true
  strict: false

review:
  polling_interval: 60
  polling_model: haiku
  require_codeowners: false

sizing:
  metric: tokens
  buckets:
    xs:
      lower: 1000
      upper: 10000
      description: "Trivial change, single file"
    s:
      lower: 10000
      upper: 50000
      description: "Small feature, few files"
    m:
      lower: 50000
      upper: 200000
      description: "Moderate feature, multiple files"
    l:
      lower: 200000
      upper: 500000
      description: "Large feature, significant scope"
    xl:
      lower: 500000
      upper: null
      description: "Must be split — too large for one agent session"

approval_gates:
  before_dispatch: false
  before_merge: false
  before_close_milestone: false
  before_wiki_update: false
```

### 1b. Label Taxonomy

| Namespace | Labels | Colors | Notes |
|-----------|--------|--------|-------|
| `epic:` | `epic:{name}` (dynamic) | Blue | One per epic, applied to ALL tickets across versions |
| `priority:` | `priority:critical`, `priority:high`, `priority:medium`, `priority:low` | Gradient red→yellow | |
| `agent:` | `agent:ready`, `agent:blocked`, `agent:review` | Purple | Agent-specific workflow states |
| `meta:` | `meta:ignore`, `meta:mustread` | Teal | `ignore` = hidden from agents; `mustread` = context document injected into agent context chain |
| `size:` | `size:xs`, `size:s`, `size:m`, `size:l`, `size:xl` | Light blue | Token-based ranges from sizing config |
| `status:` | `status:ready`, `status:in-progress`, `status:in-review`, `status:blocked`, `status:done` | Various | Workflow states |
| `type:` | `type:story`, `type:task`, `type:bug` | Gray | Fallback only — used when GitHub Issue Types unavailable |
| `backlog:` | `backlog:now`, `backlog:next`, `backlog:later`, `backlog:icebox` | Optional | Backlog tiers (optional) |

Delimiter change: `/` → `:` (aligns with design doc, cleaner namespace separator).

### 1c. Capability Detection

Runs once per session, cached in runtime context:

1. **Issue Types** — Check if org repo with Issue Types available; fall back to `type:` labels
2. **Sub-issues** — Check API availability; fall back to `<!-- pm:parent #NN -->` HTML comments + linked issues
3. **Wiki** — Check `has_wiki` field on repo; warn if disabled

---

## Section 2: Wiki Management

### 2a. Wiki Lifecycle

Plugin manages wiki repo as a sibling clone at `{wiki.directory}` (default `.wiki/`).

Operations:
1. **Clone** — `git clone {repo}.wiki.git {wiki_dir}` on first use
2. **Pull** — Before any read/write
3. **Write** — Create/update markdown files
4. **Commit + Push** — After writes (respects `approval_gates.before_wiki_update`)

### 2b. Wiki Page Structure

```
Home.md                              ← Landing page (links to all meta pages + milestones)
{Epic-Name}.md                       ← Meta page (canonical feature state)
PRD-{epic-name}-v{Major}.md          ← Versioned PRD
Retro-{epic-name}-v{X}.{Y}.md       ← Retrospective
_Meta-Template.md                    ← Template (hidden from sidebar)
_PRD-Template.md                     ← Template (hidden from sidebar)
```

### 2c. PRD Lifecycle Status

Status field near top of every PRD wiki page:

```markdown
# PRD: {Epic Name} v{Major}

**Status:** Draft
```

| Status | Meaning | Agent Behavior |
|--------|---------|----------------|
| **Draft** | Actively being written/revised | Free to edit any section |
| **In Review** | Circulated for feedback, structure is stable | Only edit in response to review comments; no structural changes |
| **Active** | Approved and being implemented against | Read-only for requirements. Changelog can be appended for minor clarifications. |
| **Approved** | Scope locked or milestone shipped | **Cannot be modified.** New work must create a new minor or major version PRD. |
| **Superseded** | Replaced by a newer major version | Read-only archival. Header links to successor. |

### 2d. Versioning Convention

Three related names per feature:

| Artifact | Pattern | Example |
|----------|---------|---------|
| Epic label | `epic:{name}` | `epic:auth` |
| PRD wiki page | `PRD-{epic-name}-v{Major}` | `PRD-auth-v1` |
| Milestone | `{epic-name}-v{Major}.{Minor}` | `auth-v1.0` |

Relationships:
- **Major version** = new scope / breaking change → new PRD wiki page
- **Minor version** = incremental addition within same scope → shares PRD, gets own milestone
- PRD titles can be human-friendly; decomposition skill converts to lower-kebab-case
- Always include minor version (v1.0, not v1) for parsing simplicity

Feature branches map to major versions: `feature/{epic}-v{Major}` stays open across minor milestones.

### 2e. Increment Rules

When an agent needs to change requirements on an Active or Approved PRD:
- **Same scope, additive** → New minor milestone under same PRD. Append to Changelog.
- **New scope or breaking change** → New major PRD. Old PRD → Approved or Superseded.
- **Bug or clarification on approved work** → File a bug sub-issue. Don't touch the PRD.

### 2f. Bi-Directional Linking

1. **Wiki → Issues** — Traceability footer in PRD links to milestones and product tickets
2. **Milestone → Wiki** — Description opens with PRD link
3. **Issues → Wiki** — Story template includes PRD and Feature Wiki fields

### 2g. Meta Wiki Page Template

```markdown
# {Epic Name}

## What This Feature Does Today
[2-3 paragraph narrative of production state]

## Architecture Summary
| Aspect | Detail |
|--------|--------|
| Service/Provider | ... |
| Key Patterns | ... |
| Data Models | ... |
| Key Files | ... |
| API Endpoints | ... |
| Config | ... |

## Scope Matrix
| Capability | Status |
|------------|--------|
| ... | In production / Planned / Out of scope |

## Version History
| Version | Milestone | PRD | Status | Date |
|---------|-----------|-----|--------|------|

## Key Decisions Log
| Decision | Rationale | ADR | Date |
|----------|-----------|-----|------|

## Dependencies on Other Epics
| Epic | Nature | Issues |
|------|--------|--------|

## Known Limitations & Tech Debt
- ...
```

### 2h. PRD Wiki Page Template

Sections are flexible. Only Background, Functional Requirements, and Traceability are mandatory.

```markdown
# PRD: {Epic Name} v{Major}

**Status:** Draft

## Table of Contents

## Background
[User research, business context, core issues]

## Objectives
[Goals with success metrics]

## Target Users
[Personas]

## Scope Matrix
| Capability | User Type A | User Type B | In/Out |
|------------|-------------|-------------|--------|

## Functional Requirements
[Mapped to product tickets — each requirement becomes a story]

## Non-Functional Requirements
[Performance, security, accessibility, scalability, compliance — as applicable]

## Dependencies & Risks
[External dependencies, risks with mitigations]

## Open Questions
[Unresolved items — consult CODEOWNERS for routing]

## Changelog
| Version | Date | Changes |
|---------|------|---------|
| v{Major}.0 | ... | Initial |

## Traceability
| Artifact | Link |
|----------|------|
| Meta Page | [{Epic Name}]({Epic-Name}) |
| Milestone | [milestone](../../milestone/{N}) |
| Product Tickets | #XX, #YY |
```

---

## Section 3: Issue Hierarchy — Stories, Tasks, Bugs

### 3a. Hierarchy

```
Product Ticket (Story)
├── Dev Task          (sub-issue)
├── Dev Task          (sub-issue)
└── Bug               (sub-issue)
```

With Issue Types: native story/task/bug types + Sub-issues.
Fallback: `type:` labels + `<!-- pm:parent #NN -->` HTML comment in child + task list in parent.

### 3b. Story Template

```markdown
**PRD:** [PRD-{epic}-v{X}](../../wiki/PRD-{epic}-v{X})
**Feature Wiki:** [{Epic Name}](../../wiki/{Epic-Name})

## User Story
As [persona], I want [action] so that [outcome].

## Context
[Why this matters — user pain, business value. 2-3 sentences.]

## Acceptance Criteria

**S1: [Scenario name]**
- Given [precondition]
- When [action]
- Then [expected result]
- Verify: [how to confirm]

**S2: [Scenario name]**
- Given ...
- When ...
- Then ...
- Verify: ...

## Definition of Done
- [ ] All scenarios passing
- [ ] Tests written for each scenario
- [ ] No regressions in existing tests
- [ ] PR approved

## Agent Instructions
<!-- Optional — tech stack, key files, constraints, edge cases -->

## Scenario Acceptance Tracker
| Scenario | Status | Task/Bug | Date | Notes |
|----------|--------|----------|------|-------|
| S1 | - | - | - | - |
| S2 | - | - | - | - |
```

### 3c. Dev Task Template

```markdown
**Parent:** #{parent_issue_number}
**Scenarios:** S1, S2a

## Objective
[One sentence: what does this task produce?]

## Implementation Notes
[File paths, function signatures, architectural decisions, constraints]

## Done When
- [ ] [Concrete, verifiable checklist item]
- [ ] [...]
- [ ] Tests pass for addressed scenarios
```

### 3d. Bug Template

```markdown
**Parent:** #{parent_issue_number}
**Failing Scenario:** S2

## Environment
[Branch, commit, platform]

## Observed Behavior
[What actually happens — logs/error messages]

## Expected Behavior
[What should happen — copy relevant scenario inline]

## Reproduction Steps
1. [Numbered steps agents can follow]
2. ...

## Fix Guidance
<!-- Optional — key files, likely fix, regression risk -->
```

### 3e. Dependency Encoding

Between stories: `<!-- pm:blocked-by #12, #15 -->`
Parent-child (fallback): `<!-- pm:parent #10 -->`

---

## Section 4: Evolved Skills

### Flow

```
claude-pm:using-pm (mount PM skillset)
→ brainstorming (design the feature)
→ claude-pm:pm-structure (PRD wiki + Meta page + Milestone + Stories + Tasks + feature branch)
→ claude-pm:pm-dispatch (spawn agents, task branches off feature branch)
→ claude-pm:pm-status (anytime — dashboard)
→ claude-pm:pm-review (poll task PRs, merge into feature branch, capture micro-retros)
→ claude-pm:pm-integrate (feature→main PR, poll review, merge, full retro, wiki update, close)
```

### 4a. using-pm (Gateway Router)

Changes:
- Kicks off brainstorming as first step for new features
- Routes in correct order: structure → dispatch → status → review → integrate
- Consistent self-referencing: `claude-pm:pm-{skill}`
- Capability detection and wiki clone on first invocation

### 4b. pm-structure (PRD → GitHub Artifacts)

Major rewrite. New steps:

1. Parse PRD file
2. Read config + wiki settings
3. Convert naming (PRD title → lower-kebab-case)
4. **Validate inputs** (pre-creation validation on all artifact content)
5. Create/update wiki (Meta page if first version, PRD page with Status: Draft)
6. Create epic label
7. Create label taxonomy (new `:` delimiter, capability-aware type labels)
8. Create milestone (PRD link + feature branch name in description)
9. **Create feature branch** (`feature/{epic}-v{Major}` off base branch)
10. Create stories (new template, epic + priority + size labels)
11. Create dev tasks (sub-issues or linked issues with fallback)
12. Annotate dependencies (`<!-- pm:blocked-by -->`)
13. **Post-creation validation** (confirmation pass)
14. Update PRD status → Active
15. Present summary (dependency graph, ready/blocked lists, wiki links)

### 4c. pm-dispatch (Spawn Agents)

Moderate update:
- Task branches off **feature branch** (not base): `pm/{issue}-{slug}` from `feature/{epic}-v{Major}`
- `meta:mustread` issues injected into agent context chain (not dispatched)
- `meta:ignore` issues fully skipped
- New label namespaces
- Token-based sizing: prefer smaller tasks first when priorities equal
- CODEOWNERS lookup if configured
- Agent prompt references full context chain: meta wiki → PRD → mustread issues → story → task

### 4d. pm-status (Dashboard)

Moderate update:
- New label namespaces
- Sub-issue grouping (stories with nested tasks/bugs)
- Scenario acceptance tracker status per story
- Lessons comment count per story
- Wiki links in output
- Recovery still works from GitHub state alone

### 4e. pm-review (NEW — Task PR Review Loop)

Handles **wave 1** (task PRs → feature branch):

1. Identify open task PRs targeting the feature branch
2. Spawn polling sub-agent (haiku) to watch for review activity
3. On activity — pull review comments, return to main agent
4. Address feedback — make code changes, push updated commits
5. On approval — merge task PR into feature branch (rebase)
6. Capture micro-retro — lessons-learned comment on task PR (what went well/wrong, estimated vs actual tokens, surprises, patterns, pitfalls)
7. Check for next batch — after merging, check if new tasks are unblocked (may trigger another pm-dispatch round)

### 4f. pm-integrate (Merge & Close)

Handles **wave 2** (feature branch → main) plus finalization:

1. Pre-integration audit — verify all task PRs merged into feature branch, all scenario trackers passing
2. Create feature PR — `feature/{epic}-v{Major}` → base branch
3. Optional approval gate
4. Poll for review — same polling mechanism targeting feature→main PR
5. On approval — merge (user-configured strategy)
6. Post-merge test verification
7. **Ask user: close milestone or keep feature branch for more work?**
   - If close: proceed to 8-12
   - If keep open: stop (user will dispatch again for next minor)
8. Collect micro-retros from all task PRs
9. Create full retro wiki page (`Retro-{epic}-v{X}.{Y}.md`) — first draft focuses on process success, can be updated later
10. Update meta wiki page (feature state, scope matrix, version history)
11. Update PRD status → Approved
12. **Create sizing calibration PR** — tabulate estimated vs actual tokens, propose bucket adjustments to `pm-config.yaml`
13. Close milestone

### 4g. pm-implementer (Agent Template)

Rewritten 10-step workflow:

1. Check Agent Queue for `agent:ready` tickets
2. Read full context chain: meta wiki → PRD → `meta:mustread` issues → story → task
3. Create branch off feature branch: `{prefix}/{issue}-{slug}`
4. Implement against "Done When" checklist (TDD)
5. Run tests, commit, open PR **targeting feature branch**
6. Move ticket to `agent:review`
7. Update Scenario Acceptance Tracker on parent story
8. Append lessons-learned comment (token calibration: estimated vs actual)
9. File bug sub-issue if bugs found during implementation
10. Return structured YAML result

---

## Section 5: Validation & Linting

### Pre-Creation Validation (Measure Twice, Cut Once)

Validation runs **before** submitting artifacts to GitHub:

```
Build artifact content locally
→ Validate against required fields
→ Fix any failures
→ Loop until clean
→ Submit to GitHub
→ Lightweight confirmation pass (verify submission matched intent)
```

### What Gets Validated

| Artifact | Required Fields |
|----------|----------------|
| Story | PRD link, Feature Wiki link, User Story, at least one scenario (S1+), Definition of Done |
| Dev Task | Parent link, Scenarios Addressed, Objective, Done When checklist |
| Bug | Parent link, Failing Scenario, Observed Behavior, Expected Behavior, Reproduction Steps |
| PRD wiki page | Status field, Background, Functional Requirements, Traceability |
| Meta wiki page | "What This Feature Does Today", Version History table |
| Milestone | PRD link in description, feature branch name |
| Labels | Follow namespace taxonomy |

### Immutability Enforcement

Validation blocks modifications to published/terminal-state artifacts:

| Artifact | Immutable When |
|----------|---------------|
| PRD wiki page | Status is Approved or Superseded |
| Milestone | Closed |
| Closed issues/PRs | Cannot be reopened or edited by agents |
| ADRs | Status is Accepted, Rejected, or Superseded |

Agent is directed to create a new version instead.

### Implementation

Embedded validation step in pm-structure (creation) and pm-review/pm-integrate (updates). Not a separate skill — a shared checklist invoked inline.

---

## Section 6: ADRs in GitHub Discussions

### Storage

GitHub Discussions with a Decisions/ADR category. Sequential numbering: ADR-001, ADR-002, etc. Never reused.

### Lifecycle

```
Proposed → In Review → Accepted    → Superseded (optional)
                     → Rejected
```

| Status | Meaning | Mutability |
|--------|---------|------------|
| **Proposed** | Drafted, open for comments | Editable |
| **In Review** | Actively discussed | Editable with caution |
| **Accepted** | Ratified and in effect | Immutable. Supersede with new ADR if circumstances change. |
| **Rejected** | Considered and declined | Immutable. Preserves reasoning. |
| **Superseded** | Replaced by newer ADR | Immutable. Links to successor. |

Conversation happens as replies. Closing the discussion = terminal state.

### Format (Nygaard)

```markdown
# ADR-NNN: [Decision Title]

**Status:** Proposed

## Context
[What issue motivated this decision]

## Decision
[What we decided to do]

## Consequences
[What becomes easier or harder as a result]
```

### Integration

- Meta wiki pages link to relevant ADRs in Key Decisions Log
- PRDs reference ADRs in Related ADRs section
- Agents creating ADRs during implementation add them as comments on relevant story

---

## Section 7: Token-Based Sizing & Calibration

### Sizing Configuration

Defined in `pm-config.yaml` under `sizing.buckets`. Each bucket has lower/upper bounds and a description. Agents reference this when estimating task size.

### Calibration Flow

1. **Estimation** (pm-structure) — Read sizing config, evaluate task scope, assign `size:` label
2. **Recording** (pm-implementer) — Record actual token consumption in lessons comment
3. **Tabulation** (pm-integrate) — Aggregate estimated vs actual across milestone
4. **Calibration PR** (pm-integrate) — Propose bucket adjustments to `pm-config.yaml` with full evidence table

### Lessons Comment Format

```markdown
## Lessons Learned
- **Estimated size:** size:s (~10-50K tokens)
- **Actual tokens:** ~32K
- **Surprises:** [what differed from expectations]
- **Patterns:** [reusable insights]
- **Pitfalls:** [what to avoid next time]
```

### Calibration PR Format

```markdown
## Sizing Calibration: {epic}-v{X}.{Y}

### Task Data
| Task | Estimated | Actual Tokens | Delta |
|------|-----------|---------------|-------|
| #14  | size:s    | 62,340        | +24%  |
| #15  | size:m    | 48,100        | -52%  |

### Recommended Changes
| Bucket | Current Range | Proposed Range | Reason |
|--------|--------------|----------------|--------|
| size:s | 10K-50K      | 10K-75K        | 8/12 tasks exceeded upper bound |
| size:m | 50K-200K     | 75K-200K       | Lower bound adjusted to match |
```

Human reviews and approves before next project. Sizing system is self-correcting.

---

## Section 8: CODEOWNERS Integration

| When | How |
|------|-----|
| PR creation | Auto-assign reviewers based on files changed |
| Open questions in PRD | Route to owner of affected code area |
| Architecture changes | Notify owners of affected areas |
| pm-review/pm-integrate polling | Check for CODEOWNERS approval (if `review.require_codeowners` is true) |

Read CODEOWNERS from repo root or `.github/CODEOWNERS`. If no file exists, skip.

---

## Section 9: Backlog Management

Guidance encoded into pm-structure and pm-status, not a separate skill.

### Grooming Checklist

Each story should have: clear user story, PRD link, BDD acceptance criteria, size label, priority label, epic label + milestone, agent instructions if assignable.

### Backlog Tiers (Optional)

| Tier | Meaning |
|------|---------|
| `backlog:now` | Ready for next dispatch cycle |
| `backlog:next` | 1-2 cycles out, needs grooming |
| `backlog:later` | On roadmap, not yet scoped |
| `backlog:icebox` | Parked, revisit periodically |

Tracked via labels since Projects v2 is deferred.

---

## Section 10: Updated File Structure

```
claude-pm/
├── .claude-plugin/plugin.json           # Updated metadata
├── hooks/
│   ├── hooks.json                       # Same trigger
│   └── session-start.sh                 # Injects updated using-pm
├── skills/
│   ├── using-pm/
│   │   └── SKILL.md                     # Updated: brainstorming entry, routing, capability detection
│   ├── pm-structure/
│   │   ├── SKILL.md                     # Major rewrite
│   │   ├── story-template.md            # NEW (replaces issue-body-template.md)
│   │   ├── task-template.md             # NEW
│   │   ├── bug-template.md              # NEW
│   │   ├── prd-template.md              # NEW
│   │   ├── meta-template.md             # NEW
│   │   ├── pr-body-template.md          # Updated
│   │   └── gherkin-guide.md             # Retained, minor updates
│   ├── pm-dispatch/
│   │   ├── SKILL.md                     # Updated: feature branch, mustread, new labels
│   │   └── implementer-prompt.md        # Updated: feature branch target, context chain
│   ├── pm-status/
│   │   └── SKILL.md                     # Updated: sub-issues, new labels, wiki links
│   ├── pm-review/                       # NEW skill
│   │   └── SKILL.md                     # Task PR polling, merge to feature branch, micro-retros
│   └── pm-integrate/
│       ├── SKILL.md                     # Updated: feature→main PR, wave 2, retro, calibration
│       └── retro-template.md            # NEW
├── agents/
│   └── pm-implementer.md               # Rewritten: 10-step, feature branch, lessons, calibration
├── templates/
│   └── pm-config.yaml                  # Extended with wiki, epics, validation, review, sizing
├── CLAUDE.md                           # Updated
├── README.md                           # Updated
└── LICENSE                             # Unchanged
```

Removed: `skills/pm-structure/issue-body-template.md` (replaced by story/task/bug templates)
