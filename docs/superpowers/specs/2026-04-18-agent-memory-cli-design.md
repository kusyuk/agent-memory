# agent-memory CLI Design

## Overview

A cross-platform CLI tool for managing cross-agent memory files. Supports installation via Homebrew, npm, pip, and self-installing script.

## Architecture

```
agent-memory/
├── bin/agent-memory          # Main bash CLI (primary implementation)
├── bin/agent-memory.bat      # Windows batch fallback
├── homebrew/agent-memory.rb  # Homebrew formula
├── package.json              # npm wrapper (calls bash script)
└── setup.py                  # pip wrapper (calls bash script)
```

## Data Flow

1. **User installs** via `brew install`, `npm install -G`, `pip install`, or curl script
2. **User runs** `agent-memory <command>` from any project directory
3. **CLI searches** upward for `.agent-memory/` directory (like git)
4. **CLI executes** command against found memory files

## Component Details

### bin/agent-memory (Main CLI)

**Supported commands:**

| Command | Description |
|---------|-------------|
| `agent-memory init` | Initialize `.agent-memory/` directory with templates |
| `agent-memory save [completed] [current] [next]` | Save current state to snapshot |
| `agent-memory resume` | Load and display memory state for next agent |
| `agent-memory status` | Show current state of all memory files |
| `agent-memory help` | Display help |

**Key behaviors:**
- Recursive `.agent-memory/` directory search from current directory upward
- Automatic initialization if `.agent-memory/` doesn't exist (when running `init`)
- Timestamps in ISO 8601 format for consistency
- Clear error messages for missing memory files

**Example usage:**
```bash
# Initialize memory in current project
cd ~/projects/my-app
agent-memory init

# Save work state
agent-memory save "auth module complete" "billing integration" "add tests"

# Resume work (shows memory state)
agent-memory resume
```

### bin/agent-memory.bat (Windows Fallback)

Simple batch wrapper that calls `agent-memory` bash script via WSL or git-bash if available.

### Homebrew Formula

Install via `brew install owner/repo/agent-memory`.

### npm Package

Install via `npm install -g agent-memory`.
- `package.json` exports `agent-memory` as a binary
- Wrapper calls `bin/agent-memory`

### pip Package

Install via `pip install agent-memory`.
- Wrapper calls `bin/agent-memory`

### project.json (Homebrew Config)

```json
{
  "name": "agent-memory",
  "version": "1.0.0",
  "description": "CLI for cross-agent memory management",
  "main": "bin/agent-memory",
  "bin": {
    "agent-memory": "bin/agent-memory"
  },
  "repository": "https://github.com/owner/agent-memory",
  "keywords": ["cli", "agentic", "memory"],
  "license": "MIT"
}
```

## Error Handling

| Error Case | Action |
|------------|--------|
| No `.agent-memory/` found | Search up to 10 directory levels, then error |
| Invalid command | Show help with available commands |
| Missing arguments | Show usage for specific command |
| Permission denied | Suggest `chmod +x` or run with `bash` |

## Testing

- **Bash unit tests:** `bats` or `shunit2` for CLI logic
- **Integration tests:** Test from subdirectory to verify recursive search
- **Cross-platform tests:** Test bash script via WSL on Windows

## Success Criteria

1. Users can install via any of: Homebrew, npm, pip, curl
2. `agent-memory` works from any subdirectory in a project
3. All commands function correctly with and without arguments
4. Memory files are properly created/updated
5. Error messages are clear and actionable

## Implementation Notes

- Use POSIX-compliant bash for maximum compatibility
- Avoid GNU-specific extensions unless handled with fallbacks
- Keep scripts under 500 lines each for readability
- Use `set -euo pipefail` for error handling
- Log to stderr, not stdout, for commands that produce output