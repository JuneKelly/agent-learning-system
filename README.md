# Opencode Memory

Make agents learn over time.

To use, copy or symlink the files in `command/` into your opencode command folder.

## Commands

- `/learning-summarise`: Instructs the agent to summarise what it has learned in this session
- `/learning-store`: Instructs the agent to save its learnings to a temporary file
- `/learning-recall`: Instructs the agent to recall its learnings from previous sessions (by reading the temporary file created by `/learning-store`)
