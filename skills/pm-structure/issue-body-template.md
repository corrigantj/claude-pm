# Issue Body Template

Use this template when creating GitHub Issues via `pm-structure`. Replace placeholders with actual content.

---

## User Story

As a **{persona}**, I want to **{action}** so that **{benefit}**.

## Acceptance Criteria

```gherkin
Feature: {feature name}

  Scenario: {happy path scenario name}
    Given {precondition}
    When {action}
    Then {expected outcome}

  Scenario: {edge case scenario name}
    Given {precondition}
    When {action}
    Then {expected outcome}
```

## Definition of Done

- [ ] All acceptance criteria scenarios pass
- [ ] Unit tests written and passing
- [ ] No regressions in existing tests
- [ ] Code follows project conventions
- [ ] PR created with passing CI

## Implementation Notes

{Brief technical guidance: approach, key files, patterns to follow, gotchas.}

### Files Likely Affected

- `{path/to/file1}` — {what changes}
- `{path/to/file2}` — {what changes}

### Dependencies

<!-- pm:blocked-by #{issue_numbers_csv} -->

{Human-readable dependency explanation, if any.}

---

**Size:** `size/{t-shirt}` | **Type:** `type/{type}` | **Priority:** `priority/{level}`
