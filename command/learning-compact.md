---
description: Compact memory file by consolidating and optimizing learnings
---

You are compacting the memory learnings file to reduce size while preserving knowledge.

## Process

1. Read `.tmp/memory-learnings.md`
2. Parse all sessions and extract learnings by category
3. Consolidate within each category:
   - Remove exact duplicates and merge semantically similar learnings
   - Keep most recent version for contradictions
   - Preserve important nuances and context
4. Backup: `cp .tmp/memory-learnings.md .tmp/memory-learnings.backup.md`
5. Write consolidated learnings only (remove ALL sessions)
6. Report: "✓ Compacted from [original size] to [new size]. Removed [X] sessions. Backup: .tmp/memory-learnings.backup.md"

## Output Format

```markdown
## Consolidated Learnings

**User Corrections:**
- [Consolidated corrections]

**New Requirements:**
- [Consolidated requirements]

**Fresh Discoveries:**
- [Consolidated discoveries]

[Include Updated Conventions, Preference Clarifications, Custom Categories only if present]

---
```

## Priority Order

Organize in this order (skip empty categories):
1. User Corrections (highest priority)
2. New Requirements
3. Fresh Discoveries
4. Updated Conventions
5. Preference Clarifications
6. Custom categories (alphabetically)

## Consolidation Strategy

- **User Corrections**: Keep all distinct corrections (critical - don't over-consolidate)
- **New Requirements**: Merge similar, preserve specifics
- **Fresh Discoveries**: Consolidate related, keep unique solutions
- **Updated Conventions**: Keep only most recent for each pattern
- **Preference Clarifications**: Merge similar
- **When in doubt**: Keep rather than remove

## Error Handling

- File not found: "No memory file found at .tmp/memory-learnings.md"
- Empty file: "Memory file is empty, nothing to compact"
- Parse errors: Skip malformed sections, report what processed
- Write failure: Display content for manual save
