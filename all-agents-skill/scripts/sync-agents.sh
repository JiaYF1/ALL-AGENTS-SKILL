#!/usr/bin/env bash
# sync-agents.sh — Sync ALL_AGENTS.md → CLAUDE.md, AGENTS.md, GEMINI.md
# Usage: ./sync-agents.sh [path/to/ALL_AGENTS.md]
set -euo pipefail

SOURCE="${1:-ALL_AGENTS.md}"
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

if [ ! -f "$SOURCE" ]; then
    echo "Error: $SOURCE not found."
    echo "Run your AI tool's initialization first, or create ALL_AGENTS.md manually."
    exit 1
fi

# Generate a tool-specific file from ALL_AGENTS.md
# $1 = tag to INCLUDE (e.g. CLAUDE_ONLY), $2 = output file
generate_file() {
    local include_tag="$1"
    local output_file="$2"

    # All possible tags
    local all_tags=("CLAUDE_ONLY" "CODEX_ONLY" "GEMINI_ONLY")

    # Build exclude list
    local -a exclude_tags=()
    for tag in "${all_tags[@]}"; do
        [ "$tag" != "$include_tag" ] && exclude_tags+=("$tag")
    done

    # Write header
    cat > "$output_file" << HEADER
<!-- AUTO-GENERATED FROM ALL_AGENTS.md — DO NOT EDIT DIRECTLY -->
<!-- To modify: edit ALL_AGENTS.md then run ./sync-agents.sh -->
<!-- Last synced: ${TIMESTAMP} -->

HEADER

    local in_excluded_block=false
    local in_code_fence=false
    local skip_source_header=true

    while IFS= read -r line || [[ -n "$line" ]]; do
        # Skip ALL_AGENTS.md's own header comments (leading <!-- ... --> lines)
        if $skip_source_header; then
            if [[ "$line" =~ ^'<!--' ]] || [[ -z "$line" ]]; then
                continue
            else
                skip_source_header=false
            fi
        fi

        # Track code fences — don't process markers inside them
        if [[ "$line" =~ ^\`\`\` ]]; then
            if $in_code_fence; then
                in_code_fence=false
            else
                in_code_fence=true
            fi
            echo "$line" >> "$output_file"
            continue
        fi

        # Inside code fence: pass through everything
        if $in_code_fence; then
            echo "$line" >> "$output_file"
            continue
        fi

        # Check for start of an excluded block
        local matched_exclude=false
        for etag in "${exclude_tags[@]}"; do
            if [[ "$line" == "<!-- ${etag} -->" ]]; then
                in_excluded_block=true
                matched_exclude=true
                break
            fi
        done
        if $matched_exclude; then continue; fi

        # Check for end of an excluded block
        if $in_excluded_block; then
            for etag in "${exclude_tags[@]}"; do
                if [[ "$line" == "<!-- /${etag} -->" ]]; then
                    in_excluded_block=false
                    break
                fi
            done
            continue
        fi

        # Strip include_tag markers (keep content between them)
        if [[ "$line" == "<!-- ${include_tag} -->" ]] || [[ "$line" == "<!-- /${include_tag} -->" ]]; then
            continue
        fi

        echo "$line" >> "$output_file"
    done < "$SOURCE"

    echo "  ✓ $output_file"
}

echo "Syncing from $SOURCE ..."
generate_file "CLAUDE_ONLY" "CLAUDE.md"
generate_file "CODEX_ONLY" "AGENTS.md"
generate_file "GEMINI_ONLY" "GEMINI.md"
echo "Done! Synced at $TIMESTAMP"
