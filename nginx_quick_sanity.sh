#!/bin/bash
#Nginx Quick sanity
set -euo pipefail

# Check nginx service status
pgrep nginx >/dev/null && echo "Nginx: RUNNING" || echo "ALERT: Nginx is DOWN!"

# Parse & find top 5 hitting IPs in an access log
awk '{print $1}' /var/log/nginx/access.log | sort | uniq -c | sort -rn | head -n 5
