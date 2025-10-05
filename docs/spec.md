# Agent Learning System Specification

This document contains the technical specification for the Agent Learning System - a learning system that helps AI coding agents remember project-specific knowledge across sessions.

## Project Purpose

### Problem Statement

AI coding agents frequently lose context between sessions, requiring users to repeatedly explain:

- Project-specific conventions and patterns
- API quirks and integration requirements
- Design decisions and architectural choices
- User preferences and workflow patterns
- Solutions to previously encountered problems

### Solution

The Agent Learning System provides persistent learning capabilities that allow agents to:

- Learn from user corrections and explanations during coding sessions
- Store that knowledge in a structured, timestamped format
- Automatically recall previous learnings when starting new sessions
- Apply accumulated knowledge to new tasks and problems
- Maintain knowledge quality through deduplication and compaction

### Goals

1. **Persistence**: Maintain agent knowledge across session boundaries
2. **Quality**: Ensure stored learnings are accurate, relevant, and non-duplicate
3. **Accessibility**: Make knowledge easily recallable and applicable
4. **Maintenance**: Provide tools for knowledge organization and cleanup
5. **Integration**: Seamlessly work with existing OpenCode and Claude Code workflows

## High-Level Architecture

### Core Components

1. **Learning Commands** (`command/` directory)
   - Individual command files implementing the learning workflow
   - Each command contains agent instructions for specific learning operations
   - Commands integrate with OpenCode or Claude Code command execution system

2. **Memory Storage** (`.tmp/memory-learnings.md`)
   - Local file-based storage for each project
   - Structured markdown format with timestamps and categories
   - Automatic organization with newest sessions first

3. **Knowledge Processing Pipeline**
   - Summarization: Extract new learnings from sessions
   - De-duplication: Filter against existing knowledge
   - Storage: Persist validated learnings with metadata
   - Recall: Load and present accumulated knowledge
   - Maintenance: Compact and organize stored knowledge
   - Documentation improvement: Suggest ways to apply learnings to project documentation

### System Workflow

```
User Session → /learning-summarise → Knowledge Extraction
      ↓
Deduplication ← Existing Docs + Previous Learnings
      ↓
User Validation → /learning-store → Memory File
      ↓
Future Sessions → /learning-recall → Applied Knowledge
      ↓
Maintenance → /learning-compact → Optimized Storage
      ↓
Improvement → /learning-improve-docs → Knowledge applied to project documentation
      ↓
Forgetting → /learning-forget → Knowledge erased
```

### Data Flow Architecture

1. **Input Sources**:
   - Current session conversations
   - Existing project documentation
   - Previous memory files

2. **Processing Layer**:
   - Learning extraction and categorization
   - Duplicate detection and filtering
   - Knowledge validation and correction

3. **Storage Layer**:
   - Structured markdown files
   - Timestamped session entries
   - Consolidated knowledge sections

4. **Output/Recall Layer**:
   - Consolidated learning presentation
   - Context-aware knowledge application
   - Documentation improvement suggestions

### Integration Architecture

The system integrates with OpenCode and Claude Code through:

- **Command Interface**: Standard markdown command files with YAML frontmatter, which become "slash" commands in the agent interface
- **File System**: Local project-specific storage
- **Agent Context**: Knowledge loaded into agent working memory
- **User Workflow**: Seamless integration with coding sessions

## System Overview

The memory system is implemented as a set of "commands" for OpenCode and Claude Code that allow agents to:

- Summarize and categorize learnings from coding sessions
- Store validated knowledge with timestamps and structure
- Recall previous learnings in new sessions
- Maintain and compact memory files over time
- Improve project documentation based on accumulated learnings

## Memory File Structure

### File Location and Naming

Memory files are stored as `.tmp/memory-learnings.md` in each project directory (not version controlled).

### File Format

The memory file uses a specific markdown structure:

- **Ordering**: Newest sessions appear first (reverse chronological order)
- **Timestamps**: Local time format (e.g., `2025-09-14 16:27 BST`)
- **File Structure**:

  ```
  ## Consolidated Learnings
  [Aggregated knowledge from all sessions]
  
  ---
  
  ## Recent Sessions
  
  ## [YYYY-MM-DD HH:MM TZ] - [Session Focus]
  **Project**: [project-name]
  **Documentation Seen**: [Brief list of doc locations from session]
  
  ### Learnings
  [Categorized learning entries]
  
  ---
  ```

The "Documentation Seen" field tracks references to documentation encountered during the session (e.g., "README.md, docstrings in lib/auth.ex, docs/api.md"). This helps identify which documentation is most relevant to the learnings generated.

### Learning Categories

Learnings are categorized and prioritized to ensure the most valuable knowledge is captured.

**Priority Order (Highest to Lowest):**

1. **User Corrections** (HIGHEST PRIORITY)
   - Direct corrections to agent understanding or approach
   - Critical to prevent repeating mistakes
   - Examples: "Tests should use `MyApp.DataCase` not `ExUnit.Case` for database tests", "API client retries must use exponential backoff, not fixed delays"

2. **New Requirements**
   - Project specifications not yet in documentation
   - Critical project requirements discovered during sessions
   - Examples: "All API responses must include `request_id` field for tracing", "Background jobs require `max_retries: 3` configuration"

3. **Fresh Discoveries**
   - Solutions, workarounds, or insights discovered during sessions
   - Valuable knowledge that saves time in future sessions
   - Examples: "The `UserCache` module must be warmed before first request or queries timeout", "External API rate limits reset at midnight UTC, not on rolling window"

4. **Updated Conventions**
   - Changes to established patterns or practices
   - Evolution of project standards over time
   - Examples: "Migration to new async pattern: use `Task.async_stream/3` instead of `Enum.map`", "Deprecating `LegacyAuth` module in favor of `Auth.V2`"

5. **Preference Clarifications**
   - User workflow, style, or tooling preferences
   - How the user prefers to work on this project
   - Examples: "User prefers `with` statements over nested `case` for readability", "Always run `mix format` before committing"

6. **Custom Categories** (Fallback)
   - Project-specific categories that don't fit the standard five
   - Should be specific (e.g., "Database Migration Strategy", "Third-party Integration")
   - Avoid generic categories like "Code Quality" or "Best Practices"

**The first three categories are by far the most important** and should be emphasized when presenting, storing, and recalling learnings.

### Learning Quality Criteria

To ensure high-quality learnings that provide genuine value across sessions, learnings must meet these criteria:

**High-Quality Learnings Are:**
- ✅ **Project-specific**: Unique to this project, not general software advice
- ✅ **Actionable**: Can be directly applied to future work
- ✅ **Specific**: Include file paths, function names, or concrete examples where relevant
- ✅ **Valuable**: Save time or prevent errors in future sessions
- ✅ **Factually valid**: Represent actual user feedback or discovered facts, not agent assumptions

**Reject Learnings That Are:**
- ❌ **Generic**: General programming advice applicable to any project
- ❌ **Obvious**: Already clear from existing documentation or code structure
- ❌ **Vague**: Too general to act on (e.g., "improve code quality", "write better tests")
- ❌ **Ephemeral**: Session-specific details with no future value (e.g., "fixed typo on line 42")
- ❌ **Unvalidated**: Agent assumptions or interpretations not confirmed by user

**Examples of High-Quality vs Low-Quality Learnings:**

Good: "Tests should use `MyApp.DataCase` not `ExUnit.Case` for database tests (corrected from initial approach)"
- Project-specific, actionable, specific, prevents future mistakes

Bad: "Tests should follow best practices"
- Generic, vague, not actionable

Good: "The `UserCache` module must be warmed before first request or queries timeout (discovered during debugging)"
- Project-specific, actionable, saves debugging time

Bad: "Debugging is useful for finding issues"
- Generic, obvious, no specific value

Good: "External API rate limits reset at midnight UTC, not on rolling window (found through testing)"
- Specific discovery, actionable, prevents API errors

Bad: "The API has rate limits"
- Obvious, not specific enough to be actionable

### Size Management

- **Size Limit**: Automatic compaction suggested when file exceeds 1MB
- **Growth Pattern**: File grows over time with each stored session
- **Maintenance**: Use `/learning-compact` command for periodic cleanup

## Command Specification

### Command Naming Convention

All commands follow the pattern `/learning-[action]`:

- `/learning-summarise`
- `/learning-store`
- `/learning-recall`
- `/learning-compact`
- `/learning-improve-docs`
- `/learning-forget`

### Command Implementation Requirements

Each command file in the `command/` directory must include:

- **YAML Frontmatter** with required fields:

  ```yaml
  ---
  description: Brief description of the command's purpose
  ---
  ```

- **Markdown Content** containing command instructions for agents

### Command Workflow

The system implements a 3-step core workflow with additional maintenance commands:

1. **Summarise** → Identify new learnings from current session
2. **Store** → Save validated learnings with timestamp
3. **Recall** → Load previous learnings in new sessions

Additional commands:

- **Compact** → Maintain memory file size and structure
- **Improve-docs** → Apply learnings to project documentation

## Command Behavior Specifications

### `/learning-summarise`

**Purpose**: Extract NEW learnings from current session while avoiding duplicates and tracking documentation seen

**Behavior**:

- Must use documentation already in agent context (from @mentions or exploration)
- Must read previous learnings from `.tmp/memory-learnings.md`
- Track references to documentation encountered in session using standardized format
- Filter potential learnings against existing knowledge base (context + previous learnings)
- Apply quality rubric to ensure only valuable learnings are captured
- Present learnings in priority order (User Corrections → New Requirements → Fresh Discoveries → Updated Conventions → Preference Clarifications → Custom Categories)
- Show deduplication work performed for transparency
- Include list of documentation seen for future reference
- Provide validation checklist for user review
- Handle "no new learnings" case gracefully
- Scales efficiently on large projects by not reading all documentation

#### Performance and Scaling Considerations

The `/learning-summarise` command is designed to scale efficiently on large projects by:

- Using documentation already in the agent's context (from @mentions or exploration)
- Avoiding exhaustive reading of all project documentation files
- Focusing deduplication on agent context + previous learnings only

This approach prevents performance degradation as project size grows while maintaining learning quality.

#### Documentation Reference Format

Documentation references must use standardized format:
- Individual files: `README.md`, `lib/auth.ex`
- With sections: `docs/api.md#authentication`
- Docstrings: `docstrings in lib/parser.ex`
- Multiple files: `README.md, CONTRIBUTING.md, docs/setup.md`

#### Categories for Learning Extraction (Priority Order)

Learnings must be categorized using this priority order:

1. **User Corrections** (HIGHEST PRIORITY) - Direct corrections to agent behavior
2. **New Requirements** - Project specifications not in documentation
3. **Fresh Discoveries** - Solutions and workarounds found during sessions
4. **Updated Conventions** - Changes to established patterns
5. **Preference Clarifications** - User workflow and style preferences
6. **Custom Categories** - Project-specific categories as needed (fallback)

The first three categories are by far the most important.

#### Quality Validation

Must apply quality rubric (see Learning Quality Criteria section) to filter out:
- Generic programming advice
- Obvious information from documentation/code
- Vague or unactionable statements
- Session-specific ephemeral details
- Unvalidated agent assumptions

Must include validation checklist in output for user review.

### `/learning-store`

**Purpose**: Save validated learnings and documentation references to memory file

**Behavior**:

- Append to `.tmp/memory-learnings.md` with local timestamp and session focus
- Include project name, session focus, and documentation seen
- Store brief references to documentation encountered (paths/locations only)
- Organize learnings by category in priority order
- Maintain reverse chronological order for sessions
- Handle file creation if it doesn't exist
- Only include category sections that have learnings (skip empty categories)

**Category Storage Order**:

Store learnings in this priority order within each session:
1. User Corrections (highest priority)
2. New Requirements
3. Fresh Discoveries
4. Updated Conventions
5. Preference Clarifications
6. Custom categories (alphabetically)

### `/learning-recall`

**Purpose**: Load and present previous learnings

**Behavior**:

- Read entire `.tmp/memory-learnings.md` file
- Parse consolidated learnings and recent sessions
- Consolidate similar learnings, preferring recent ones for conflicts
- Present consolidated knowledge to user in priority order
- Emphasize the first three categories (User Corrections, New Requirements, Fresh Discoveries) as most important
- Only show categories that have learnings (skip empty categories)
- Handle missing file (first session) gracefully
- Note any parse errors while loading what's possible

**Presentation Order**:

Present learnings in this priority order:
1. User Corrections (HIGHEST PRIORITY - emphasize these)
2. New Requirements (emphasize)
3. Fresh Discoveries (emphasize)
4. Updated Conventions
5. Preference Clarifications
6. Custom categories (alphabetically)

### `/learning-compact`

**Purpose**: Maintain memory file size and structure

**Behavior**:

- Trigger when file exceeds 1MB
- Create backup at `.tmp/memory-learnings.backup.md`
- Parse all sessions and extract learnings by category
- Consolidate learnings within each category (remove duplicates, merge similar, keep recent for contradictions)
- Preserve consolidated learnings at top in priority order
- Remove ALL previous individual sessions
- Report size reduction and number of sessions removed
- Only include categories that have learnings (skip empty categories)

**Consolidation Strategy by Category**:
- **User Corrections**: Keep all distinct corrections (critical, don't over-consolidate)
- **New Requirements**: Merge similar requirements while preserving specific details
- **Fresh Discoveries**: Consolidate related discoveries, keep unique solutions
- **Updated Conventions**: Keep only most recent convention for each pattern
- **Preference Clarifications**: Merge similar preferences
- **Custom Categories**: Apply category-appropriate consolidation logic

When in doubt, prefer keeping learnings over removing them.

**Output Order**:

Organize consolidated learnings in priority order:
1. User Corrections
2. New Requirements
3. Fresh Discoveries
4. Updated Conventions
5. Preference Clarifications
6. Custom categories (alphabetically)

### `/learning-improve-docs`

**Purpose**: Identify opportunities to improve project documentation

**Behavior**:

- Assumes `/learning-recall` has been run first
- Analyze consolidated learnings for documentation gaps
- Review "Documentation Seen" fields from recent sessions
- Prioritize improvements to documentation that was frequently accessed
- Connect learnings to the specific docs seen when they were generated
- Suggest specific files and sections for improvements
- Provide example content for documentation updates
- Prioritize most valuable improvements based on usage patterns

### `/learning-forget`

**Purpose**: Reset memory

**Behavior**:

- Resets memory file to empty

## Error Handling Requirements

Commands must handle common edge cases:

- **Missing Files**: Inform user appropriately for first-time usage
- **Empty Files**: Note when no learnings exist yet
- **Parse Errors**: Skip malformed sections, report what was successfully loaded
- **Large Files**: Warn when approaching or exceeding 1MB limit
- **No New Content**: Handle gracefully without unnecessary operations

## Documentation Tracking System

### Purpose

Track which documentation was seen during learning sessions to better target documentation improvements.

### What Constitutes "Documentation"

Documentation includes any form of structured knowledge in the project:

- **Source code docstrings**: Module and function documentation in code files
- **Documentation files**: README.md, CONTRIBUTING.md, files in docs/ directories
- **Specification files**: API specs, technical specifications, design documents
- **Agent convention files**: AGENTS.md, CLAUDE.md, .cursorrules, or similar AI assistant guidance files
- **Configuration documentation**: Comments in config files, setup guides

### Storage Strategy

- **Brief References Only**: Store only file paths and locations (e.g., "lib/auth.ex:45", "README.md#usage")
- **No Content Storage**: Never store actual documentation content to keep memory files lean
- **Performance Focus**: This approach ensures memory files remain manageable even in large projects

### Implementation

- **Session Tracking**: Record references to documentation encountered during each session
- **Brief References**: Store only paths/locations, not content (e.g., "docstrings in lib/auth.ex")
- **Connection Analysis**: Link learnings to the documentation seen when they were generated
- **Prioritization**: Use tracking data to prioritize improvements to frequently-accessed documentation

### Benefits

- **Targeted Improvements**: Focus on documentation that agents actually use
- **Context Awareness**: Understand which docs relate to specific learnings
- **Efficiency**: Identify high-impact documentation gaps based on usage patterns
- **Delta Recognition**: Recognize that learnings often represent gaps in the exact documentation the agent was reading
- **Feedback Loop Architecture**: Creates a direct connection between learnings and their source documentation
  - Enables identification of documentation that frequently generates learnings
  - Highlights documentation sections that may need improvement
  - Provides data-driven prioritization for documentation updates

## Deduplication System

### Purpose

Prevent repetitive learnings that reduce memory quality over time while ensuring valuable nuances and refinements are preserved.

### Semantic Deduplication Philosophy

The deduplication system intentionally includes semantic similarity filtering despite the inherent fuzziness:

- **Intent over precision**: Setting the right direction for agents matters more than perfect implementation
- **Agent discretion**: Agents use judgment to identify semantically similar learnings
- **User validation**: Final deduplication decisions are validated by users during `/learning-store`
- **Iterative refinement**: Over time, agents improve at semantic matching through learning patterns

### Implementation

- **Baseline Check**: Compare against existing documentation and previous learnings
- **Semantic Filtering**: Remove both exact duplicates AND semantically similar knowledge (even if worded differently)
- **Nuance Preservation**: Include refinements, corrections, or important nuances to existing knowledge
- **Transparency**: Show users what deduplication work was performed
- **Quality Focus**: Emphasize genuinely new, project-specific knowledge

### Exclusion Criteria

Exclude learnings that are:
- **Exact duplicates**: Already stated in previous learnings or documentation
- **Semantically duplicate**: Same meaning as existing knowledge, just worded differently
- **General best practices**: Not specific to this project (e.g., "use proper error handling")
- **Obvious information**: Clear from codebase structure or existing documentation
- **Too vague**: Cannot be acted upon (e.g., "improve code quality")
- **Ephemeral**: Session-specific with no future value (e.g., "fixed typo on line 42")

### Inclusion Criteria

Include learnings that are:
- **Genuinely new**: Not present in any form in documentation or previous learnings
- **Refinements**: Important clarifications or corrections to existing knowledge
- **Nuanced additions**: Add valuable context or specificity to general knowledge
- **Project-specific**: Unique to this project's requirements, patterns, or constraints

## System Integration

### File System Requirements

- Memory files stored in `.tmp/` directory (not version controlled)
- Backup files use `.backup.md` suffix
- Commands work across any project (not specific to this repository)

### Platform Integration

**OpenCode:**
- Commands installed by symlinking to `~/.config/opencode/command/`
- Uses standard markdown files with YAML frontmatter

**Claude Code:**
- Commands installed by symlinking to `~/.claude/commands/`
- Uses the same markdown files with YAML frontmatter

Both platforms support the same command format, making installation straightforward.

## External Dependencies

- **OpenCode or Claude Code**: Core command execution environment
- **Markdown Format**: For structured data storage
- **YAML**: For command frontmatter
- **Local Time Format**: For human-readable timestamps with timezone
