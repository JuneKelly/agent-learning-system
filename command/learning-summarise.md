---
description: Summarise learnings from this session
---

You are extracting NEW knowledge from this session that would be valuable in future sessions.

## Process

1. **Check existing knowledge**:
   - Use project documentation already in your context (from @mentions/exploration)
   - Read previous learnings from `.tmp/memory-learnings.md` if it exists

2. **Track documentation seen**:
   - Note references to documentation encountered in this session
   - Format: `README.md`, `path/file.ext`, `docstrings in lib/auth.ex`, `docs/api.md#section`

3. **Identify NEW learnings** using priority categories below

4. **Apply deduplication**:
   - Exclude exact duplicates AND semantically similar knowledge (even if worded differently)
   - Exclude general best practices not specific to this project
   - **Include** refinements, corrections, or important nuances to existing knowledge

## Learning Categories (Priority Order)

**The first three are by far the most important.** Use these in priority order:

### 1. User Corrections (HIGHEST PRIORITY)
Direct corrections to your understanding or approach.
- Good: "Tests should use `MyApp.DataCase` not `ExUnit.Case` for database tests (corrected)"
- Bad: "Fixed a bug" (too vague), "Use proper error handling" (general advice)

### 2. New Requirements
Project specifications not yet in documentation.
- Good: "All API responses must include `request_id` field for tracing (not in docs/api.md)"
- Bad: "The project uses React" (obvious), "Functions should be documented" (general)

### 3. Fresh Discoveries
Solutions, workarounds, or insights discovered this session.
- Good: "`UserCache` must be warmed before first request or queries timeout (discovered debugging)"
- Bad: "Debugging is useful" (general), "The function works" (not actionable)

### 4. Updated Conventions
Changes to established patterns.

### 5. Preference Clarifications
User workflow, style, or tooling preferences.

### 6. Custom Categories (Fallback)
Create specific categories if needed (e.g., "Database Migration:", "Third-party Integration:").
Avoid generic categories like "Code Quality" or "Best Practices."

## Quality Filter

✅ **Keep**: Project-specific, actionable, specific (file paths/examples), valuable, validated by user
❌ **Reject**: Generic advice, obvious from docs/code, vague, session-specific ephemera, unvalidated assumptions

**Example:**
- ❌ "Fixed authentication bug" → Too vague
- ❌ "Always validate user input" → Generic advice
- ✅ "Auth middleware requires `user_id` claim in JWT, not `sub` (corrected from initial OAuth implementation)" → Specific, actionable, project-specific

## Output Format

```markdown
### Knowledge Sources Checked
- Previous learnings: [X] sessions
- Documentation in context: [list]

### Documentation Seen This Session
[Standardized list: `file.ext`, `path/file.ext#section`]

### NEW Learnings (Priority Order)

**User Corrections:**
1. [Learning]

**New Requirements:**
1. [Learning]

**Fresh Discoveries:**
1. [Learning]

[Other categories only if applicable...]

Please verify these are project-specific, actionable, and not duplicates. Any to add/remove/clarify?
```

Then inform: "If you're happy with these NEW learnings and documentation references, run `/learning-store` to save them to memory."

**Important**: Do NOT invoke `/learning-store` yourself. If no new learnings found, say so without suggesting storage.
