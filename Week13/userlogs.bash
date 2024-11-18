#! /bin/bash

authfile="/var/log/auth.log"

# function to get sucessful logins and echo them
function getLogins(){

	logline=$(cat "$authfile" | grep "systemd-logind" | grep "New session")
	dateAndUser=$(echo "$logline" | cut -d' ' -f1,2,11 | tr -d '\.')
	echo "$dateAndUser"

}


# Function to get failed logs from auth.log and echo them
function getFailedLogins() {

	logs=$(cat "$authfile" | grep "lightdm" | grep "failure")
	dateUser=$(echo "$logs" | awk 'split($15, user, "=") {print $1,$2,$3,user[2]}' |\
	sed "s/[\:]/-/g")
	echo "$dateUser"

}

function emailLogins() {

	echo "To: alexander.been@mymail.champlain.edu" > emailform.txt
	echo "Subject: Logins" >> emailform.txt
	getLogins >> emailform.txt
	cat emailform.txt | ssmtp alexander.been@mymail.champlain.edu

}

function emailFailedLogins() {

	echo "To:alexander.been@mymail.champlain.edu" > emailform-1.txt
	echo "Subject:Failed Logins" >> emailform-1.txt
	getFailedLogins >> emailform-1.txt
	cat emailform-1.txt | ssmtp alexander.been@mymail.champlain.edu

}

emailLogins
emailFailedLogins
