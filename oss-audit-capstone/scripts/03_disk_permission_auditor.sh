#!/bin/bash
# Script 3: Disk and Permission Auditor
#
# It loops over a list of important directories and reports:
# - directory permissions (and owner/group)
# - human-readable size
# - whether it exists
#
# It also checks (when possible) the permissions of your chosen software's config directory.

set -u

# You can override these using environment variables.
SOFTWARE_CHOICE="${SOFTWARE_CHOICE:-git}"

# Optional argument:
#   ./03_disk_permission_auditor.sh [config_dir]
CONFIG_DIR="${1:-}"

DIRS=("/etc" "/var/log" "/home" "/usr/bin" "/tmp")

get_first_existing_dir() {
  local candidate
  for candidate in "$@"; do
    if [ -n "$candidate" ] && [ -e "$candidate" ]; then
      echo "$candidate"
      return 0
    fi
  done
  return 1
}

if [ -z "$CONFIG_DIR" ] && [ -n "$SOFTWARE_CHOICE" ] && [ "$SOFTWARE_CHOICE" != "YOUR_CHOSEN_SOFTWARE_HERE" ]; then
  # Common config locations (varies by software; update if needed).
  CONFIG_DIR="$(
    get_first_existing_dir \
      "/etc/$SOFTWARE_CHOICE" \
      "$HOME/.config/$SOFTWARE_CHOICE" \
      "$HOME/.config/${SOFTWARE_CHOICE,,}" 2>/dev/null || true
  )"
fi

echo "Directory Audit Report"
echo "----------------------"

for DIR in "${DIRS[@]}"; do
  if [ -d "$DIR" ]; then
    # Extract: permissions + owner + group
    PERMS="$(ls -ld "$DIR" | awk '{print $1, $3, $4}')"
    # Extract size (e.g., "4.0G")
    SIZE="$(du -sh "$DIR" 2>/dev/null | awk '{print $1}')"
    echo "$DIR => Permissions: $PERMS | Size: $SIZE"
  else
    echo "$DIR does not exist on this system"
  fi
done

echo
echo "Software Config Directory Check"
echo "-------------------------------"

if [ -z "$CONFIG_DIR" ]; then
  echo "Config directory not provided. Run: $0 <config_dir> (or set SOFTWARE_CHOICE)."
  exit 0
fi

if [ -e "$CONFIG_DIR" ]; then
  PERMS="$(ls -ld "$CONFIG_DIR" | awk '{print $1, $3, $4}')"
  SIZE="$(du -sh "$CONFIG_DIR" 2>/dev/null | awk '{print $1}')"
  echo "Config Dir: $CONFIG_DIR"
  echo "Permissions: $PERMS | Size: $SIZE"
else
  echo "Config directory does not exist: $CONFIG_DIR"
fi

