#!/bin/bash

#disk usage check function
check_disk() {
	df -h /
}

#memory usage check function
check_memory() {
	free -h
}

#main
echo "Running System check"
echo "#####################################"
echo "Disk usage of root partition"
check_disk

echo "#####################################"
echo "Memory usage of system"
check_memory

echo "finished"
