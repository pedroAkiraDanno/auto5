#!/bin/bash
REPORTDATE="$(date +%d-%m-%y-%H%M)"
./health-check.sh 1> /var/log/health-report/health-check-report-$REPORTDATE.txt 2> /dev/null
echo -e "System Health Check Report For: $REPORTDATE" \
| mailx -a /var/log/health-report/health-check-report-$REPORTDATE.txt -s \
'System Health Check Report Attached' root@localhost