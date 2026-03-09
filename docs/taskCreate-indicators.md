# Customizing In-Progress Spinner Text with TaskCreate

## How It Works

When a skill includes a checklist and instructs Claude to create tasks, Claude calls the `TaskCreate` tool for each item. The `activeForm` parameter on `TaskCreate` controls the spinner/status text shown in the CLI while that task is in progress.

## The Mechanism

1. A skill's checklist says something like: *"You MUST create a task for each of these items"*
2. Claude calls `TaskCreate` for each item with:
   - `subject`: imperative form (e.g., "Explore project context")
   - `activeForm`: present continuous form (e.g., "Exploring project context")
3. When the task is set to `in_progress` via `TaskUpdate`, the `activeForm` text is displayed as the spinner/status message in the CLI

## Example: Brainstorming Skill

The `superpowers:brainstorming` skill includes this checklist:

```markdown
## Checklist

You MUST create a task for each of these items and complete them in order:

1. **Explore project context** — check files, docs, recent commits
2. **Ask clarifying questions** — one at a time, understand purpose/constraints/success criteria
3. **Propose 2-3 approaches** — with trade-offs and your recommendation
4. **Present design** — in sections scaled to their complexity, get user approval after each section
5. **Write design doc** — save to `docs/plans/YYYY-MM-DD-<topic>-design.md` and commit
6. **Transition to implementation** — invoke writing-plans skill to create implementation plan
```

When Claude processes this, it creates tasks like:

| `subject` | `activeForm` (spinner text) |
|---|---|
| Explore project context | Exploring project context |
| Ask clarifying questions | Asking clarifying questions |
| Propose 2-3 approaches | Proposing approaches |
| Present design | Presenting design |

## How to Use This in Your Own Skills

Include a structured checklist in your `SKILL.md` with explicit instructions to create tasks:

```markdown
## Checklist

You MUST create a task for each of these items and complete them in order:

1. **Analyze the inputs** — description of what this step does
2. **Generate the output** — description of what this step does
3. **Validate results** — description of what this step does
```

That's all that's needed. Claude will automatically:
- Call `TaskCreate` for each checklist item
- Set an appropriate `activeForm` in present continuous tense
- Display that text in the spinner when the task is `in_progress`

No special configuration or API is required — the `activeForm` field on `TaskCreate` is the entire mechanism, and structured checklists in skills are what trigger it.
