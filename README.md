# Opencode Memory

A learning system that helps AI coding agents remember project-specific knowledge across sessions.

## Why Use This?

Ever find yourself explaining the same project conventions, API quirks, or design decisions to your AI assistant repeatedly? This system solves that by letting agents:

- Learn from your corrections and explanations
- Store that knowledge between sessions
- Apply previous learnings to new tasks

## Installation

1. Clone this repository
2. Copy or symlink files from `command/` to your opencode command directory:

   ```bash
   # From the opencode-memory directory
   ln -s $(pwd)/command/* ~/.config/opencode/command/
   ```

   Note: Adjust the destination path if your opencode installation uses a different location.

## Usage Workflow

1. **Start a coding session normally** - Work with your AI assistant as usual

2. **Summarize learnings** - When you've taught the agent something new:

   ```
   /learning-summarise
   ```

   The agent will check existing documentation and previous learnings, then present only genuinely NEW knowledge for your review and correction.

3. **Store learnings** - Save the validated learnings:

   ```
   /learning-store
   ```

   This appends to `.tmp/memory-learnings.md` with a timestamp.

4. **Recall in future sessions** - Start new sessions with:

   ```
   /learning-recall
   ```

   The agent will load and apply previous learnings.

## Example Session

```
User: The API client should always use the custom error handler from src/utils/errors.ts
Assistant: I understand. Let me note this requirement.

User: /learning-summarise
Assistant: After checking existing documentation and previous learnings, here are the NEW insights from this session:
- API Integration: Always use the custom error handler from src/utils/errors.ts for API client implementations
- This ensures consistent error handling across the application

User: That's correct. Also note that we log errors to Sentry in production.
Assistant: Updated understanding:
- API Integration: Always use custom error handler from src/utils/errors.ts
- Error Logging: Production errors are logged to Sentry

User: /learning-store
Assistant: Learnings saved to .tmp/memory-learnings.md
```

## Commands

- `/learning-summarise`: Extract NEW learnings from this session (excludes duplicates)
- `/learning-store`: Save validated learnings to temporary storage
- `/learning-recall`: Load learnings from previous sessions

## Notes

- Learnings are stored in `.tmp/memory-learnings.md` (not version controlled)
- The system automatically filters out duplicate knowledge to prevent repetitive learnings
- The file grows over time - use `/learning-compact` when it exceeds 1MB
- Consider using learnings to update your project's AGENTS.md documentation
