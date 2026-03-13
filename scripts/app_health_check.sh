#!/bin/bash

URL="http://65.2.34.82"
LOG_FILE="../logs/app_health.log"

STATUS=$(curl -o /dev/null -s -w "%{http_code}" $URL)

echo "==============================" >> $LOG_FILE
echo "App Health Check - $(date)" >> $LOG_FILE

if [ "$STATUS" -eq 200 ]; then
    echo "Application Status: UP" >> $LOG_FILE
else
    echo "Application Status: DOWN" >> $LOG_FILE
fi

echo "HTTP Response Code: $STATUS" >> $LOG_FILE
echo "==============================" >> $LOG_FILE
