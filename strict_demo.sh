#!/bin/bash
# Enable Bash Strict Mode
set -euo pipefail

echo "--- Testing set -u (Undefined Variables) ---"
# Uncomment the line below to test. The script will crash instantly.
# echo "My secret token is: $UNDEFINED_VAR"

echo "--- Testing set -e (Command Failures) ---"
# This invalid command will fail. Because of -e, the script stops immediately.(uncomment below line to test)
# invalid_command_here

echo "This line will NEVER execute because the command above failed."

echo "--- Testing set -o pipefail (Piped Failures) ---"
# If the previous lines didn't stop the script, this pipeline would.
# 'fake_command' fails, but 'wc -l' succeeds. pipefail catches the 'fake_command' failure.
fake_command | wc -l
