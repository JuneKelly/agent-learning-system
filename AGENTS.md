# Instructions for Agents

## Project Overview

This project is a memory and learning system for AI coding agents that enables persistent knowledge across coding sessions.

The system allows agents to learn from user corrections and explanations, store that knowledge in a structured format, and automatically recall it in future sessions.

## Key Files and Directories

- **`README.md`** - User-facing documentation (installation, usage, examples)
- **`docs/spec.md`** - Complete technical specification (see below)
- **`command/`** - Command implementation files (the core of the system)
  - These are implementation files containing agent instructions
  - Not documentation files themselves, but operational directives
  - Each file corresponds to a specific learning command

## Technical Specification

For complete technical details including file formats, command specifications, learning categories, error handling, and system architecture, refer to: [`docs/spec.md`](docs/spec.md).

## Quality Guidelines

- **Focus on project-specific knowledge** rather than general best practices
- **Prioritize user corrections** and direct feedback highly
- **Ensure de-duplication** against existing documentation and previous learnings
- **Maintain knowledge accuracy** through user validation before storage
- **Keep learnings actionable** and specific rather than vague

### Example Style

Use concrete, project-specific examples rather than abstract, language-agnostic ones:

- ✅ **Concrete**: "Tests should use `MyApp.DataCase` not `ExUnit.Case`" (Elixir-specific)
- ❌ **Abstract**: "Tests should use the appropriate test case module"

**Rationale**: Concrete examples effectively convey patterns across languages. An Elixir-specific example helps Python developers understand the analogous pattern in their context.

## Implementation Guidelines

### Command File Self-Containment

IMPORTANT: Command files in `command/` are **distributed artifacts** that run in user projects, not in the Agent Learning System repository:

- ❌ **Never reference** `docs/spec.md` or other project documentation within command files
- ❌ **Never use** external links or file references that assume this repository's structure
- ✅ **Always include** examples and guidance inline within command files
- ✅ **Make commands** completely self-contained and portable

**Why**: When users install commands via `install.sh`, the command files are symlinked into `~/.config/opencode/command/` or `~/.claude/commands/`. Any references like "See `docs/spec.md`" will fail because those paths don't exist in user projects.

### Command File Complexity

Balance guidance with agent comprehension:

- **50-70 lines**: Simple commands with clear workflow
- **85-100 lines**: Complex commands needing examples and edge cases
- **>140 lines**: Likely overwhelming - consider breaking into focused sections
- **Focus**: Effectiveness over completeness - simpler commands that agents process beat comprehensive but overwhelming guidance

### Deduplication Strategy

When implementing learning commands:

- Compare learnings against agent's current context (from @mentions, exploration)
- Always check previous learnings in `.tmp/memory-learnings.md`
- Avoid exhaustive file reading for performance on large projects
- Prioritize targeted, context-aware deduplication over comprehensive scanning

## Development and Modification Guidelines

### Spec Compliance Process

When implementing or modifying learning commands:

1. **Always read `docs/spec.md` first**: Understand complete behavioral requirements before making changes
2. **Systematic compliance checking**: Verify each implementation against:
   - Behavioral requirements (what the command should do)
   - Error handling specifications (edge cases and failure modes)
   - File format specifications (memory file structure and format)

### Handling Spec Discrepancies

If you discover a discrepancy between the specification and requested modifications:

1. **Identify the conflict**: Clearly explain what the spec requires vs. what is being requested
2. **Present options to user**: Ask whether they want to:
   - Proceed with the change AND update the specification to match
   - Reconsider the requested change to maintain spec compliance
3. **Wait for explicit direction**: Do not proceed until the user clarifies their preference
4. **Update both**: If proceeding with changes, update both implementation and specification

This ensures the specification remains the authoritative source of truth while allowing for intentional evolution of the system.

## Agent Interaction Style

### Honest Assessment

When users ask for feedback ("how do you feel about this?", "thoughts?"):

- ✅ Provide honest assessment including concerns and potential issues
- ✅ Offer critical self-evaluation when appropriate
- ❌ Don't just confirm user's approach without genuine analysis
- ❌ Avoid excessive politeness that obscures real concerns

Users value candid technical feedback over reassurance.

### Directive Style

When providing feedback or corrections, prefer concise directives over lengthy explanations:

- ✅ "Simplify this section"
- ✅ "Remove the redundant examples"

Trust agents to understand the intent. Add context when genuinely needed for clarity, but avoid unnecessary verbosity.

## External Documentation

The Agent Learning System works with multiple AI coding agent platforms:

- **OpenCode**: <https://opencode.ai/docs>
- **Claude Code**: <https://docs.anthropic.com/en/docs/agents-and-agentic-tools/claude-code>

Both platforms support the same markdown-based command format used by this system.
