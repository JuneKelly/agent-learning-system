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

## Implementation Guidelines

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

## External Documentation

The Agent Learning System works with multiple AI coding agent platforms:

- **OpenCode**: <https://opencode.ai/docs>
- **Claude Code**: <https://docs.anthropic.com/en/docs/agents-and-agentic-tools/claude-code>

Both platforms support the same markdown-based command format used by this system.
