#!/bin/bash
# Script 2: FOSS Package Inspector
#
# Usage:
#   ./02_foss_package_inspector.sh <package_name>
#
# Concepts used: if/then, case statement, rpm -qi / dpkg -s, grep pipelines.

set -u

PACKAGE="${1:-}" # e.g. httpd, mysql, vlc, firefox

SOFTWARE_CHOICE="${SOFTWARE_CHOICE:-git}"

if [ -z "$PACKAGE" ]; then
  echo "Error: missing package name."
  echo "Usage: $0 <package_name>"
  exit 1
fi

if command -v rpm >/dev/null 2>&1; then
  if rpm -q "$PACKAGE" >/dev/null 2>&1; then
    echo "$PACKAGE is installed (RPM)."
    rpm -qi "$PACKAGE" | grep -E 'Version|License|Summary'
    HAVE_RPM=1
  else
    echo "$PACKAGE is NOT installed (RPM)."
    HAVE_RPM=0
  fi
elif command -v dpkg >/dev/null 2>&1; then
  if dpkg -s "$PACKAGE" >/dev/null 2>&1; then
    echo "$PACKAGE is installed (DPKG)."
    dpkg -s "$PACKAGE" | grep -E '^Version:|^License:|^Homepage:|^Description:'
    HAVE_DPKG=1
  else
    echo "$PACKAGE is NOT installed (DPKG)."
    HAVE_DPKG=0
  fi
else
  echo "Neither 'rpm' nor 'dpkg' found on this system."
  echo "This script supports RPM-based and Debian-based distros."
  exit 2
fi

# Philosophy note: adjust strings as needed for your software.
case "$PACKAGE" in
  httpd|apache2)
    echo "Apache: the web server that helped shape the open internet."
    ;;
  mysql)
    echo "MySQL: open source at the heart of countless applications."
    ;;
  vlc)
    echo "VLC: multimedia freedom, built by a community and shared openly."
    ;;
  firefox)
    echo "Firefox: an open web browser supported by community governance."
    ;;
  git)
    echo "Git: the version control tool that made sharing collaboration practical."
    ;;
  "$SOFTWARE_CHOICE")
    echo "Your chosen software: add your one-line philosophy note here."
    ;;
  *)
    echo "No philosophy note configured for '$PACKAGE'."
    ;;
esac

