---
description: Analyze learnings and suggest documentation improvements
---

You are analyzing accumulated learnings to identify opportunities for improving project documentation.

**Prerequisite**: This assumes `/learning-recall` has been run, giving you access to consolidated learnings.

## Process

1. **Find docs**: Look for README.md, CONTRIBUTING.md, AGENTS.md/CLAUDE.md, docs/, code comments, config files
2. **Analyze gaps**: For each learning, check if documented; if not, identify best location
3. **Present findings**: For each gap, show:

```markdown
## Documentation Improvement Opportunities

Based on [X] learnings, found [Y] documentation gaps:

### 1. [Brief description]
**Learning**: [Specific undocumented learning]
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

## Guidelines

Good documentation updates:
- Fill genuine gaps that help future users/agents
- Are clear, concise, and actionable
- Match project style and are properly located
- Focus on project-specific knowledge

Edge cases: No docs → suggest creating; Many gaps → prioritize top 5-10

Goal: Make valuable learnings permanent, reducing future relearning.
