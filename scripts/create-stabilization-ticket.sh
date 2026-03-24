#!/usr/bin/env bash
# create-stabilization-ticket.sh — Create a stabilization ticket for a milestone
# Usage: create-stabilization-ticket.sh --owner OWNER --repo REPO --milestone-title TITLE --milestone-number NUMBER [--wiki-meta-url URL]
# Idempotent: exits 0 with existing issue number if ticket already exists.

set -euo pipefail

OWNER=""
REPO=""
MILESTONE_TITLE=""
MILESTONE_NUMBER=""
WIKI_META_URL=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --owner) OWNER="$2"; shift 2 ;;
    --repo) REPO="$2"; shift 2 ;;
    --milestone-title) MILESTONE_TITLE="$2"; shift 2 ;;
    --milestone-number) MILESTONE_NUMBER="$2"; shift 2 ;;
    --wiki-meta-url) WIKI_META_URL="$2"; shift 2 ;;
    *) echo "Unknown arg: $1" >&2; exit 2 ;;
  esac
done

: "${OWNER:?--owner required}"
: "${REPO:?--repo required}"
: "${MILESTONE_TITLE:?--milestone-title required}"
: "${MILESTONE_NUMBER:?--milestone-number required}"

TICKET_TITLE="Stabilization: ${MILESTONE_TITLE}"

# Idempotent: check if one already exists
existing=$(gh issue list --repo "${OWNER}/${REPO}" --milestone "${MILESTONE_TITLE}" \
  --search "\"${TICKET_TITLE}\" in:title" --json number,title --jq \
  ".[] | select(.title == \"${TICKET_TITLE}\") | .number" 2>/dev/null | head -1 || echo "")

if [ -n "$existing" ]; then
  echo "${existing}"
  exit 0
fi

# Build body
body="## Stabilization Ticket

This is the parent ticket for all stabilization work in milestone **${MILESTONE_TITLE}**.

Issues discovered during testing, review, or post-integration use are filed as sub-issues of this ticket.

**Exit criteria:** All child issues must be closed before the milestone can be closed."

if [ -n "$WIKI_META_URL" ]; then
  body="${body}

**Feature wiki:** ${WIKI_META_URL}"
fi

# Create the issue
issue_number=$(gh issue create --repo "${OWNER}/${REPO}" \
  --title "${TICKET_TITLE}" \
  --body "${body}" \
  --milestone "${MILESTONE_TITLE}" \
  --label "type:task" --label "meta:ignore" \
  --json number --jq '.number' 2>/dev/null)

echo "${issue_number}"
