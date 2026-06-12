#!/bin/bash

# Configuration
LOG_DIR="/path/to/logs"
BACKUP_PATH="/path/to/logs" # Adjust if your backup directory is different
MAINTENANCE_LOG="/var/log/maintenance.log"

# Function to log messages with timestamps
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$MAINTENANCE_LOG"
}

# 1. Log Rotation Function
rotate_logs() {
    log_message "Starting log rotation..."
    
    # Compress logs older than 7 days
    COMPRESSED_COUNT=$(find "$LOG_DIR" -name "*.log" -type f -mtime +7 -print | wc -l)
    find "$LOG_DIR" -name "*.log" -type f -mtime +7 -exec gzip {} +
    log_message "Files compressed: $COMPRESSED_COUNT"

    # Delete compressed logs older than 30 days
    DELETED_COUNT=$(find "$LOG_DIR" -name "*.gz" -type f -mtime +30 -print -delete | wc -l)
    log_message "Files deleted: $DELETED_COUNT"
    
    log_message "Log rotation completed."
}

# 2. Backup/Size Status Function
check_backup_status() {
    log_message "Checking storage status..."
    
    # Calculate current size
    ARCHIVE_SIZE=$(du -sh "$BACKUP_PATH" | awk '{print $1}')
    log_message "Current disk usage for $BACKUP_PATH: $ARCHIVE_SIZE"
    
    log_message "Backup status check completed."
}

# --- Main Execution ---
# Ensure the script runs as root/sudo if writing to /var/log/
if [ ! -w "$(dirname "$MAINTENANCE_LOG")" ]; then
    echo "Error: Cannot write to $MAINTENANCE_LOG. Please run with sudo." >&2
    exit 1
fi

log_message "=== MAINTENANCE TASK STARTED ==="
rotate_logs
check_backup_status
log_message "=== MAINTENANCE TASK FINISHED ==="
echo "" >> "$MAINTENANCE_LOG" # Adds a blank line between runs
