#!/bin/bash

pages=""
curl=""
file="/var/log/apache2/access.log"

function pageCount() {

	pages=$(cat "$file" |\
			cut -d' ' -f7 |\
			tr -d "/" |\
			grep -v -e "^$" |\
			sort |\
			uniq -c)

}

function countCurlAccess() {

	curl=$( cat "$file" |\
			grep "curl" |\
			cut -d' ' -f12 |\
			tr -d "\"" |\
			sort |\
			uniq -c)

}

pageCount
countCurlAccess
echo "$curl"

