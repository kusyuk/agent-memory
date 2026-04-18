# Cross-Agent Memory System Design

## Overview

A local, file-based memory system that allows agentic AI assistants to preserve and transfer context when switching between tools (e.g., from Antigravity to Claude Code).

## Architecture

```
.agent-memory/
├── context.md          # Current project state and recent work
├── tasks.md            # Incomplete tasks and progress tracking
├── decisions.md        # Key decisions and their rationale
├── architecture.md     # High-level code structure and patterns
├── snapshot.md         # Last agent's working state and next steps
└── agent-lock.txt      # Coordination file (prevents overwrites)
```

## Data Flow

1. **Agent startup:** Read all `.agent-memory/*.md` files to understand project state
2. **Context integration:** Incorporate memory into system prompt/workspace context
3. **During work:** Update relevant memory files as progress is made
4. **Agent exit:** Write snapshot with current state and next steps
5. **Next agent:** Read snapshot to understand last work, then read full context

## Component Details

### context.md
- Current project state summary
- Recent changes and their rationale
- Active work streams
- Known issues or blockers

### tasks.md
- **Task structure:**
  - ID: Unique identifier
  - Status: TODO, IN_PROGRESS, BLOCKED
  - Priority: HIGH, MEDIUM, LOW
  - Description: What needs to be done
  - Assigned to: Last agent or user
  - Created: Timestamp
  - Updated: Timestamp

### decisions.md
- **Decision structure:**
  - ID: Unique identifier
  - Problem: What was being decided
  - Options considered: List of alternatives
  - Chosen: Final decision
  - Rationale: Why this option was selected
  - Date: When decision was made

### architecture.md
- High-level code structure
- Key patterns and conventions
- Technology stack
- API contracts or interfaces
- Data models or schemas

### snapshot.md
- **Agent exit state:**
  - Agent ID: Which tool was working
  - Last completed action: What was just finished
  - Current focus: What's being worked on
  - Next steps: Clear instructions for next agent
  - Token budget remaining: (Optional, for budget-aware agents)

### agent-lock.txt
- Format: `AGENT_ID|WORK_ON|SINCE_TIMESTAMP|ESTIMATED_COMPLETION`
- Purpose: Signal that work is in progress

## Error Handling

- **Conflict detection:** If `agent-lock.txt` indicates active work, warn or wait
- **Versioning:** Include memory format version in each file header
- **Fallback:** If memory files are missing, start fresh but log the situation

## Testing

- Simulate handoff between "agents" by writing test data then reading it back
- Verify memory files are idempotent (safe to read multiple times)
- Test concurrent access scenarios

## Success Criteria

1. A new agent can understand project state within 1-2 read cycles
2. Context transfer requires no manual intervention
3. Memory files remain readable and editable by humans
4. Handoffs preserve work progress without loss

## Implementation Notes

- Use clear delimiters/comments so agents know where to write
- Keep files under 500 lines for readability
- Use timestamps for all changes
- Never overwrite memory files; append or update sections
