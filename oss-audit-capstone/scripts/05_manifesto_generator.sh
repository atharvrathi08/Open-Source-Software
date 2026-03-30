#!/bin/bash
# Script 5: The Open Source Manifesto Generator
#
# Interactive script that asks the user three questions, then composes
# a short manifesto paragraph and saves it to a .txt file.
#
# Concepts used: read for user input, string concatenation, writing to a file,
# date command, and an “alias concept” note in a comment.

set -u

echo "Answer three questions to generate your manifesto."
echo

read -r -p "1. Name one open-source tool you use every day: " TOOL
read -r -p "2. In one word, what does 'freedom' mean to you? " FREEDOM
read -r -p "3. Name one thing you would build and share freely: " BUILD

DATE="$(date '+%d %B %Y')"
OUTPUT="manifesto_$(whoami).txt"

# Aliases concept (demonstration via comment):
# You could define aliases like:
#   alias ll='ls -alF'
# in your shell config to speed up repeated commands.

{
  echo "Open Source Manifesto"
  echo "Generated on: $DATE"
  echo
  echo "I use $TOOL, and to me, freedom means $FREEDOM. "
  echo "I would build $BUILD and share it freely because open collaboration "
  echo "turns personal effort into community progress."
} > "$OUTPUT"

echo
echo "Manifesto saved to $OUTPUT"
echo
cat "$OUTPUT"

