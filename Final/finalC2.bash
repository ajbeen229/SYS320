#!/bin/bash

logFile=$1
iocFile=$2

iocLogs=$(cat "$logFile" | egrep -i -f "$iocFile")

echo "$iocLogs" | awk '{print $1, $4, $7}' | tr -d "[" > report.txt
