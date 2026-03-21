<!-- ALL_AGENTS.md — Single source of truth for AI agent project documentation -->
<!-- Edit ONLY this file. Changes sync to CLAUDE.md, AGENTS.md, GEMINI.md -->
<!-- Sync: ./sync-agents.sh (manual) or git commit (if hook installed) -->
<!-- Tool-specific sections: use CLAUDE_ONLY / CODEX_ONLY / GEMINI_ONLY markers -->

# {PROJECT_NAME}

## Project Overview

{Brief description: what the project does, its purpose, and target users.}

## Tech Stack

- **Language**: {e.g., TypeScript (strict mode)}
- **Framework**: {e.g., React 18, Next.js 14}
- **Build Tool**: {e.g., Vite 5, Webpack}
- **Package Manager**: {e.g., npm / yarn / pnpm / bun}
- **Styling**: {e.g., Tailwind CSS, CSS Modules}
- **State Management**: {e.g., Zustand, Jotai, Redux}
- **Testing**: {e.g., Vitest, Jest, Playwright}

## Key Commands

```bash
{install_command}     # Install dependencies
{dev_command}         # Start dev server
{build_command}       # Production build
{test_command}        # Run tests
{lint_command}        # Lint / format
```

## Directory Structure

```
{project_root}/
├── src/
│   ├── {dir1}/      # {description}
│   ├── {dir2}/      # {description}
│   └── ...
├── {config_files}
└── ...
```

## Architecture

{Key patterns: component structure, data flow, state management,
API layer, error handling, module organization, etc.}

## Important Files

| File | Purpose |
|------|---------|
| {file1} | {purpose} |
| {file2} | {purpose} |

## Conventions

- {Code style / formatting rules}
- {Import conventions / path aliases}
- {Naming conventions}
- {Git workflow / branch strategy}

## Common Tasks

### Adding a New Feature

{Steps to add typical new functionality in this project.}

<!-- CLAUDE_ONLY -->
## Claude-Specific Notes

{Claude Code specific instructions: memory hints, preferred tools, response style, etc.}
<!-- /CLAUDE_ONLY -->

<!-- CODEX_ONLY -->
## Codex-Specific Notes

{Codex CLI specific instructions: sandbox environment, preferred patterns, etc.}
<!-- /CODEX_ONLY -->

<!-- GEMINI_ONLY -->
## Gemini-Specific Notes

{Gemini CLI specific instructions: model preferences, tool usage, etc.}
<!-- /GEMINI_ONLY -->
