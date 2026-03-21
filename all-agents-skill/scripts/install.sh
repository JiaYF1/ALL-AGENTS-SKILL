#!/usr/bin/env bash
# install.sh — Install all-agents-sync skill to Claude Code, Codex CLI, and/or Gemini CLI
# Usage: ./install.sh [claude|codex|gemini]   (no args = install to all detected tools)
set -euo pipefail

SKILL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SKILL_NAME="all-agents-sync"

installed=0

install_claude() {
    local target="$HOME/.claude/skills/$SKILL_NAME"
    if [ -d "$HOME/.claude" ]; then
        mkdir -p "$HOME/.claude/skills"
        if [ -L "$target" ] || [ -d "$target" ]; then
            rm -rf "$target"
        fi
        ln -s "$SKILL_DIR" "$target"
        echo "  ✓ Claude Code: $target → $SKILL_DIR"
        installed=$((installed + 1))
    else
        echo "  ✗ Claude Code: ~/.claude not found, skipping"
    fi
}

install_codex() {
    local target="$HOME/.codex/skills/$SKILL_NAME"
    if [ -d "$HOME/.codex" ]; then
        mkdir -p "$HOME/.codex/skills"
        if [ -L "$target" ] || [ -d "$target" ]; then
            rm -rf "$target"
        fi
        ln -s "$SKILL_DIR" "$target"
        echo "  ✓ Codex CLI:   $target → $SKILL_DIR"
        installed=$((installed + 1))
    else
        echo "  ✗ Codex CLI: ~/.codex not found, skipping"
    fi
}

install_gemini() {
    if command -v gemini &>/dev/null; then
        gemini skills install "$SKILL_DIR" --scope user --consent 2>/dev/null \
            && echo "  ✓ Gemini CLI:  installed via 'gemini skills install'" \
            && installed=$((installed + 1)) \
            || echo "  ✗ Gemini CLI:  'gemini skills install' failed, try manually: gemini skills install $SKILL_DIR"
    else
        echo "  ✗ Gemini CLI: command not found, skipping"
    fi
}

echo "Installing $SKILL_NAME skill..."
echo ""

if [ $# -eq 0 ]; then
    install_claude
    install_codex
    install_gemini
else
    for tool in "$@"; do
        case "$tool" in
            claude) install_claude ;;
            codex)  install_codex ;;
            gemini) install_gemini ;;
            *)      echo "Unknown tool: $tool (use: claude, codex, gemini)" ;;
        esac
    done
fi

echo ""
if [ $installed -gt 0 ]; then
    echo "Done! Installed to $installed tool(s)."
    echo "Usage: In any installed tool, say '初始化 all agents' or 'initialize all agents'."
else
    echo "No tools detected. Make sure Claude Code, Codex CLI, or Gemini CLI is installed."
fi
