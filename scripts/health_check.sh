#!/usr/bin/env bash
# Prints PASS or FAIL per check. Exits 1 if any check fails.
URL="${1:-http://localhost}"
FAILED=0
check() {
  local name="$1" expected="$2" actual="$3"
  if [ "$expected" = "$actual" ]; then
    echo "PASS  $name"
  else
    echo "FAIL  $name (expected: $expected, got: $actual)"
FAILED=1 fi 
} 
check "HTTP status is 200" "200" \
  "$(curl -s -o /dev/null -w '%{http_code}' "$URL")"
check "Page title is correct" "1" \
  "$(curl -s "$URL" | grep -c '<title>QA Report Hub</title>')"
check "nginx service is active" "active" "$(systemctl is-active nginx)"
check "Root disk is below 80%" "yes" \
  "$([ "$(df --output=pcent / | tail -1 | tr -dc '0-9')" -lt 80 ] && echo yes || echo no)"
exit "$FAILED"
