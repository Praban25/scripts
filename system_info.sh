#!/bin/bash

# Enable Bash Strict Mode
set -euo pipefail

# --- Function Definitions ---

print_os_info() {
    echo "=== Hostname & OS Information ==="
    echo "Hostname:    $(hostname)"
    # Extracts the pretty name from os-release if available
    if [ -f /etc/os-release ]; then
        echo "OS Name:     $(grep -w "PRETTY_NAME" /etc/os-release | cut -d= -f2 | tr -d '"')"
    else
        echo "OS Name:     $(uname -srm)"
    fi
    echo "Kernel:      $(uname -r)"
}

print_uptime() {
    echo "=== System Uptime ==="
    uptime -p
}

print_disk_usage() {
    echo "=== Top 5 Largest Disk Partitions ==="
    # Prints the header, then sorts partitions by size (excluding tmpfs/devtmpfs)
    df -h -x tmpfs -x devtmpfs | head -n 1
    df -h -x tmpfs -x devtmpfs | tail -n +2 | sort -hr -k 2 | head -n 5
}

print_memory() {
    echo "=== Memory Usage ==="
    free -h
}

print_cpu_processes() {
    echo "=== Top 5 CPU-Consuming Processes ==="
    # Prints the columns headers, then the top 5 sorted by %CPU
    ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6
}

# --- Main Function ---

main() {
    clear
    echo "====================================================================="
    echo "                       SYSTEM INFO REPORTER                          "
    echo "====================================================================="
    echo "Generated on: $(date)"
    echo "====================================================================="
    echo ""

    print_os_info
    echo ""

    print_uptime
    echo ""

    print_disk_usage
    echo ""

    print_memory
    echo ""

    print_cpu_processes
    echo ""
    
    echo "====================================================================="
    echo "                          END OF REPORT                              "
    echo "====================================================================="
}

# Execute the main function
main
