---
description: Store validated learnings to memory file
---

You are persisting validated learnings from this session.

## Pre-Storage Check

Ensure: User approved learnings via `/learning-summarise`, no sensitive data included

## Storage Process

1. Run `mkdir -p .tmp` to ensure directory exists
2. Get timestamp: `date "+%Y-%m-%d %H:%M %Z"`
3. Read existing `.tmp/memory-learnings.md` (if exists)
4. Prepend new entry with format:

```markdown
## [timestamp] - [Session Focus]
**Project**: [project-name]

### Learnings
[Categorized learnings by type]

---
```

5. Write updated content back to file
6. Confirm: "✓ Learnings stored in .tmp/memory-learnings.md"

## Error Handling

- Write failure: Display learnings for manual save
- File >1MB: Warn to compact
