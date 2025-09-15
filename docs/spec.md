# Opencode Memory System Specification

This document contains the technical specification for the opencode memory system - a learning system that helps AI coding agents remember project-specific knowledge across sessions.

## Project Purpose

### Problem Statement

AI coding agents frequently lose context between sessions, requiring users to repeatedly explain:

- Project-specific conventions and patterns
- API quirks and integration requirements
- Design decisions and architectural choices
- User preferences and workflow patterns
- Solutions to previously encountered problems

### Solution

The opencode memory system provides persistent learning capabilities that allow agents to:

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
5. **Integration**: Seamlessly work with existing opencode workflows

## High-Level Architecture

### Core Components

1. **Learning Commands** (`command/` directory)
   - Individual command files implementing the learning workflow
   - Each command contains agent instructions for specific learning operations
   - Commands integrate with opencode's command execution system

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

The system integrates with the opencode platform through:

- **Command Interface**: Standard opencode command files, which become "slash" commands in the opencode chat interface
- **File System**: Local project-specific storage
- **Agent Context**: Knowledge loaded into agent working memory
- **User Workflow**: Seamless integration with coding sessions

## System Overview

The memory system is implemented as a set of "commands" for opencode that allow agents to:

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

Learnings are categorized and prioritized to ensure the most valuable knowledge is captured:

1. **User Corrections** (Highest Priority) - Direct corrections to agent behavior
2. **New Requirements** - Project specifications not in existing documentation  
3. **Updated Conventions** - Changes to established patterns
4. **Fresh Discoveries** - Solutions and workarounds found during sessions
5. **Preference Clarifications** - User workflow and style preferences

This prioritization ensures that critical corrections and requirements are never overlooked.

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
- Track references to documentation encountered in session (files, docstrings, conventions)
- Filter potential learnings against existing knowledge base (context + previous learnings)
- Present only genuinely new or updated information
- Show deduplication work performed for transparency
- Include list of documentation seen for future reference
- Handle "no new learnings" case gracefully
- Scales efficiently on large projects by not reading all documentation

#### Performance and Scaling Considerations

The `/learning-summarise` command is designed to scale efficiently on large projects by:

- Using documentation already in the agent's context (from @mentions or exploration)
- Avoiding exhaustive reading of all project documentation files
- Focusing deduplication on agent context + previous learnings only

This approach prevents performance degradation as project size grows while maintaining learning quality.

**Categories for Learning Extraction**:

- User corrections and clarifications
- New requirements not in documentation
- Updated conventions or patterns
- Fresh discoveries and solutions
- Workflow and style preferences

### `/learning-store`

**Purpose**: Save validated learnings and documentation references to memory file

**Behavior**:

- Append to `.tmp/memory-learnings.md` with local timestamp and session focus
- Include project name, session focus, and documentation seen
- Store brief references to documentation encountered (paths/locations only)
- Organize learnings by category
- Maintain reverse chronological order
- Handle file creation if it doesn't exist

### `/learning-recall`

**Purpose**: Load and present previous learnings

**Behavior**:

- Read entire `.tmp/memory-learnings.md` file
- Parse consolidated learnings and recent sessions
- Present consolidated knowledge to user
- Handle missing file (first session) gracefully
- Note any parse errors while loading what's possible

### `/learning-compact`

**Purpose**: Maintain memory file size and structure

**Behavior**:

- Trigger when file exceeds 1MB
- Create backup at `.tmp/memory-learnings.backup.md`
- Preserve consolidated learnings at top
- Remove ALL previous individual sessions
- Update consolidated learnings with any remaining valuable patterns from removed sessions

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

Prevent repetitive learnings that reduce memory quality over time.

### Implementation

- **Baseline Check**: Compare against existing documentation and previous learnings
- **Filtering**: Remove duplicates, general best practices, and obvious information
- **Transparency**: Show users what deduplication work was performed
- **Quality Focus**: Emphasize genuinely new, project-specific knowledge

### Categories to Exclude

- Information already in agent's context or known documentation
- Repeated knowledge from previous sessions
- General best practices rather than project-specific insights
- Obvious conclusions from codebase structure or files already seen

## System Integration

### File System Requirements

- Memory files stored in `.tmp/` directory (not version controlled)
- Backup files use `.backup.md` suffix
- Commands work across any project (not specific to opencode-memory)

### Opencode Integration

- Commands installed by symlinking to `~/.config/opencode/command/`
- Commands follow opencode command file format
- Integration with opencode agent system

## External Dependencies

- **Opencode Platform**: Core command execution environment
- **Markdown Format**: For structured data storage
- **YAML**: For command frontmatter
- **Local Time Format**: For human-readable timestamps with timezone
