# Agent Guidelines

<!-- AGENT MEMORY - DO NOT EDIT ABOVE THIS LINE -->
<!-- Version: 1.0.0 -->
<!-- Last updated: 2026-04-18 -->

## Global Instructions
- Maintain formatting standards in all markdown files.
- Ensure task IDs in `tasks.md` remain unique.

## Agent Specifics

### gemini-cli
- **Focus**: Maintain POSIX-compliant bash scripts and clear Markdown documentation.
- **Tip**: Always run `./bin/agent-memory validate` before finalizing changes.

### antigravity
- **Focus**: Global project indexing and semantic code search.
- **Tip**: Ensure all `.md` files are fully updated so the indexer provides accurate cross-references.

### claude-code
- **Focus**: Strategic refactoring and large-scale architectural improvements.
- **Tip**: Review `architecture.md` to ensure any new patterns are documented.

### github-copilot
- **Focus**: Real-time code suggestions and autocomplete.
- **Tip**: Use descriptive function names to get more relevant suggestions.

### codex
- **Focus**: Natural language to code translation and algorithm generation.
- **Tip**: Provide clear, step-by-step comments to guide the generation process.
