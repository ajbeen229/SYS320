#!/bin/bash
clear

link="10.0.17.6/Assignment.html"

page=$(curl -sL "$link")

temps=( $(\
	echo "$page" |\
	xmllint --xpath "//table[@id='temp']//td" - |\
	awk -F "[><]" '{print $3}'
) )

press=( $(\
	echo "$page" |\
	xmllint --xpath "//table[@id='press']//td" - |\
	awk -F "[><]" '{print $3}'
) )



for ((i=0; i<"${#temps[@]}"; i+=2)) {

	echo "${temps[$i]} deg | ${press[$i]} Pa | ${temps[$i+1]}"

}
