#!/bin/bash


set -euo pipefail


systeminfo() {
	echo "The Hostname is $HOSTNAME"
	source /etc/os-release
	echo "The OS is $PRETTY_NAME"
	echo "Version is $VERSION"
}

uptime() {
	echo "****System Uptime****"
	command uptime 
}

disk_usage() {
	echo "****Top 5 Disk usage****"
	set +o pipefail
	du -ahx / 2>/dev/null | sort -rh | head -n 5
	set -o pipefail
}

mem_usage() {
	echo "****Memory Usage****"
	free -h
}

top_cpu() {
	echo "****Top 5 CPU Processes****"
	ps axo user,pid,%cpu,start --sort=-%cpu | head -n 6
}


# ----Main Function----

main() {
	echo "####################################################"
	echo "                SYSTEM INFO REPORT                  "
	echo "####################################################"
	echo "Generated on : $(date)"
	echo "####################################################"


	systeminfo


	uptime


	disk_usage


	mem_usage


	top_cpu


	echo "#####################################################"
	echo "                 END OF REPORT                       "
	echo "#####################################################"

}


main

