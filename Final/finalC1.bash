#!/bin/bash

link="10.0.17.6/IOC.html"

fullPage=$(curl -sL "$link")

rows=$(
	echo "$fullPage" |\
	xmlstarlet format --html --recover 2>/dev/null |\
	xmlstarlet select --template --copy-of \
	"//html//body//table//tr//td"
)

rows=$(
	echo "$rows" |\
	sed 's/<td>//g' |\
	sed -e 's/<\/td>/;/g'
)

IFS=';'

read -ra rows <<< "$rows"

:> ioc.txt
for ((i=0; i<"${#rows[@]}"; i+=2)) {
	echo "${rows[$i]}" >> ioc.txt
}
