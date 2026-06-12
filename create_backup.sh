#!/bin/bash

# Ensure both source and destination arguments are provided
if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Error: Missing arguments." >&2
    echo "Usage: $0 <source_directory> <backup_destination>" >&2
    exit 1
fi

SRC_DIR="$1"
DEST_DIR="$2"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_FILENAME="backup-$TIMESTAMP.tar.gz"
BACKUP_PATH="$DEST_DIR/$BACKUP_FILENAME"

# 1. Error Handling: Verify source directory exists
if [ ! -d "$SRC_DIR" ]; then
    echo "Error: Source directory '$SRC_DIR' does not exist." >&2
    exit 1
fi

# 2. Check/Create destination directory
if [ ! -d "$DEST_DIR" ]; then
    echo "Destination '$DEST_DIR' does not exist. Creating it now..."
    mkdir -p "$DEST_DIR" || { echo "Error: Failed to create destination directory." >&2; exit 1; }
fi

echo "Starting server backup..."
echo "Source:      $SRC_DIR"
echo "Destination: $DEST_DIR"
echo "###################################################"

# 3. Create the timestamped .tar.gz archive
tar -czf "$BACKUP_PATH" -C "$SRC_DIR" .


# 4. Archive Size
ARCHIVE_SIZE=$(du -sh "$LOG_DIR" | awk '{print $1}')

if [ $? -eq 0 ] && [ -f "$BACKUP_PATH" ]; then
	echo "Backup created successfully!"
	echo "Archive Name: $BACKUP_FILENAME"
	echo "Archive Size: $ARCHIVE_SIZE"
else
	echo "Error: Backup archive creation failed." >&2
    	exit 1
fi


# 5. Delete backups older than 14 days from destination
DELETED_COUNT=$(find "$DEST_DIR" -name "backup-*.tar.gz" -type f -mtime +14 -print | wc -l)
find "$DEST_DIR" -name "backup-*.tar.gz" -type f -mtime +14 -delete

if [ "$DELETED_COUNT" -eq 0 ]; then
    echo "No old backups found to delete."
else
    echo "Purged $DELETED_COUNT old backup file(s)."
fi


echo "###########################################################"
echo "               Backup process complete.                    "
echo "###########################################################"
exit 0


