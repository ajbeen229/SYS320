#! /bin/bash
clear

# filling courses.txt
bash courses.bash

courseFile="courses.txt"

function displayCoursesofInst(){

	echo -n "Please Input an Instructor Full Name: "
	read instName

	echo ""
	echo "Courses of $instName :"
	cat "$courseFile" | grep "$instName" | cut -d';' -f1,2 | \
	sed 's/;/ | /g'
	echo ""

}

function courseCountofInsts(){

	echo ""
	echo "Course-Instructor Distribution"
	cat "$courseFile" | cut -d';' -f7 | \
	grep -v "/" | grep -v "\.\.\." | \
	sort -n | uniq -c | sort -n -r 
	echo ""

}

# TODO - 1
# Make a function that displays all the courses in given location
# function dislaplays course code, course name, course days, time, instructor
# Add function to the menu
# Example input: JOYC 310
# Example output: See the screenshots in canvas
function getCoursesByLocation() {

	read -p "Enter a location: " location

	echo ""
	echo "Listing courses for $location: "
	cat "$courseFile" |\
	grep "$location" |\
	awk -F ';' '{printf "%-12s %-30s %-4s %-13s %s \n", $1,$2,$5,$6,$7}'

}

# TODO - 2
# Make a function that displays all the courses that has availability
# (seat number will be more than 0) for the given course code
# Add function to the menu
# Example input: SEC
# Example output: See the screenshots in canvas
function getCoursesBySubject() {

	read -p "Enter a course code: " code
	echo ""
	echo "Listing available courses for $code: "
	courses=$(\
		cat "$courseFile" |\
		awk -v code=$code '{if ($1 == code) {print}}'
	)

	echo "$courses" | while read -r line;
	do
		seats=$(echo "$line" | cut -d';' -f4)
		if [[ "$seats" -gt 4 ]]; then
			echo "$line" |\
			sed 's/;/ | /g'
		fi
	done

}

while :
do
	clear
	echo ""
	echo "Please select and option:"
	echo "[1] Display courses by instructor"
	echo "[2] Display course count of instructors"
	echo "[3] Display courses by location"
	echo "[4] Display courses with availibility"
	echo "[5] Exit"
	echo -n "> "

	read userInput
	echo ""

	if [[ "$userInput" == "5" ]]; then
		echo "Goodbye"
		break

	elif [[ "$userInput" == "1" ]]; then
		displayCoursesofInst

	elif [[ "$userInput" == "2" ]]; then
		courseCountofInsts

	elif [[ "$userInput" == "3" ]]; then
		getCoursesByLocation

	elif [[ "$userInput" == "4" ]]; then
		getCoursesBySubject

	# TODO - 3 Display a message, if an invalid input is given
	else
		echo "Invalid input."
	fi
	read
done
