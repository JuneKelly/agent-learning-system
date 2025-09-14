---
description: Compact memory file by consolidating and optimizing learnings
---

You are compacting the memory learnings file to reduce size while preserving knowledge.

## Compaction Process

1. **Read Memory File**: Load `.tmp/memory-learnings.md`
2. **Parse All Sessions**: Extract learnings from every session
3. **Consolidate Knowledge**:
   - Remove duplicate learnings
   - Merge similar/overlapping learnings
   - Organize by standard categories
4. **Backup Original**: Save to `.tmp/memory-learnings.backup.md`
5. **Write Compacted File**:
   - Consolidated learnings only
   - Remove ALL previous sessions

## Consolidation Rules

### Deduplication

- Exact matches: Keep only one instance
- Similar learnings: Merge into comprehensive statement
- Contradictions: Keep most recent version

### Category Preservation

Maintain standard categories:

- **Project Conventions**
- **Technical Requirements**
- **User Preferences**
- **Domain Knowledge**
- Any other categories found in the file

### Session Removal

- Remove ALL previous individual sessions after consolidation
- Only keep the consolidated learnings section
- This maximizes space efficiency and focuses on distilled knowledge

## Output Format

```markdown
## Consolidated Learnings

**Project Conventions:**
- [Merged learnings about conventions]

**Technical Requirements:**
- [Consolidated technical knowledge]

**User Preferences:**
- [Combined user preferences]

**Domain Knowledge:**
- [Merged domain understanding]
```

## Implementation Steps

1. Check if `.tmp/memory-learnings.md` exists
2. Read and parse entire file
3. Extract all learnings by category
4. Apply consolidation rules
5. Create backup: `cp .tmp/memory-learnings.md .tmp/memory-learnings.backup.md`
6. Write new compacted file
7. Report: "✓ Memory file compacted. Backup saved to .tmp/memory-learnings.backup.md"

## Error Handling

- **File Not Found**: "No memory file found at .tmp/memory-learnings.md"
- **Empty File**: "Memory file is empty, nothing to compact"
- **Small File (<10KB)**: "Memory file is already compact"
- **Parse Errors**: Skip malformed sections, continue with valid data
- **Write Failure**: Display compacted content for manual save

## Edge Cases

- **No Learnings to Consolidate**: Keep file as-is with empty consolidated section
- **Only Recent Sessions**: Remove sessions after consolidation regardless of count
- **Large Consolidated Section**: If consolidated learnings are extensive, consider further summarization

