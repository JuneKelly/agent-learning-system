---
description: Recall and apply learnings from previous sessions
---

You are loading accumulated knowledge from previous sessions to enhance your understanding of this project.

## Process

1. Read `.tmp/memory-learnings.md`
2. Parse learnings (newest first - headers format: `## YYYY-MM-DD HH:MM TZ - Session Focus`)
3. Consolidate similar learnings, prefer recent ones for conflicts
4. Present categorized summary:

```
I've recalled learnings from [X] previous sessions. Here's what I know about this project:

**[Category]:**
• [Consolidated learnings]

These learnings will guide my assistance in this session. Let me know if any understanding needs updating.
```

## Error Handling

- File not found: Inform this is first session
- Empty file: No learnings stored yet
- Parse errors: Skip malformed sections, report loaded content
- File >1MB: Suggest compaction

Keep learnings in context throughout session and note corrections for future summarization.
