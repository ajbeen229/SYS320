#!/bin/bash

ip addr show $(ip route | awk '/default/ {print $5}') | grep 'inet ' | \
awk '{split($2, ip, "/"); print ip[1]}'
