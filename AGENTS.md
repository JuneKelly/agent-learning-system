# Instructions for Agents

## Project Overview

This project is a memory and learning system for AI coding agents that enables persistent knowledge across coding sessions.

The system allows agents to learn from user corrections and explanations, store that knowledge in a structured format, and automatically recall it in future sessions.

## Key Files and Directories

- **`README.md`** - User-facing documentation (installation, usage, examples)
- **`docs/spec.md`** - Complete technical specification (see below)
- **`command/`** - Command implementation files (the core of the system)

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

## External Documentation

The documentation for the opencode agent system can be found here: <https://opencode.ai/docs>
