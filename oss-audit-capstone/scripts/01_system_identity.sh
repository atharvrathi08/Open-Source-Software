#!/bin/bash
# Script 1: System Identity Report
# Author: [Atharv Rathi]
# Course: Open Source Software

set -u

# --- Variables (override using environment variables if needed) ---
STUDENT_NAME="${STUDENT_NAME:-Atharv Rathi}"
SOFTWARE_CHOICE="${SOFTWARE_CHOICE:-git}"

# --- Helpers: detect Linux distribution name ---
get_distro() {
  if command -v lsb_release >/dev/null 2>&1; then
    lsb_release -d 2>/dev/null | cut -d':' -f2 | sed 's/^[ \t]*//'
    return 0
  fi

  if [ -r /etc/os-release ]; then
    # Prefer PRETTY_NAME, fall back to NAME
    local pretty
    pretty="$(grep -E '^PRETTY_NAME=' /etc/os-release 2>/dev/null | head -n 1 | cut -d'=' -f2- | tr -d '"')"
    if [ -n "$pretty" ]; then
      echo "$pretty"
      return 0
    fi
    grep -E '^NAME=' /etc/os-release 2>/dev/null | head -n 1 | cut -d'=' -f2- | tr -d '"'
    return 0
  fi

  echo "Unknown Linux distribution"
}

# --- System info ---
DISTRO="$(get_distro)"
KERNEL="$(uname -r)"
USER_NAME="$(whoami)"
HOME_DIR="$(eval echo "~$USER_NAME")"
UPTIME="$(uptime -p 2>/dev/null || echo "unknown")"
NOW="$(date '+%Y-%m-%d %H:%M:%S %Z')"

# --- Open-source license message (covers Linux kernel) ---
# Note: A Linux “OS” is a mix of many licenses (kernel, libraries, userland).
LICENSE_MSG="Linux kernel license: GPLv2 (userspace components may use other licenses)."

# --- Display ---
echo "================================"
echo " Open Source Audit — $STUDENT_NAME"
echo "================================"
echo "Distribution : $DISTRO"
echo "Kernel       : $KERNEL"
echo "User         : $USER_NAME"
echo "Home         : $HOME_DIR"
echo "Uptime       : $UPTIME"
echo "Date/Time    : $NOW"
echo "License      : $LICENSE_MSG"

if [ -n "$SOFTWARE_CHOICE" ] && [ "$SOFTWARE_CHOICE" != "YOUR_CHOSEN_SOFTWARE_HERE" ]; then
  echo "Chosen FOSS  : $SOFTWARE_CHOICE"
fi

