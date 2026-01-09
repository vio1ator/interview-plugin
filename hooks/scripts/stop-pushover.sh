#!/bin/bash
# Pushover Stop Hook for Claude Code

set -euo pipefail

# Read hook input from stdin (required for stop hooks)
HOOK_INPUT=$(cat)

# Extract project name from current working directory
PROJECT_NAME=$(basename "$PWD")

# Pushover credentials from environment
PUSHOVER_USER_KEY="${PUSHOVER_USER_KEY:-}"
PUSHOVER_API_KEY="${PUSHOVER_API_KEY:-}"

# Silently skip if credentials not configured (don't block)
if [[ -z "$PUSHOVER_USER_KEY" ]] || [[ -z "$PUSHOVER_API_KEY" ]]; then
    exit 0
fi

# Send notification via Pushover API
# Timeouts prevent blocking, errors suppressed to ensure non-blocking
curl -s -X POST \
    --connect-timeout 5 \
    --max-time 10 \
    --data "user=${PUSHOVER_USER_KEY}" \
    --data "token=${PUSHOVER_API_KEY}" \
    --data "title=Claude Code finished" \
    --data "message=Project: ${PROJECT_NAME}" \
    --data "priority=0" \
    "https://api.pushover.net/1/messages.json" \
    > /dev/null 2>&1 || true

# Always exit 0 to ensure non-blocking behavior
exit 0
