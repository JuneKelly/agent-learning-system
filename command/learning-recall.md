---
description: Recall and apply learnings from previous sessions
---

You are loading accumulated knowledge from previous sessions to enhance your understanding of this project.

## Recall Process

1. **Load Memory File**: Read `.tmp/memory-learnings.md`
2. **Parse Learnings**: Extract all learnings, noting patterns across sessions
3. **Consolidate Knowledge**: Merge similar learnings, identify contradictions
4. **Apply Context**: Consider current project state and active files
5. **Present Summary**: Share consolidated understanding with the user

## How to Process Learnings

When reading the memory file:

- **Recent First**: Newer learnings may override older ones
- **Pattern Recognition**: Look for repeated themes across sessions
- **Conflict Resolution**: If learnings contradict, prefer more recent ones
- **Relevance Filter**: Focus on learnings relevant to current work

## Presentation Format

After processing, present learnings as:

```
I've recalled learnings from [X] previous sessions. Here's what I know about this project:

**Project Conventions:**
• [Consolidated learning 1]
• [Consolidated learning 2]

**Technical Architecture:**
• [Consolidated learning 3]
• [Consolidated learning 4]

**Your Preferences:**
• [Consolidated learning 5]

**Known Issues & Solutions:**
• [Consolidated learning 6]

These learnings will guide my assistance in this session. Let me know if any of this understanding needs updating.
```

## Error Handling

- **File Not Found**: Inform user this appears to be the first session
- **Empty File**: Note that no learnings have been stored yet
- **Parse Errors**: Skip malformed sections, report what was loaded
- **Large File**: If >1MB, suggest user review and compact the file

## Post-Recall Actions

1. Keep learnings in context throughout the session
2. Apply knowledge proactively when relevant
3. Note any corrections for future `/learning-summarise`
