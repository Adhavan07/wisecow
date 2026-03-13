#!/bin/bash

LOG_FILE="../logs/system_health.log"
THRESHOLD_CPU=80
THRESHOLD_MEM=80
THRESHOLD_DISK=80

echo "==============================" >> $LOG_FILE
echo "System Health Check - $(date)" >> $LOG_FILE

CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}')
MEM_USAGE=$(free | awk '/Mem:/ {printf("%.2f"), $3/$2 * 100}')
DISK_USAGE=$(df / | awk 'END{print $5}' | sed 's/%//')

echo "CPU Usage: $CPU_USAGE%" >> $LOG_FILE
echo "Memory Usage: $MEM_USAGE%" >> $LOG_FILE
echo "Disk Usage: $DISK_USAGE%" >> $LOG_FILE

if (( $(echo "$CPU_USAGE > $THRESHOLD_CPU" | bc -l) )); then
    echo "ALERT: High CPU usage!" >> $LOG_FILE
fi

if (( $(echo "$MEM_USAGE > $THRESHOLD_MEM" | bc -l) )); then
    echo "ALERT: High Memory usage!" >> $LOG_FILE
fi

if [ "$DISK_USAGE" -gt "$THRESHOLD_DISK" ]; then
    echo "ALERT: High Disk usage!" >> $LOG_FILE
fi

echo "==============================" >> $LOG_FILE
