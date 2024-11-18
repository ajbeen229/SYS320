#!/bin/bash
clear

date=$(date '+%Y-%m-%d %H-%M-%S')
echo "File was accessed on $date" >> fileaccesslog.txt

echo "To: alexander.been@mymail.champlain.edu" > emailform-2.txt
echo "Subject: File Access" >> emailform-2.txt
cat fileaccesslog.txt >> emailform-2.txt
cat emailform-2.txt | ssmtp alexander.been@mymail.champlain.edu
