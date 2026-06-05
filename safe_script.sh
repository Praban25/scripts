#!/bin/bash
# Exit immediately if a command exits with a non-zero status
set -e

echo "Starting safe operations..."

# Wrap the operations in a block so we can catch any failure with the || operator
{
    # 1. Try to create the directory
    mkdir -p /tmp/devops-test
    
    # 2. Try to navigate into it
    cd /tmp/devops-test
    
    # 3. Create a file inside
    touch test_file.txt
    
    echo "Success: Directory created and file written safely!"

} || {
    # This block executes if ANY of the steps inside the bracket above fail
    echo "Error: An operation failed! Script terminating safely."
    exit 1
}
