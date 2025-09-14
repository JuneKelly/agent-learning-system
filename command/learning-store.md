---
description: Store validated learnings to memory file
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
   - Timestamp header with session focus (local time format: YYYY-MM-DD HH:MM TZ)
   - Session context (project name)
   - Categorized learnings
   - Separator for readability

## Storage Format

```markdown
## 2025-09-14 16:27 BST - [Session Focus Description]

**Project**: [Current project name]

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
2. Get current local timestamp using `date "+%Y-%m-%d %H:%M %Z"`
3. Ask user for brief session focus description if not already provided
4. Read current contents of `.tmp/memory-learnings.md` (if exists)
5. Format new entry with timestamp and session focus in heading
6. Prepend new learnings (newest first)
7. Write updated content back to file
8. Confirm storage with: "✓ Learnings stored in .tmp/memory-learnings.md"

## Error Handling

- If file write fails: Display learnings for user to save manually
- If file is too large (>1MB): Warn user to compact the file
