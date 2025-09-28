---
description: Compact memory file by consolidating and optimizing learnings
---

You are compacting the memory learnings file to reduce size while preserving knowledge.

## Process

1. Read `.tmp/memory-learnings.md`
2. Parse all sessions and extract learnings
3. Consolidate learnings:
   - Remove duplicates
   - Merge similar learnings
   - Keep most recent for contradictions
4. Backup: `cp .tmp/memory-learnings.md .tmp/memory-learnings.backup.md`
5. Write consolidated learnings only (remove ALL sessions)
6. Report: "✓ Memory file compacted. Backup saved to .tmp/memory-learnings.backup.md"

## Output Format

```markdown
## Consolidated Learnings

**[Category]:**
- [Consolidated learnings]
```

Preserve standard categories: Project Conventions, Technical Requirements, User Preferences, Domain Knowledge, plus any found in file.

## Error Handling

- File not found: "No memory file found at .tmp/memory-learnings.md"
- Empty file: "Memory file is empty, nothing to compact"
- Parse errors: Skip malformed sections
- Write failure: Display content for manual save
