---
description: Store validated learnings to memory file
agent: plan
---

You are persisting validated learnings from this session.

## Pre-Storage Checklist

Before storing, ensure:
1. The user has reviewed and approved the learnings via `/learning-summarise`
2. Learnings are specific and actionable (not vague generalizations)
3. No sensitive information (passwords, API keys, personal data) is included

## Storage Process

1. **Ensure Directory Exists**: Use `mkdir -p .tmp` to create directory if needed
2. **Read Existing File**: Check if `.tmp/memory-learnings.md` exists
3. **Prepare New Entry**: Format the learnings with:
   - Timestamp header (ISO 8601 format)
   - Session context (project name, main tasks)
   - Categorized learnings
   - Separator for readability

## Storage Format

```markdown
## 2024-01-15T14:30:00Z

**Project**: [Current project name]
**Session Focus**: [Brief description of main tasks]

### Learnings

**Project Conventions:**
- [Specific learning 1]
- [Specific learning 2]

**Technical Requirements:**
- [Specific learning 3]

**User Preferences:**
- [Specific learning 4]

---
```

## Implementation Steps

1. Run `mkdir -p .tmp` to ensure directory exists
2. Read current contents of `.tmp/memory-learnings.md` (if exists)
3. Prepend new learnings (newest first)
4. Write updated content back to file
5. Confirm storage with: "✓ Learnings stored in .tmp/memory-learnings.md"

## Error Handling

- If file write fails: Display learnings for user to save manually
- If file is too large (>1MB): Warn user to compact the file
