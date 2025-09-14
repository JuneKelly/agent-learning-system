---
description: Summarise learnings from this session
---

You are learning from your experience in this session. Your goal is to identify and summarize **NEW** knowledge that would be valuable in future sessions.

## Critical: Avoid Duplicate Learnings

Before identifying learnings, you must first understand what is already known by:

1. **Reading existing project documentation** (README.md, AGENTS.md, package.json, etc.)
2. **Reading previous learnings** from `.tmp/memory-learnings.md` if it exists
3. **Comparing potential learnings** against this existing knowledge base

## What Qualifies as NEW Learning

Focus ONLY on:

1. **User Corrections** - When user says "No, actually it should be..." or corrects your approach
2. **New Requirements** - Specifications not mentioned in existing documentation
3. **Updated Conventions** - Changes to previously established patterns
4. **Fresh Discoveries** - New solutions, workarounds, or insights gained this session
5. **Preference Clarifications** - User workflow/style preferences not previously documented

## What to EXCLUDE

Do NOT include learnings that:

- Duplicate information already in project documentation
- Repeat knowledge from previous sessions (check `.tmp/memory-learnings.md`)
- Are general best practices rather than project-specific knowledge
- Are obvious from the codebase structure or existing files

## Process Steps

1. **Load existing knowledge first**:
   - Read README.md, AGENTS.md, and other documentation files
   - Read consolidated learnings from `.tmp/memory-learnings.md`
   - Scan recent session entries for context

2. **Analyze conversation for NEW insights**:
   - Look for user corrections or clarifications
   - Identify requirements not in documentation
   - Note preference statements or workflow changes
   - Find solutions to problems encountered this session

3. **Filter against existing knowledge**:
   - Cross-reference each potential learning
   - Only include genuinely new or updated information
   - Mark when a learning updates/corrects a previous one

## How to Summarize NEW Learnings

For each NEW learning:

- Use a clear category prefix (e.g., "API Integration:", "Testing Strategy:")
- Be specific and actionable (not "use good practices" but "use Jest for unit tests")
- Include file paths or examples where relevant
- Keep each learning to 1-2 sentences
- If updating previous knowledge, clearly mark it as "(Updated from previous session)"

## Format Example

```
After checking existing documentation and previous learnings, here are the NEW insights from this session:

**Project Conventions:**
- (Updated from previous session) Component files now use kebab-case, not PascalCase (UserProfile.tsx → user-profile.tsx)

**User Preferences:**
- Prefer TypeScript strict mode enabled for all new files
- Always run linting before committing (previously not specified)

**Fresh Discoveries:**
- Bug fix: API client needs 500ms delay between requests to avoid rate limiting
```

## If No New Learnings Found

If after checking existing knowledge you find no genuinely new learnings, respond with:

```
After reviewing this session against existing project documentation and previous learnings, I found no new knowledge to store. All insights from this session are already documented or were covered in previous sessions.

This is actually good - it means your existing documentation and learning system are comprehensive!
```

## Final Step

Present your NEW learnings to the user and:

1. **Show your deduplication work**: Briefly mention what existing sources you checked
2. **Present only NEW learnings**: Clearly mark any updates to previous knowledge
3. **Ask for validation**:
   - Are these learnings accurate?
   - Is anything missing or needs correction?
   - Should any learnings be excluded as too session-specific?

Then inform the user:
"If you're happy with these NEW learnings, you can save them using `/learning-store`"

**Important**:

- Do NOT invoke `/learning-store` yourself. Wait for the user to do so.
- If no new learnings found, don't suggest using `/learning-store`
