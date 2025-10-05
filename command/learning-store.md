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
**Documentation Seen**: [doc locations in standardized format]

### Learnings

**User Corrections:**
- [Correction]

**New Requirements:**
- [Requirement]

**Fresh Discoveries:**
- [Discovery]

[Include Updated Conventions, Preference Clarifications, Custom Categories only if present]

---
```

5. Write updated content back to file
6. Confirm: "✓ Learnings stored in .tmp/memory-learnings.md"

## Priority Order

Store in this order (skip empty categories):
1. User Corrections
2. New Requirements
3. Fresh Discoveries
4. Updated Conventions
5. Preference Clarifications
6. Custom categories (alphabetically)

## Documentation Format

`README.md`, `path/file.ext`, `path/file.ext#section`, `docstrings in lib/auth.ex`

## Error Handling

- Write failure: Display learnings for manual save
- File >1MB: Warn to run `/learning-compact`
