#!/usr/bin/env bash
# Context:
# Admin helper (Oracle Linux / linux4).
# Stops the Oracle Net Listener.
#
# Usage:
#   ./stop_listener.sh            # stops default LISTENER
#   ./stop_listener.sh LISTENER   # stops a named listener
#
# Notes:
# - Requires OS privileges appropriate for managing the listener.
# - Assumes Oracle client/server tools are available (lsnrctl).

set -euo pipefail

LISTENER_NAME="${1:-LISTENER}"

if command -v lsnrctl >/dev/null 2>&1; then
  echo "Stopping listener: ${LISTENER_NAME}"
  lsnrctl stop "${LISTENER_NAME}"
  exit 0
fi

if [[ -n "${ORACLE_HOME:-}" ]] && [[ -x "${ORACLE_HOME}/bin/lsnrctl" ]]; then
  echo "Stopping listener: ${LISTENER_NAME} (via ORACLE_HOME=${ORACLE_HOME})"
  "${ORACLE_HOME}/bin/lsnrctl" stop "${LISTENER_NAME}"
  exit 0
fi

echo "ERROR: lsnrctl not found in PATH and ORACLE_HOME/bin/lsnrctl not available." >&2
echo "- Ensure ORACLE_HOME is set and ORACLE binaries are installed." >&2
echo "- Or run: export PATH=\"$PATH:$ORACLE_HOME/bin\"" >&2
exit 1
