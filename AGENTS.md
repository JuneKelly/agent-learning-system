# Instructions for Agents

## Project Goal

This project is a memory and learning system for AI coding agents.

The goal is to persist items of information which agents learn in a given session, and store them for future recall.

## Implementation

This memory system is implemented as a set of "commands" for opencode.

## Important files

The `README.md` file contains the project documentation.

The `command/` directory contains the command files, which make up the bulk of the project.

## Technical Details

### Memory File Structure

The `.tmp/memory-learnings.md` file uses a specific format:

- **Ordering**: Newest sessions appear first (reverse chronological)
- **Timestamps**: ISO 8601 format (e.g., `2025-09-14T09:38:36+01:00`)
- **Structure**:
  - Consolidated learnings section at the top
  - Individual session entries below
  - Each session includes: timestamp, project name, session focus, and categorized learnings
- **Size Limit**: Automatic compaction suggested when file exceeds 1MB

## Command Implementation Guidelines

Each command in the `command/` directory follows these conventions:

- **Frontmatter**: All commands must include YAML frontmatter with:
  - `description`: Brief description of the command's purpose

- **Naming**: Commands follow the pattern `/learning-[action]`

## Backup and Compaction Process

The `/learning-compact` command includes safety features:

- Creates backup at `.tmp/memory-learnings.backup.md` before compacting
- Preserves consolidated learnings at the top of the file
- Keeps the last 5 individual sessions for reference
- Triggers automatically when file exceeds 1MB

## External Documentation

The documentation for the opencode agent system can be found here: <https://opencode.ai/docs>
