---
description: Analyze learnings and suggest documentation improvements
agent: build
---

You are analyzing the accumulated learnings to identify opportunities for improving project documentation.

## Prerequisites

This command assumes `/learning-recall` has already been run, so you have access to the consolidated learnings in your context.

## Objective

Your goal is to identify learnings that represent gaps in the current project documentation and suggest where those learnings should be incorporated to make them "baked in" to the project.

## Process Steps

1. **Identify Documentation Files**
   - Look for common documentation files:
     - `README.md` - Project overview and setup
     - `CONTRIBUTING.md` - Development guidelines
     - `AGENTS.md` or `CLAUDE.md` - AI agent conventions
     - `docs/` directory - Detailed documentation
     - Source code docstrings and comments
     - Configuration files with comments

2. **Analyze Each Learning**
   For each learning in your recalled knowledge:
   - Determine if it's already documented somewhere
   - If not documented, identify the most appropriate location
   - Consider the learning's category and audience

3. **Categorize Documentation Gaps**
   Group undocumented learnings by where they should go:
   - **README Updates**: Setup instructions, project conventions
   - **Agent Instructions**: AI-specific conventions, workflow patterns
   - **Code Comments**: Implementation details, workarounds
   - **New Documentation**: Learnings requiring new docs files

4. **Present Findings**
   For each undocumented learning, show:
   - The learning itself
   - Suggested documentation location
   - How it would improve the project
   - Example of how it could be written

## Output Format

```markdown
## Documentation Improvement Opportunities

Based on my accumulated learnings, I've identified [X] opportunities to improve project documentation:

### 1. [Category]: [Brief description]

**Learning**: [The specific learning not yet documented]

**Suggested Location**: `path/to/file.md` (section: [Section Name])

**Why This Matters**: [Brief explanation of value]

**Suggested Addition**:
```

[Example of how this could be documented]

```

### 2. [Next opportunity...]

## Summary

- **Total Learnings Analyzed**: [X]
- **Already Documented**: [Y]
- **Documentation Gaps Found**: [Z]

Would you like me to:
1. Update the documentation with these improvements
2. Create a checklist for manual updates
3. Show more details about specific suggestions
```

## Guidelines

1. **Be Specific**: Point to exact files and sections
2. **Show Value**: Explain why each documentation update matters
3. **Provide Examples**: Show how the documentation could be written
4. **Respect Existing Style**: Match the tone and format of existing docs
5. **Prioritize**: List most valuable improvements first

## What Makes a Good Documentation Update

- **Fills a genuine gap** - Information that would help future users/agents
- **Clear and concise** - Adds clarity without bloat
- **Properly located** - In the most logical file/section
- **Actionable** - Provides specific guidance, not vague principles
- **Consistent** - Matches project's documentation style

## Edge Cases

- **No documentation files**: Suggest creating appropriate files
- **Conflicting information**: Highlight and suggest resolution
- **Too many gaps**: Prioritize top 5-10 most important
- **Project-specific vs generic**: Focus on project-specific knowledge

Remember: The goal is to make valuable learnings permanent parts of the project, reducing the need for agents to "relearn" in future sessions.
