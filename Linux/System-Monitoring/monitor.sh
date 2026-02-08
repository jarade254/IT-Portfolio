#!/bin/bash
# Enhanced Linux System Monitoring Script
# Author: KIPNGETICH TONUI JARED
# Date: 2026-02-08

LOGFILE="$HOME/SystemReports/report_$(date +%Y-%m-%d_%H-%M-%S).log"
mkdir -p "$(dirname "$LOGFILE")"

echo -e "\e[1;34m===== SYSTEM MONITORING REPORT =====\e[0m" | tee -a "$LOGFILE"
echo "Date & Time: $(date)" | tee -a "$LOGFILE"
echo "" | tee -a "$LOGFILE"

echo -e "\e[1;33m---- CPU Usage ----\e[0m" | tee -a "$LOGFILE"
top -bn1 | grep "Cpu(s)" | tee -a "$LOGFILE"

echo "" | tee -a "$LOGFILE"
echo -e "\e[1;33m---- Memory Usage ----\e[0m" | tee -a "$LOGFILE"
free -h | tee -a "$LOGFILE"

echo "" | tee -a "$LOGFILE"
echo -e "\e[1;33m---- Disk Usage ----\e[0m" | tee -a "$LOGFILE"
df -h | grep "^/dev/" | tee -a "$LOGFILE"

echo "" | tee -a "$LOGFILE"
echo -e "\e[1;33m---- Top 5 Memory Consuming Processes ----\e[0m" | tee -a "$LOGFILE"
ps aux --sort=-%mem | head -n 6 | tee -a "$LOGFILE"

echo "" | tee -a "$LOGFILE"
echo -e "\e[1;33m---- Network Connections ----\e[0m" | tee -a "$LOGFILE"
ss -tuln | tee -a "$LOGFILE"

echo "" | tee -a "$LOGFILE"
echo -e "\e[1;32m===== END OF REPORT =====\e[0m" | tee -a "$LOGFILE"

# Optional alerts
CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
MEM=$(free | awk '/Mem/ {print $3/$2 * 100.0}')

if (( $(echo "$CPU > 80" | bc -l) )); then
    echo "⚠️ CPU usage high: $CPU%" | tee -a "$LOGFILE"
fi

if (( $(echo "$MEM > 80" | bc -l) )); then
    echo "⚠️ Memory usage high: $MEM%" | tee -a "$LOGFILE"
fi
