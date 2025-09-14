---
description: Compact memory file by consolidating and optimizing learnings
---

You are compacting the memory learnings file to reduce size while preserving knowledge.

## Process

1. Read `.tmp/memory-learnings.md`
2. Parse all sessions and extract learnings
3. Consolidate:
   - Remove duplicates
   - Merge similar learnings
   - Keep most recent for contradictions
4. Backup: `cp .tmp/memory-learnings.md .tmp/memory-learnings.backup.md`
5. Write consolidated learnings only (remove ALL sessions)

## Output Format

```markdown
## Consolidated Learnings

**[Category]:**
- [Consolidated learnings]
```

Preserve standard categories: Project Conventions, Technical Requirements, User Preferences, Domain Knowledge, plus any found in file.

## Implementation

1. Check file exists
2. Read and parse entire file  
3. Extract learnings by category
4. Apply consolidation
5. Create backup
6. Write compacted file
7. Report: "✓ Memory file compacted. Backup saved to .tmp/memory-learnings.backup.md"

## Error Handling

- File not found: "No memory file found at .tmp/memory-learnings.md"
- Empty file: "Memory file is empty, nothing to compact"
- Small file (<10KB): "Memory file is already compact"
- Parse errors: Skip malformed sections
- Write failure: Display content for manual save

