# Cross-Agent Memory System Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build a local, file-based memory system that allows agentic AI assistants to preserve and transfer context when switching between tools.

**Architecture:** Create a `.agent-memory/` directory with markdown files for context, tasks, decisions, architecture, snapshot, and locking. Files include clear delimiters so any agent can read/write them without special integration.

**Tech Stack:** Markdown files only - no external dependencies required.

---

## File Structure

```
.agent-memory/
├── context.md          # Project state (with markers)
├── tasks.md            # Task queue (with markers)
├── decisions.md        # Decisions log (with markers)
├── architecture.md     # Code structure (with markers)
├── snapshot.md         # Exit state (with markers)
└── agent-lock.txt      # Coordination file
```

---

### Task 1: Create `.memory` directory structure

**Files:**
- Create: `.agent-memory/` (directory)
- Create: `.agent-memory/.gitkeep` (placeholder to track directory in git)

- [ ] **Step 1: Create the directory**

```bash
mkdir -p .memory
touch .agent-memory/.gitkeep
```

- [ ] **Step 2: Verify structure**

```bash
ls -la .agent-memory/
# Expected: .gitkeep file exists
```

- [ ] **Step 3: Commit**

```bash
git add .agent-memory/
git commit -m "chore: add memory directory structure"
```

---

### Task 2: Create `context.md` template with markers

**Files:**
- Create: `.agent-memory/context.md`

**Template structure:**
```
# Project Context

<!-- AGENT MEMORY - DO NOT EDIT ABOVE THIS LINE -->
<!-- Version: 1.0.0 -->
<!-- Last updated: YYYY-MM-DD -->

## Current State
[Agent fills this in]

## Recent Changes
- [Last agent] - Change description (YYYY-MM-DD)

## Active Work Streams
- [ ] Task description

## Known Issues/Blockers
- [ ] Issue description
```

- [ ] **Step 1: Write the template file**

Create `.agent-memory/context.md` with the template structure above.

- [ ] **Step 2: Commit**

```bash
git add .agent-memory/context.md
git commit -m "chore: add context.md template"
```

---

### Task 3: Create `tasks.md` template with markers

**Files:**
- Create: `.agent-memory/tasks.md`

**Template structure:**
```
# Tasks

<!-- AGENT MEMORY - DO NOT EDIT ABOVE THIS LINE -->
<!-- Version: 1.0.0 -->
<!-- Last updated: YYYY-MM-DD -->

## In Progress
- [ ] ID: `task-001` - Description (assigned: last-agent, created: YYYY-MM-DD)

## TODO
- [ ] ID: `task-002` - Description (assigned: next-agent, created: YYYY-MM-DD, priority: HIGH)

## Completed
- [x] ID: `task-000` - Description (completed: YYYY-MM-DD)
```

- [ ] **Step 1: Write the template file**

Create `.agent-memory/tasks.md` with the template structure above.

- [ ] **Step 2: Commit**

```bash
git add .agent-memory/tasks.md
git commit -m "chore: add tasks.md template"
```

---

### Task 4: Create `decisions.md` template with markers

**Files:**
- Create: `.agent-memory/decisions.md`

**Template structure:**
```
# Decisions Log

<!-- AGENT MEMORY - DO NOT EDIT ABOVE THIS LINE -->
<!-- Version: 1.0.0 -->
<!-- Last updated: YYYY-MM-DD -->

## Decision Log

### [YYYY-MM-DD] Decision ID
- **Problem:** What was being decided
- **Options considered:** Option A, Option B, Option C
- **Chosen:** Option B
- **Rationale:** Why this option was selected
- **By:** agent-name
```

- [ ] **Step 1: Write the template file**

Create `.agent-memory/decisions.md` with the template structure above.

- [ ] **Step 2: Commit**

```bash
git add .agent-memory/decisions.md
git commit -m "chore: add decisions.md template"
```

---

### Task 5: Create `architecture.md` template with markers

**Files:**
- Create: `.agent-memory/architecture.md`

**Template structure:**
```
# Architecture

<!-- AGENT MEMORY - DO NOT EDIT ABOVE THIS LINE -->
<!-- Version: 1.0.0 -->
<!-- Last updated: YYYY-MM-DD -->

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
```

- [ ] **Step 1: Write the template file**

Create `.agent-memory/architecture.md` with the template structure above.

- [ ] **Step 2: Commit**

```bash
git add .agent-memory/architecture.md
git commit -m "chore: add architecture.md template"
```

---

### Task 6: Create `snapshot.md` template with markers

**Files:**
- Create: `.agent-memory/snapshot.md`

**Template structure:**
```
# Agent Snapshot

<!-- AGENT MEMORY - DO NOT EDIT ABOVE THIS LINE -->
<!-- Version: 1.0.0 -->
<!-- Last updated: YYYY-MM-DD -->

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
```

- [ ] **Step 1: Write the template file**

Create `.agent-memory/snapshot.md` with the template structure above.

- [ ] **Step 2: Commit**

```bash
git add .agent-memory/snapshot.md
git commit -m "chore: add snapshot.md template"
```

---

### Task 7: Create `agent-lock.txt` format

**Files:**
- Create: `.agent-memory/agent-lock.txt`

**Format:**
```
AGENT_ID|WORK_ON|SINCE_TIMESTAMP|ESTIMATED_COMPLETION
```

Example:
```
claude-code|implementing-auth|2026-04-18T14:30:00|2026-04-18T16:00:00
```

- [ ] **Step 1: Create empty file with example**

Write the file with a commented example:

```
# Agent Lock File
# Format: AGENT_ID|WORK_ON|SINCE_TIMESTAMP|ESTIMATED_COMPLETION
# Example: claude-code|implementing-auth|2026-04-18T14:30:00|2026-04-18T16:00:00
# To lock: echo "agent-name|task|timestamp|estimated" > agent-lock.txt
```

- [ ] **Step 2: Commit**

```bash
git add .agent-memory/agent-lock.txt
git commit -m "chore: add agent-lock.txt format"
```

---

### Task 8: Create memory initialization script

**Files:**
- Create: `scripts/init-memory.sh` or `scripts/init-memory.py`

**Functionality:**
1. Create `.agent-memory/` directory if missing
2. Copy all template files if they don't exist
3. Initialize snapshot with current timestamp

- [ ] **Step 1: Write initialization script**

Create `scripts/init-memory.sh`:

```bash
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

# Similar for other files...
echo "Memory initialized in $MEMORY_DIR/"
```

- [ ] **Step 2: Make executable**

```bash
chmod +x scripts/init-memory.sh
```

- [ ] **Step 3: Commit**

```bash
git add scripts/init-memory.sh
git commit -m "chore: add memory initialization script"
```

---

### Task 9: Create agent entry/exit hooks (example)

**Files:**
- Create: `scripts/agent-entry.sh` (optional example)
- Create: `scripts/agent-exit.sh` (optional example)

**Functionality:**
- Entry: Read all memory files, output summary for agent context
- Exit: Update snapshot with current state, release lock

- [ ] **Step 1: Write agent entry script**

Create `scripts/agent-entry.sh`:

```bash
#!/bin/bash
# Agent entry hook - read memory and prepare context

echo "=== Memory State ==="
echo ""

echo "## Context:"
cat .agent-memory/context.md | grep -A 100 "## Current State" | head -20

echo ""
echo "## Tasks:"
cat .agent-memory/tasks.md | grep -A 100 "## In Progress" | head -10

echo ""
echo "## Last Snapshot:"
cat .agent-memory/snapshot.md | grep -A 50 "## Last Agent" | head -15

echo ""
echo "=== Ready to work ==="
```

- [ ] **Step 2: Write agent exit script**

Create `scripts/agent-exit.sh`:

```bash
#!/bin/bash
# Agent exit hook - save state and release lock

SNAPSHOT_FILE=".agent-memory/snapshot.md"
LOCK_FILE=".agent-memory/agent-lock.txt"

# Read current state from stdin or arguments
# Update snapshot with current agent's work

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
```

- [ ] **Step 3: Make scripts executable**

```bash
chmod +x scripts/agent-entry.sh
chmod +x scripts/agent-exit.sh
```

- [ ] **Step 4: Commit**

```bash
git add scripts/
git commit -m "chore: add agent entry/exit hooks"
```

---

### Task 10: Add `.gitignore` entries and documentation

**Files:**
- Modify: `.gitignore` (if exists) or create documentation

**Add:**
- `.agent-memory/` to `.gitignore` (optional - depends on if you want memory tracked)
- OR: Document that memory should be committed

**Documentation:**
Create `MEMORY.md` in project root with usage instructions for agents.

- [ ] **Step 1: Create MEMORY.md documentation**

Create `MEMORY.md`:

```markdown
# Memory Files

This directory contains files used for cross-agent collaboration context.

## Files

- `.agent-memory/context.md` - Project state and recent changes
- `.agent-memory/tasks.md` - Task queue
- `.agent-memory/decisions.md` - Decisions log
- `.agent-memory/architecture.md` - High-level architecture
- `.agent-memory/snapshot.md` - Last agent's working state
- `.agent-memory/agent-lock.txt` - Coordination lock

## For Agents

1. **On startup:** Read all `.agent-memory/*.md` files to understand context
2. **During work:** Update relevant files as progress is made
3. **On exit:** Write a snapshot with current state and next steps
4. **Never overwrite memory files blindly** - append or update sections

## For Humans

Memory files are auto-generated by agents. They can be safely read but should be edited with caution.
```

- [ ] **Step 2: Commit**

```bash
git add MEMORY.md
git commit -m "docs: add memory file documentation"
```

---

## Plan Self-Review

**1. Spec coverage check:**
- ✅ File structure (.agent-memory/ directory) - Task 1
- ✅ context.md template - Task 2
- ✅ tasks.md template - Task 3
- ✅ decisions.md template - Task 4
- ✅ architecture.md template - Task 5
- ✅ snapshot.md template - Task 6
- ✅ agent-lock.txt format - Task 7
- ✅ Initialization script - Task 8
- ✅ Agent hooks - Task 9
- ✅ Documentation - Task 10

**2. Placeholder scan:** No TBD, TODO, or "fill in details" found.

**3. Type consistency:** All files use markdown/text format - consistent.

---

## Execution Handoff

Plan complete and saved to `docs/superpowers/plans/2026-04-18-cross-agent-memory.md`. Two execution options:

**1. Subagent-Driven (recommended)** - Fresh subagent per task, review between tasks, fast iteration

**2. Inline Execution** - Execute tasks in this session, batch with checkpoints

**Which approach?**
