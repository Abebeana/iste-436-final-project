#!/usr/bin/env bash
# Use the system's default Bash interpreter (portable across environments)

# Context:
# Admin helper (Oracle Linux / linux4).
# Starts the Oracle Net Listener.

# Usage:
#   ./start_listener.sh            # starts default LISTENER
#   ./start_listener.sh LISTENER   # starts a named listener

# Notes:
# - Requires OS privileges appropriate for managing the listener.
# - Assumes Oracle client/server tools are available (lsnrctl).

set -euo pipefail
# -e  → Exit immediately if any command fails
# -u  → Treat unset variables as an error
# -o pipefail → Fail if any command in a pipeline fails

LISTENER_NAME="${1:-LISTENER}"
# Take first command-line argument as listener name
# If not provided, default to "LISTENER"

if command -v lsnrctl >/dev/null 2>&1; then
# Check if 'lsnrctl' exists in the system PATH
# Redirect output to /dev/null to keep it silent

  echo "Starting listener: ${LISTENER_NAME}"
  # Print message indicating which listener is being started

  lsnrctl start "${LISTENER_NAME}"
  # Run Oracle command to start the listener

  exit 0
  # Exit successfully if this method worked
fi

if [[ -n "${ORACLE_HOME:-}" ]] && [[ -x "${ORACLE_HOME}/bin/lsnrctl" ]]; then
# Check:
# 1. ORACLE_HOME variable is set and not empty
# 2. lsnrctl exists and is executable inside ORACLE_HOME/bin

  echo "Starting listener: ${LISTENER_NAME} (via ORACLE_HOME=${ORACLE_HOME})"
  # Inform user that fallback method is being used

  "${ORACLE_HOME}/bin/lsnrctl" start "${LISTENER_NAME}"
  # Start listener using full path to lsnrctl

  exit 0
  # Exit successfully if this method worked
fi

echo "ERROR: lsnrctl not found in PATH and ORACLE_HOME/bin/lsnrctl not available." >&2
# Print error message to stderr (>&2)

echo "- Ensure ORACLE_HOME is set and ORACLE binaries are installed." >&2
# Suggest checking ORACLE_HOME and installation

echo "- Or run: export PATH=\"$PATH:$ORACLE_HOME/bin\"" >&2
# Suggest adding ORACLE_HOME/bin to PATH

exit 1
# Exit with error code (non-zero = failure)