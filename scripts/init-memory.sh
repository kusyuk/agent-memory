#!/bin/bash
# Initialize memory files for cross-agent collaboration

set -e

MEMORY_DIR=".memory"

# Create directory if missing
mkdir -p "$MEMORY_DIR"

# Create files only if they don't exist
if [ ! -f "$MEMORY_DIR/context.md" ]; then
  cat > "$MEMORY_DIR/context.md" << 'EOF'
# Project Context

<!-- AGENT MEMORY - DO NOT EDIT ABOVE THIS LINE -->
<!-- Version: 1.0.0 -->
<!-- Last updated: $(date +%Y-%m-%d) -->

## Current State
[Agent fills this in]

## Recent Changes
- [Last agent] - Change description (YYYY-MM-DD)

## Active Work Streams
- [ ] Task description

## Known Issues/Blockers
- [ ] Issue description
EOF
fi

if [ ! -f "$MEMORY_DIR/tasks.md" ]; then
  cat > "$MEMORY_DIR/tasks.md" << 'EOF'
# Tasks

<!-- AGENT MEMORY - DO NOT EDIT ABOVE THIS LINE -->
<!-- Version: 1.0.0 -->
<!-- Last updated: $(date +%Y-%m-%d) -->

## In Progress
- [ ] ID: `task-001` - Description (assigned: last-agent, created: YYYY-MM-DD)

## TODO
- [ ] ID: `task-002` - Description (assigned: next-agent, created: YYYY-MM-DD, priority: HIGH)

## Completed
- [x] ID: `task-000` - Description (completed: YYYY-MM-DD)
EOF
fi

if [ ! -f "$MEMORY_DIR/decisions.md" ]; then
  cat > "$MEMORY_DIR/decisions.md" << 'EOF'
# Decisions Log

<!-- AGENT MEMORY - DO NOT EDIT ABOVE THIS LINE -->
<!-- Version: 1.0.0 -->
<!-- Last updated: $(date +%Y-%m-%d) -->

## Decision Log

### [YYYY-MM-DD] Decision ID
- **Problem:** What was being decided
- **Options considered:** Option A, Option B, Option C
- **Chosen:** Option B
- **Rationale:** Why this option was selected
- **By:** agent-name
EOF
fi

if [ ! -f "$MEMORY_DIR/architecture.md" ]; then
  cat > "$MEMORY_DIR/architecture.md" << 'EOF'
# Architecture

<!-- AGENT MEMORY - DO NOT EDIT ABOVE THIS LINE -->
<!-- Version: 1.0.0 -->
<!-- Last updated: $(date +%Y-%m-%d) -->

## High-Level Structure

[Diagram description or file structure]

## Technology Stack
- Framework: [name]
- Language: [name]
- Key dependencies: [list]

## Key Patterns
- [Pattern name]: Description

## API Contracts
[API documentation or references]

## Data Models
[Schema or type definitions]
EOF
fi

if [ ! -f "$MEMORY_DIR/snapshot.md" ]; then
  cat > "$MEMORY_DIR/snapshot.md" << 'EOF'
# Agent Snapshot

<!-- AGENT MEMORY - DO NOT EDIT ABOVE THIS LINE -->
<!-- Version: 1.0.0 -->
<!-- Last updated: $(date +%Y-%m-%d) -->

## Last Agent
- Agent ID: [claude-code/antigravity/etc]
- Session timestamp: [YYYY-MM-DD HH:MM:SS]

## Recent Work
- Last completed action: [description]
- Current focus: [what's being worked on]

## Next Steps
1. [Step 1]
2. [Step 2]
3. [Step 3]

## Context Notes
[Any additional notes for next agent]
EOF
fi

if [ ! -f "$MEMORY_DIR/agent-lock.txt" ]; then
  cat > "$MEMORY_DIR/agent-lock.txt" << 'EOF'
# Agent Lock File
# Format: AGENT_ID|WORK_ON|SINCE_TIMESTAMP|ESTIMATED_COMPLETION
# Example: claude-code|implementing-auth|2026-04-18T14:30:00|2026-04-18T16:00:00
# To lock: echo "agent-name|task|timestamp|estimated" > agent-lock.txt
EOF
fi

echo "Memory initialized in $MEMORY_DIR/"
