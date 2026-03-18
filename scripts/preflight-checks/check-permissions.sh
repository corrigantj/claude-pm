#!/usr/bin/env bash
set -euo pipefail

SETTINGS_PATH=".claude/settings.json"

emit() {
  local check="$1" status="$2" message="$3" fix="${4:-}"
  if [ -n "$fix" ]; then
    jq -nc --arg c "$check" --arg s "$status" --arg m "$message" --arg f "$fix" \
      '{check:$c, status:$s, message:$m, fix:$f}'
  else
    jq -nc --arg c "$check" --arg s "$status" --arg m "$message" \
      '{check:$c, status:$s, message:$m}'
  fi
}

# permissions.settings_exists
if [ ! -f "$SETTINGS_PATH" ]; then
  emit "permissions.settings_exists" "fail" "No ${SETTINGS_PATH} found — subagents will not have Bash permissions" \
    "Run limbic:setup to configure subagent permissions"
  exit 0
fi
emit "permissions.settings_exists" "pass" "Settings file found: ${SETTINGS_PATH}"

# permissions.bash_git — check for Bash(git:*) or Bash(git *) in permissions.allow
if ! command -v jq &>/dev/null; then
  emit "permissions.bash_access" "warn" "jq not available — cannot verify Bash permissions"
  exit 0
fi

allow_list=$(jq -r '.permissions.allow[]? // empty' "$SETTINGS_PATH" 2>/dev/null || echo "")

if [ -z "$allow_list" ]; then
  emit "permissions.bash_access" "fail" "No permissions.allow entries in ${SETTINGS_PATH} — subagents cannot run shell commands" \
    "Run limbic:setup to configure subagent permissions"
  exit 0
fi

# Check for minimum required: git and gh
missing=""
for required in "git" "gh"; do
  if ! echo "$allow_list" | grep -qE "Bash\(${required}[: ]"; then
    missing="${missing}${required}, "
  fi
done

if [ -z "$missing" ]; then
  emit "permissions.bash_access" "pass" "Bash permissions configured for subagents (git, gh found)"
else
  missing="${missing%, }"
  emit "permissions.bash_access" "fail" "Missing Bash permissions for subagents: ${missing}" \
    "Run limbic:setup to configure subagent permissions — agents need at minimum Bash(git:*) and Bash(gh:*)"
fi
