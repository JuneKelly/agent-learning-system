# Opencode Memory

> **TL;DR**: Install commands, use `/learning-summarise` and `/learning-store` when you teach the agent something new, use `/learning-recall` at session start. Your agent remembers project-specific knowledge forever.

A learning system that helps AI coding agents remember project-specific knowledge across sessions, and improve project documentation.

Works with [opencode](https://opencode.ai).

## Why Use This?

Ever find yourself explaining the same project conventions, API quirks, or design decisions to your AI assistant repeatedly? Is your project documentation not very good (yet)?

This system solves that problem by letting agents:

- Learn from your corrections and explanations
- Store that knowledge between sessions
- Apply previous learnings to new tasks
- Use learnings to suggest improvements to project documentation and conventions

In the short term (say, while working on a new feature) the agent carries knowledge forward from one session to the next. In the long term, this knowledge can be folded in to the documentation for your project.

## Installation

1. Clone this repository
2. Copy or symlink files from `command/` to your opencode command directory:

   ```bash
   cd opencode-memory
   # Copy into place
   cp ./command/* ~/.config/opencode/command/

   # Or... symlink into place
   ln -s $(pwd)/command/* ~/.config/opencode/command/
   ```

   Note: Adjust the destination path if your opencode installation uses a different location.
3. Add `**/.tmp/**` to your gitignore file (the memory file is stored in `.tmp/`

## Learning Categories

The system categorizes and prioritizes learnings to ensure the most valuable knowledge is captured:

1. **User Corrections** (Highest Priority) - Direct corrections to agent behavior
2. **New Requirements** - Project specifications not in existing docs
3. **Updated Conventions** - Changes to established patterns
4. **Fresh Discoveries** - Solutions and workarounds found during sessions
5. **Preference Clarifications** - User workflow and style preferences

## Usage Workflow

1. **Start a coding session normally** - Work with your AI assistant as usual. Use `@`-mentions to include relevant documentation in the context.

2. **Summarize learnings** - When you've taught the agent something new:

   ```
   /learning-summarise
   ```

   The agent will check existing documentation and previous learnings, then present only genuinely NEW knowledge, compared to the context.

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

5. **Compact learnings** - Compress knowledge:

   ```
   /learning-compact
   ```

   The agent will consolidate all learnings and remove previous sessions, keeping only the distilled knowledge.

6. **Improve documentation** - Apply learnings to your project documentation:

   ```
   /learning-improve-docs
   ```

   The agent will identify learnings which represent gaps in project documentation.

7. **Forget** - Reset learnings to zero:

   ```
   /learning-forget
   ```

   The agent will reset the memory file to an empty file.

## Commands

- `/learning-summarise`: Extract new learnings from this session
  - Automatically checks against existing documentation and previous learnings
  - Filters out duplicate knowledge to maintain high-quality memory
  - Shows what de-duplication was performed for transparency
- `/learning-store`: Save validated learnings to temporary storage
- `/learning-recall`: Load learnings from previous sessions
- `/learning-compact`: Consolidate all learnings and remove ALL previous sessions (keeps only distilled knowledge for maximum space efficiency)
- `/learning-improve-docs`: Analyze learnings and suggest documentation improvements
- `/learning-forget`: Reset memory

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
