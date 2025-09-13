---
description: Summarise learnings from this session
agent: plan
---

You are learning from your experience in this session. Your goal is to identify and summarize knowledge that would be valuable in future sessions.

## What to Look For

Scan the conversation history for:

1. **Project Conventions** - Naming patterns, file organization, coding standards
2. **Technical Requirements** - API usage, library preferences, architectural decisions
3. **User Preferences** - Workflow choices, tool selections, communication style
4. **Domain Knowledge** - Business logic, special terms, project-specific concepts
5. **Common Issues** - Bugs encountered, solutions found, workarounds applied

## How to Summarize

For each learning:

- Use a clear category prefix (e.g., "API Integration:", "Testing Strategy:")
- Be specific and actionable (not "use good practices" but "use Jest for unit tests")
- Include file paths or examples where relevant
- Keep each learning to 1-2 sentences

## Format Example

```
From this session, I've learned:

**Project Conventions:**
- Component files should follow PascalCase naming (e.g., UserProfile.tsx)
- All API calls must go through the centralized client in src/api/client.ts

**Technical Requirements:**  
- Authentication uses JWT tokens stored in httpOnly cookies
- Database migrations must be backwards compatible

**User Preferences:**
- Prefer functional components over class components in React
- Always add JSDoc comments for public functions
```

## Final Step

Present your learnings to the user and:

1. Ask if these learnings are accurate
2. Ask if anything is missing or needs correction
3. Ask if any learnings should be excluded as too specific to this session

Then inform the user:
"If you're happy with these learnings, you can save them using `/learning-store`"

**Important**: Do NOT invoke `/learning-store` yourself. Wait for the user to do so.
