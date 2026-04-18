# Agentic Memory

Agentic Memory is a lightweight, local, file-based memory system designed to preserve and transfer context when switching between different agentic AI assistants (e.g., from Antigravity to Claude Code).

It ensures that no matter which tool you or your agents use, the project's state, task progress, and architectural decisions remain consistent and accessible.

## 🚀 Key Features

-   **Context Handoff**: Standardized `snapshot.md` for seamless agent transitions.
-   **Task Tracking**: Persistent task queue shared across all agents.
-   **Decision Log**: Historical record of design choices and their rationales.
-   **No Dependencies**: Pure POSIX-compliant Bash and Markdown.
-   **Tool Agnostic**: Works with any AI agent that can read and write files.

---

## 🚀 Installation

### 🎖️ Recommended (Global)

**Via npm:**
```bash
npm install -g kusyuk-agent-memory
```

**Via Homebrew (macOS/Linux):**
```bash
brew install agent-memory
```
*(Alternative: `brew install kusyuk/tap/agent-memory` if failed)*

### 🛠️ Developer (Local)

If you prefer to install locally from source:
```bash
git clone https://github.com/kusyuk/agent-memory.git
cd agent-memory
make install
```

### 2. Initialization

To start using Agentic Memory in a new or existing project, run the `init` command from your project root:

```bash
agent-memory init
```

This will create a `.agent-memory/` directory with the following structure:
-   `context.md`: High-level project state.
-   `tasks.md`: The active task queue.
-   `decisions.md`: Log of key design decisions.
-   `architecture.md`: Technical structure and patterns.
-   `snapshot.md`: Last agent's exit state.
-   `agent-lock.txt`: Coordination lock.

---

## 📖 Usage Guide

### `agent-memory resume [agent-id]`
**Call this at the start of a new session.** It displays a summary of the current project state, tasks in progress, and the last agent's snapshot so the current agent can get up to speed immediately.
-   `agent-id` (optional): If provided, the CLI will look for a dedicated section in `snapshot.md` (e.g., `### gemini-cli`) and display it. This is useful for providing agent-specific instructions or tips.

### `agent-memory list-agents`
Lists all agents that have specific contexts defined in the `snapshot.md` file. This helps you identify which `agent-id`s can be used with the `resume` command.

### `agent-memory save [completed] [current] [next]`
**Call this before ending a session.** It updates the `snapshot.md` with what you've done and what the next agent should focus on.
-   `completed`: Description of the last finished action.
-   `current`: What is being worked on right now.
-   `next`: Explicit instructions for the next agent.

### `agent-memory status`
Displays the current status of all memory files and indicates if an agent currently holds a lock on the project.

### `agent-memory validate`
Verifies the integrity of the `.agent-memory/` directory and ensures all required files are present and contain the mandatory header markers.

---

## 🔄 The Handoff Workflow

To successfully transfer context between different AI tools, follow these steps:

### 1. Agent A (Exiting)
Before you switch tools, ensure the current agent saves its state. You can do this yourself, or tell the agent: **"Save your progress to the memory system."**

```bash
agent-memory save "Completed CLI logic" "Updating README" "Implement Homebrew formula"
```

### 2. You (The Human)
When you start the new agent, your first message should be the resume command itself. **Do not run it in your terminal.** Instead, type it directly into the AI agent's chat window.

**Recommended Prompt to the AI:**
> "agent-memory resume [agent-id]"

### 3. Why this works
-   **Autonomous Onboarding**: The output of `resume` is wrapped in a **System Prompt**. When the agent runs the command, it receives a direct instruction to internalize the context.
-   **Safety Guardrail**: The agent is explicitly instructed to summarize the previous session and **ask for your confirmation** before starting any new work.
-   **Deep Context**: The `.agent-memory/` directory remains available for the agent to reference specific architectural details or decision logs as needed.

---

## 🤝 For AI Agents

Agents should follow these rules when interacting with this project:
1.  **On Startup**: If you see a `.agent-memory/` directory, run `agent-memory resume [agent-id]` immediately.
2.  **Handoff Protocol**: After running `resume`, summarize the current state for the user and **ask for confirmation** before proceeding with any tasks.
3.  **During Work**: Update `tasks.md` and `decisions.md` as progress is made.
4.  **On Exit**: Always run `agent-memory save` to provide a clean handoff for the next agent.
5.  **Format Safety**: Never overwrite the file markers (e.g., `<!-- AGENT MEMORY ... -->`).

---

## 📄 License
MIT
