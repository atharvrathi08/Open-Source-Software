#!/bin/bash
# Script 4: Log File Analyzer
#
# Reads a log file line-by-line, counts how many lines contain a keyword,
# prints a summary, and (if the file is empty) retries a few times.
#
# Usage:
#   ./04_log_file_analyzer.sh <log_file> [keyword]
#
# Concepts used: while-read loop, if-then, counter variables, command-line args ($1 / $2).

set -u

LOGFILE="${1:-}"
KEYWORD="${2:-error}" # Default keyword is 'error'

if [ -z "$LOGFILE" ]; then
  echo "Usage: $0 <log_file> [keyword]"
  exit 1
fi

if [ ! -f "$LOGFILE" ]; then
  echo "Error: File $LOGFILE not found."
  exit 1
fi

max_tries=3
sleep_seconds=1
tries=0

COUNT=0

while [ "$tries" -lt "$max_tries" ]; do
  tries=$((tries + 1))
  COUNT=0

  # Retry only if file seems empty.
  if [ ! -s "$LOGFILE" ]; then
    # “do-while style” retry: keep trying until file gets content or tries run out.
    if [ "$tries" -lt "$max_tries" ]; then
      sleep "$sleep_seconds"
      continue
    fi
  fi

  while IFS= read -r LINE; do
    if echo "$LINE" | grep -iq "$KEYWORD"; then
      COUNT=$((COUNT + 1))
    fi
  done < "$LOGFILE"

  break
done

echo "Keyword '$KEYWORD' found $COUNT times in $LOGFILE"

echo
echo "Last 5 matching lines (if any):"
# Print recent matches using tail + grep (as required by the PDF TODO).
tail -n 500 "$LOGFILE" 2>/dev/null | grep -i "$KEYWORD" | tail -n 5 || true

