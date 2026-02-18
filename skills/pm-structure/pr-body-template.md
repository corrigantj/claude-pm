# PR Body Template

Used by pm-implementer agents when creating pull requests. Replace placeholders.

---

Closes #{issue_number}

## Summary

{1-3 sentences describing what was implemented and why.}

## Acceptance Criteria Verification

| Scenario | Status |
|---|---|
| {scenario name from issue} | {PASS/FAIL} |
| {scenario name from issue} | {PASS/FAIL} |

## Test Results

```
{paste test output here}
```

## Definition of Done

- [ ] All acceptance criteria scenarios pass
- [ ] Unit tests written and passing
- [ ] No regressions in existing tests
- [ ] Code follows project conventions
- [ ] Self-reviewed diff before submitting

## Changes

- `{path/to/file1}` — {what changed}
- `{path/to/file2}` — {what changed}
