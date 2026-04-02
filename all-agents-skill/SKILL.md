---
name: all-agents-sync
description: >
  Initialize and sync unified AI agent project documentation across Claude Code
  (CLAUDE.md), OpenAI Codex CLI (AGENTS.md), and Google Gemini CLI (GEMINI.md)
  from a single ALL_AGENTS.md source of truth. Use this skill when the user says
  "初始化 all agents", "initialize all agents", "sync agent docs", "set up project
  docs for all AI tools", mentions ALL_AGENTS.md, or wants to manage project
  documentation across multiple AI coding assistants. Also trigger when user asks
  to create or update CLAUDE.md + AGENTS.md + GEMINI.md together, or mentions
  keeping AI tool configs in sync.

---

# All Agents Sync

Manage one project doc for all your AI CLI tools. Edit `ALL_AGENTS.md` once,
sync to `CLAUDE.md`, `AGENTS.md`, and `GEMINI.md` automatically.

## When This Skill Applies

- User says "初始化 all agents" / "initialize all agents" / "sync agent docs"
- User wants unified documentation for Claude Code + Codex CLI + Gemini CLI
- User mentions ALL_AGENTS.md or wants to sync AI tool configs
- User asks to create project docs for multiple AI tools at once

## Initialization Flow

When the user asks to initialize, follow these steps in order.

### Step 1: Check Existing Files

Check the project root for these files: `ALL_AGENTS.md`, `CLAUDE.md`, `AGENTS.md`, `GEMINI.md`, `sync-agents.sh`.

**If ALL_AGENTS.md exists**: Ask the user —

> "ALL_AGENTS.md already exists. Would you like me to (1) regenerate it from scratch, or (2) just sync it to the tool-specific files?"

If they choose sync-only, skip to Step 4.

**If CLAUDE.md/AGENTS.md/GEMINI.md exist but ALL_AGENTS.md does not**: Ask —

> "Found existing tool docs but no ALL_AGENTS.md. Should I use the existing content as a starting point, or analyze the project fresh?"

### Step 2: Analyze the Project

Scan the codebase to gather project information. Read these files (if they exist):

- **Package metadata**: `package.json`, `Cargo.toml`, `pyproject.toml`, `go.mod`, `pom.xml`, `build.gradle`
- **Config files**: `tsconfig.json`, `vite.config.*`, `webpack.config.*`, `next.config.*`, `.eslintrc*`, `.prettierrc*`
- **README.md**: For project description and existing documentation
- **Directory structure**: Run `ls` on the project root and key subdirectories (2-3 levels deep)
- **Git info**: Recent commits for project context

Focus on extracting:

1. Project name and description
2. Language and framework
3. Build/dev/test commands
4. Directory layout and purpose of each top-level directory
5. Architecture patterns (component structure, state management, API layer)
6. Key configuration files and their purpose
7. Code conventions (formatting, naming, imports)

### Step 3: Generate ALL_AGENTS.md

Read the template at `{baseDir}/references/all-agents-template.md` for the structure.
Fill in each section based on what you learned in Step 2. Write the result to
`ALL_AGENTS.md` in the project root.

Guidelines for generating good documentation:

- Match the language of the project's existing docs (Chinese if README is in Chinese, etc.)
- Be specific — include actual paths, real command names, concrete patterns
- Keep it concise — this goes into the context window of three AI tools, so every line should earn its place
- **Always include the tool-specific maintenance instruction blocks** (see template). These are MANDATORY — they tell each AI tool "this file is auto-generated, edit ALL_AGENTS.md instead". Without them, the AI will edit the wrong file.

Tool-specific section markers:

```markdown
<!-- CLAUDE_ONLY -->
Content only for CLAUDE.md (Claude Code)
<!-- /CLAUDE_ONLY -->

<!-- CODEX_ONLY -->
Content only for AGENTS.md (Codex CLI)
<!-- /CODEX_ONLY -->

<!-- GEMINI_ONLY -->
Content only for GEMINI.md (Gemini CLI)
<!-- /GEMINI_ONLY -->
```

These markers control which content goes to which file during sync:

- Content outside any marker → goes to all three files
- `CLAUDE_ONLY` blocks → only to CLAUDE.md
- `CODEX_ONLY` blocks → only to AGENTS.md
- `GEMINI_ONLY` blocks → only to GEMINI.md
- Markers inside code fences (```) are ignored by the sync script
- Markers cannot be nested

**Required blocks every ALL_AGENTS.md must contain** (copy from template):

- `CLAUDE_ONLY` block: "本文件由 ALL_AGENTS.md 自动生成，请勿直接编辑" + how to update
- `CODEX_ONLY` block: same in English
- `GEMINI_ONLY` block: same in English

These ensure each AI tool knows to edit `ALL_AGENTS.md` (not `CLAUDE.md`/`AGENTS.md`/`GEMINI.md`) and to run `./sync-agents.sh` afterward.

### Step 4: Copy Sync Script & Run Sync

Copy the sync script to the project root and make it executable:

```bash
cp {baseDir}/scripts/sync-agents.sh ./sync-agents.sh
chmod +x ./sync-agents.sh
```

Run the sync:

```bash
./sync-agents.sh
```

This reads ALL_AGENTS.md and generates three files, each with an auto-generated header
and the appropriate content filtered by tool-specific markers.

### Step 5: Git Hook (Ask User First)

Ask the user:

> "Would you like to set up a git pre-commit hook so that changes to ALL_AGENTS.md
> are automatically synced on commit? (You can always sync manually with `./sync-agents.sh`)"

If yes, detect the hook framework and install accordingly:

**Check for husky** (`.husky/` directory):
Add to `.husky/pre-commit`:

```bash
# all-agents-sync: auto-sync on commit
if [ -f "ALL_AGENTS.md" ] && [ -f "sync-agents.sh" ]; then
    if git diff --cached --name-only | grep -q "^ALL_AGENTS.md$"; then
        ./sync-agents.sh
        git add CLAUDE.md AGENTS.md GEMINI.md
    fi
fi
```

**Check for lefthook** (`.lefthook.yml`):
Add a pre-commit command for sync-agents.

**Standalone hook** (no framework detected):
Check if `.git/hooks/pre-commit` exists:

- If yes: append the sync logic to the existing file
- If no: create `.git/hooks/pre-commit` with:

```bash
#!/usr/bin/env bash
# all-agents-sync: auto-sync ALL_AGENTS.md on commit
if [ -f "ALL_AGENTS.md" ] && [ -f "sync-agents.sh" ]; then
    if git diff --cached --name-only | grep -q "^ALL_AGENTS.md$"; then
        echo "[all-agents-sync] Syncing ALL_AGENTS.md..."
        ./sync-agents.sh
        git add CLAUDE.md AGENTS.md GEMINI.md
    fi
fi
```

Make it executable: `chmod +x .git/hooks/pre-commit`

### Step 6: Summary

Tell the user what was created and how to use it:

> **Setup complete!** Here's what was created:
>
> - `ALL_AGENTS.md` — Your single source of truth (edit this file)
> - `CLAUDE.md` — Auto-synced for Claude Code
> - `AGENTS.md` — Auto-synced for Codex CLI
> - `GEMINI.md` — Auto-synced for Gemini CLI
> - `sync-agents.sh` — Run manually to sync
>   {- Git pre-commit hook installed (if applicable)}
>
> **Daily workflow**: Edit only `ALL_AGENTS.md`. Sync happens on commit (or run `./sync-agents.sh`).

## Sync-Only Flow

When the user asks to sync and ALL_AGENTS.md already exists:

1. Run `./sync-agents.sh` (or if it doesn't exist yet, copy it from `{baseDir}/scripts/sync-agents.sh` first)
2. Report which files were updated

## Edge Cases

- **Empty/minimal project**: Generate a minimal ALL_AGENTS.md with just the project name, detected files, and directory listing
- **Monorepo**: Ask whether to create docs at root level, per-package, or both
- **Non-git repo**: Skip the hook setup entirely, still create all files and the sync script
- **sync-agents.sh already exists**: Ask whether to overwrite or keep the existing one
- **.gitignore**: If any of the four files (ALL_AGENTS.md, CLAUDE.md, AGENTS.md, GEMINI.md) are gitignored, warn the user — these should be committed so all team members benefit

## Cross-Tool Installation

This skill works in Claude Code, Codex CLI, and Gemini CLI. To install in all tools:

```bash
{baseDir}/scripts/install.sh
```

Or install to a specific tool:

```bash
{baseDir}/scripts/install.sh claude
{baseDir}/scripts/install.sh codex
{baseDir}/scripts/install.sh gemini
```
