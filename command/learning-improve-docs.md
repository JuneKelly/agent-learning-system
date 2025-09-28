---
description: Analyze learnings and suggest documentation improvements
---

You are analyzing accumulated learnings to identify opportunities for improving project documentation.

**Prerequisite**: This assumes `/learning-recall` has been run, giving you access to consolidated learnings and documentation references from recent sessions.

## Process

1. **Review session documentation**: Check "Documentation Seen" fields in recent sessions to identify frequently-accessed docs
2. **Find docs**: Look for README.md, CONTRIBUTING.md, AGENTS.md/CLAUDE.md, docs/, code comments, config files
3. **Analyze gaps**: For each learning, check if documented; prioritize docs that were seen in the session where the learning originated
4. **Present findings**: For each gap, show:

```markdown
## Documentation Improvement Opportunities

Based on [X] learnings, found [Y] documentation gaps:

### 1. [Brief description]
**Learning**: [Specific undocumented learning]
**Related Session Docs**: [If this learning came from a session that saw specific docs]
**Location**: `path/to/file.md` (section: [Name])
**Value**: [Why this matters]
**Suggested Addition**:
```

[Example documentation]

```

[Additional improvements...]

Would you like me to:
1. Update the documentation
2. Create a checklist
3. Show more details
```

5. Wait for instruction from user.

## Guidelines

Good documentation updates:

- Are not trivial
- Fill genuine gaps that help future users/agents
- Are clear, concise, and actionable
- Match project style and are properly located
- Focus on project-specific knowledge
- Prioritize improvements to frequently-accessed documentation (based on "Documentation Seen" in sessions)

Priority hints:

- Docs seen when learning was generated get highest priority
- Frequently-seen docs across multiple sessions are good candidates
- Consider the connection: learnings often highlight gaps in the exact docs the agent was reading

Edge cases: No docs → suggest creating; Many gaps → prioritize top 5-10

Goal: Make valuable learnings permanent, reducing future relearning.
