#!/bin/bash
# Agent exit hook - save state and release lock

SNAPSHOT_FILE=".memory/snapshot.md"
LOCK_FILE=".memory/agent-lock.txt"

# Format: agent-exit.sh "<completed>" "<current>" "<next>"
COMPLETED="${1:-none}"
CURRENT="${2:-none}"
NEXT="${3:-none}"

# Update snapshot
cat > "$SNAPSHOT_FILE" << EOF
# Agent Snapshot

<!-- AGENT MEMORY - DO NOT EDIT ABOVE THIS LINE -->
<!-- Version: 1.0.0 -->
<!-- Last updated: $(date -Iseconds) -->

## Last Agent
- Agent ID: $(whoami)
- Session timestamp: $(date -Iseconds)

## Recent Work
- Last completed action: $COMPLETED
- Current focus: $CURRENT

## Next Steps
1. $NEXT

## Context Notes
Work continued from previous session.
EOF

# Release lock (empty file or remove)
> "$LOCK_FILE"

echo "Session saved to snapshot."
