#!/bin/bash

# ==========================================
# Task 1: Input and Validation
# ==========================================

# Check if a file path argument was provided
if [ -z "$1" ]; then
    echo "Error: No log file path provided."
    echo "Usage: $0 /path/to/logfile.log"
    exit 1
fi

LOG_FILE="$1"

# Check if the file actually exists
if [ ! -f "$LOG_FILE" ]; then
    echo "Error: File '$LOG_FILE' does not exist."
    exit 1
fi

# ==========================================
# Setup and Variables
# ==========================================
CURRENT_DATE=$(date +%Y-%m-%d)
REPORT_FILE="log_report_${CURRENT_DATE}.txt"
TOTAL_LINES=$(wc -l < "$LOG_FILE" | xargs)

# ==========================================
# Task 2: Error Count
# ==========================================
# Counts lines containing 'ERROR' or 'Failed' (case-sensitive as per requirements)
ERROR_COUNT=$(grep -E "ERROR|Failed" "$LOG_FILE" | wc -l | xargs)

echo "Total Errors/Failures found: $ERROR_COUNT"
echo "----------------------------------------"

# ==========================================
# Task 3: Critical Events
# ==========================================
echo "--- Critical Events ---"
# grep -n outputs "line_num:line_content", which we format using sed or awk
CRITICAL_EVENTS=$(grep -n "CRITICAL" "$LOG_FILE" | sed 's/:/ /' | awk '{printf "Line %s: ", $1; $1=""; print substr($0, 2)}')

if [ -z "$CRITICAL_EVENTS" ]; then
    echo "No critical events found."
else
    echo "$CRITICAL_EVENTS"
fi
echo "----------------------------------------"

# ==========================================
# Task 4: Top Error Messages
# ==========================================
echo "--- Top 5 Error Messages ---"

# This pipeline extracts lines with ERROR, aggressively trims common log timestamps/metadata 
# (adjust the awk/cut command if your specific log format leaves trailing spaces), 
# counts unique messages, sorts them, and grabs the top 5.
TOP_ERRORS=$(grep "ERROR" "$LOG_FILE" | awk '{ $1=$2=$3=""; print $0 }' | sed -e 's/^[ \t]*//' | sort | uniq -c | sort -rn | head -5)

if [ -z "$TOP_ERRORS" ]; then
    echo "No ERROR messages found."
else
    echo "$TOP_ERRORS"
fi
echo "----------------------------------------"

# ==========================================
# Task 5: Summary Report
# ==========================================
{
    echo "========================================"
    echo "LOG ANALYSIS SUMMARY REPORT"
    echo "========================================"
    echo "Date of Analysis:    $CURRENT_DATE"
    echo "Log File Name:       $(basename "$LOG_FILE")"
    echo "Total Lines Processed: $TOTAL_LINES"
    echo "Total Error Count:   $ERROR_COUNT"
    echo ""
    echo "--- Top 5 Error Messages ---"
    if [ -z "$TOP_ERRORS" ]; then
        echo "No ERROR messages found."
    else
        echo "$TOP_ERRORS"
    fi
    echo ""
    echo "--- Critical Events ---"
    if [ -z "$CRITICAL_EVENTS" ]; then
        echo "No critical events found."
    else
        echo "$CRITICAL_EVENTS"
    fi
} > "$REPORT_FILE"

echo "Summary report successfully generated: $REPORT_FILE"
