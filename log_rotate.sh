#!/bin/bash

#Ensuring the argument is provided
if [ -z ""$1 ]; then
	echo "Missing log directory argument" >&2
	echo "Usage: $0 <path_of_directory> " >&2
	exit 1
fi

LOG_DIR="$1"

#check if directory exist & valid
if [ ! -d "$LOG_DIR" ]; then
	echo "Error: Directory '$LOG_DIR' not exist" >&2
	exit 1
fi

echo "Starting Log Rotation"
echo ""

#Compress .log files older than 7 days
COMPRESSED_COUNT=$(find "$LOG_DIR" -name "*.log.*" -type f -mtime +7 -print | wc -l)
find "$LOG_DIR" -name "*.log.*" -type f -mtime +7 -exec gzip {} \;

#Delete .gz files older than 30 days
DELETED_COUNT=$(find "$LOG_DIR" -name "*.gz" -type f -mtime +30 -print | wc -l)
find "$LOG_DIR" -name "*.gz" -type f -mtime +30 -delete


# 3. Print the results
echo "Log cleanup complete:"
echo ""
echo "  - Files compressed: $COMPRESSED_COUNT"
echo "  - Files deleted:    $DELETED_COUNT"

