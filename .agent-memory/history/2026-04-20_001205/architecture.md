# Architecture

<!-- AGENT MEMORY - DO NOT EDIT ABOVE THIS LINE -->
<!-- Version: 1.0.0 -->
<!-- Last updated: 2026-04-18 -->

## High-Level Structure

The system is a file-based memory store located in `.agent-memory/`. It uses a set of standardized Markdown files to preserve state between AI agents. Coordination is handled via a lightweight lock file.

```
.agent-memory/
├── context.md          # Project roadmap and recent history
├── tasks.md            # Active and pending task tracking
├── decisions.md        # Architectural and design logic log
├── architecture.md     # System structure and technology stack
├── snapshot.md         # Hand-off state for the next agent
└── agent-lock.txt      # Concurrency management
```

## Technology Stack
- **Framework**: Custom Bash-based CLI logic
- **Language**: POSIX-compliant Bash, Markdown
- **Key dependencies**: `grep`, `cat`, `date`, `chmod`

## Key Patterns
- **Standardized Markers**: All files use HTML comments as delimiters for structured parsing by agents.
- **Idempotent Initialization**: The `init` script creates missing files without overwriting existing data.
- **Atomic Locking**: `agent-lock.txt` ensures only one agent is significantly modifying the context at a time.

## API Contracts
- **CLI Subcommands**: `init`, `save`, `resume [agent-id]`, `list-agents`, `status`, `validate`.
- **Exit Hook**: Writes a standardized JSON-like header to `snapshot.md`.

## Data Models
- **Markdown Sections**: Use standard H2 headers (`##`) for category segmentation.
- **Agent Specific Context**: Targeted instructions stored under `## Agent Contexts` with `### agent-id` subheaders in `snapshot.md`.
