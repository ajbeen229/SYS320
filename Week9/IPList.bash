#!/bin/bash

# Practice listing IP addresses within /24

[ $# -ne 1 ] && echo "Usage: $0 <Prefix>" && exit 1

prefix=$1

[ ${#prefix} -lt 5 ] && \
printf "Prefix Length is too short\nPrefix Example: 10.0.17\n" && \
exit 1

for i in {1..255}
do
	ping -c 1 $prefix.$i | grep "64 bytes" | \
	grep -o -E "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}"
done
