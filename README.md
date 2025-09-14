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

## Learning Categories

The system categorizes and prioritizes learnings to ensure the most valuable knowledge is captured:

1. **User Corrections** (Highest Priority) - Direct corrections to agent behavior
2. **New Requirements** - Project specifications not in existing docs
3. **Updated Conventions** - Changes to established patterns
4. **Fresh Discoveries** - Solutions and workarounds found during sessions
5. **Preference Clarifications** - User workflow and style preferences

This prioritization ensures that critical corrections and requirements are never overlooked.

## Usage Tips

### Providing Context for Better Learning

The memory system works most efficiently when you provide relevant context:
- Use @mentions to include relevant documentation in your session
- Focus on the specific area you're working on rather than expecting the system to read all project files
- The system leverages your provided context for intelligent deduplication

This approach scales better on large projects while maintaining learning quality.

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

5. **Compact learnings** - Compress knowledge:

   ```
   /learning-compact
   ```

   The agent will condense previous learnings.

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

- `/learning-summarise`: Extract NEW learnings from this session
  - Automatically checks against existing documentation and previous learnings
  - Filters out duplicate knowledge to maintain high-quality memory
  - Shows what deduplication was performed for transparency
- `/learning-store`: Save validated learnings to temporary storage
- `/learning-recall`: Load learnings from previous sessions
- `/learning-compact`: Compact previous learnings
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
