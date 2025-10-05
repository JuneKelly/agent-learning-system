---
description: Recall and apply learnings from previous sessions
---

You are loading accumulated knowledge from previous sessions to enhance your understanding of this project.

## Process

1. Read `.tmp/memory-learnings.md`
2. Parse learnings (newest first - headers: `## YYYY-MM-DD HH:MM TZ - Session Focus`)
3. Consolidate similar learnings, prefer recent ones for conflicts
4. Present categorized summary in priority order:

```
I've recalled learnings from [X] previous sessions. Here's what I know:

**User Corrections (HIGHEST PRIORITY):**
• [Critical corrections to avoid repeating mistakes]

**New Requirements:**
• [Project requirements not yet in documentation]

**Fresh Discoveries:**
• [Important solutions and workarounds]

[Include Updated Conventions, Preference Clarifications, and Custom Categories only if present]

These learnings will guide my assistance. Let me know if any understanding needs updating.
```

## Priority Order

Present in this order (emphasize first three):
1. User Corrections (highest priority - prevent mistakes)
2. New Requirements (critical specs)
3. Fresh Discoveries (valuable solutions)
4. Updated Conventions
5. Preference Clarifications
6. Custom categories (alphabetically)

**Skip empty categories.** Keep learnings in context throughout session.

## Error Handling

- File not found: "This is the first session - no previous learnings found"
- Empty file: "No learnings stored yet"
- Parse errors: Skip malformed sections, report what loaded
- File >1MB: "Memory file is large. Consider `/learning-compact`"
