#!/bin/bash

echo -e "<html>\n<head>\n<style>\ntable, th, td { border: 1px solid black }\n</style></head>" > report.html
echo -e "<body>\n<table bordercolor='black'>" >> report.html
echo -e "<th>IP</th>\n<th>Date</th>\n<th>URL</th>" >> report.html

while read -r line; do
	ip=$(echo "$line" | awk '{print $1}')
	date=$(echo "$line" | awk '{print $2}')
	url=$(echo "$line" | awk '{print $3}')
	echo -e "<tr>\n<td>$ip</td>\n<td>$date></td>\n<td>$url</td>\n</tr>" >> report.html
done < report.txt

echo -e "</table>\n</body>\n</html>" >> report.html

cp report.html /var/www/html
