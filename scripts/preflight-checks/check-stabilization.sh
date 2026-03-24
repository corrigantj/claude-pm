#!/usr/bin/env bash
# check-stabilization.sh — Verify stabilization tickets exist for open milestones
set -euo pipefail

: "${OWNER:?OWNER env var required}"
: "${REPO:?REPO env var required}"

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

# Fetch open milestones
milestones=$(gh api "repos/${OWNER}/${REPO}/milestones?state=open" \
  --jq '.[] | "\(.number)\t\(.title)"' 2>/dev/null || echo "")

if [ -z "$milestones" ]; then
  emit "stabilization.no_milestones" "pass" "No open milestones — nothing to check"
  exit 0
fi

while IFS=$'\t' read -r ms_number ms_title; do
  [ -z "$ms_number" ] && continue

  ticket_title="Stabilization: ${ms_title}"
  existing=$(gh issue list --repo "${OWNER}/${REPO}" --milestone "${ms_title}" \
    --search "\"${ticket_title}\" in:title" --json number,title --jq \
    ".[] | select(.title == \"${ticket_title}\") | .number" 2>/dev/null | head -1 || echo "")

  if [ -n "$existing" ]; then
    emit "stabilization.${ms_title}" "pass" \
      "Stabilization ticket #${existing} exists for milestone ${ms_title}"
  else
    emit "stabilization.${ms_title}" "warn" \
      "No stabilization ticket found for milestone ${ms_title}" \
      "Run: bash scripts/create-stabilization-ticket.sh --owner ${OWNER} --repo ${REPO} --milestone-title '${ms_title}' --milestone-number ${ms_number}"
  fi
done <<< "$milestones"
