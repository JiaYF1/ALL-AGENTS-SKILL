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

| File    | Purpose   |
| ------- | --------- |
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

## 文档维护说明（AI Agent 必读）

> 本文件由 `ALL_AGENTS.md` 自动生成，**请勿直接编辑此文件**。
>
> 如需更新项目文档（包括架构、命令、规范等任何章节）：
>
> 1. 编辑项目根目录的 `ALL_AGENTS.md`（唯一信息源）
> 2. 运行 `./sync-agents.sh` 将改动同步到 `CLAUDE.md`、`AGENTS.md`、`GEMINI.md`
> 3. 提交全部变更文件：`ALL_AGENTS.md`、`CLAUDE.md`、`AGENTS.md`、`GEMINI.md`

{Claude Code specific instructions: memory hints, preferred tools, response style, etc.}
<!-- /CLAUDE_ONLY -->

<!-- CODEX_ONLY -->

## Documentation Maintenance (AI Agent — Required Reading)

> This file is auto-generated from `ALL_AGENTS.md`. **Do not edit it directly.**
>
> To update any project documentation (architecture, commands, conventions, etc.):
>
> 1. Edit `ALL_AGENTS.md` in the project root (the single source of truth)
> 2. Run `./sync-agents.sh` to sync changes to `CLAUDE.md`, `AGENTS.md`, `GEMINI.md`
> 3. Stage all changed files: `ALL_AGENTS.md`, `CLAUDE.md`, `AGENTS.md`, `GEMINI.md`

{Codex CLI specific instructions: sandbox environment, preferred patterns, etc.}
<!-- /CODEX_ONLY -->

<!-- GEMINI_ONLY -->

## Documentation Maintenance (AI Agent — Required Reading)

> This file is auto-generated from `ALL_AGENTS.md`. **Do not edit it directly.**
>
> To update any project documentation (architecture, commands, conventions, etc.):
>
> 1. Edit `ALL_AGENTS.md` in the project root (the single source of truth)
> 2. Run `./sync-agents.sh` to sync changes to `CLAUDE.md`, `AGENTS.md`, `GEMINI.md`
> 3. Stage all changed files: `ALL_AGENTS.md`, `CLAUDE.md`, `AGENTS.md`, `GEMINI.md`

{Gemini CLI specific instructions: model preferences, tool usage, etc.}
<!-- /GEMINI_ONLY -->
