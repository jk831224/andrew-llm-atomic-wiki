#!/bin/bash
# Append an entry to wiki/log.md
# Usage: ./log-append.sh "描述這次變更的內容"
# Example: ./log-append.sh "新增 harness-engineering-security.md，更新 index.md"

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
LOG="$REPO_ROOT/log.md"
DATE=$(date '+%Y-%m-%d')
MESSAGE="${1:-（未提供變更描述）}"

# Create log file if it doesn't exist
if [ ! -f "$LOG" ]; then
  echo "# Wiki Change Log" > "$LOG"
  echo "" >> "$LOG"
fi

# Append entry (prepend after the header so newest is on top)
# Cross-platform (BSD/GNU sed): rewrite file via tmp instead of sed -i
TMP="$LOG.tmp"
{
  echo "# Wiki Change Log"
  echo ""
  echo "## $DATE"
  echo ""
  echo "- $MESSAGE"
  echo ""
  # Append existing entries below new entry (skip the original header on first 2 lines)
  tail -n +3 "$LOG" 2>/dev/null
} > "$TMP" && mv "$TMP" "$LOG"

echo "Log appended: $DATE — $MESSAGE"
