#!/bin/bash

#shodan search "faithfully yours, frp" --limit 100 | awk '{print $1}' | sort -u > ips

for host in $(cat ips)
do
    ports=$(shodan host $host | grep '/tcp' | cut -d '/' -f 1 | awk '{print $1}')
    for port in $ports
    do
        # ./addserver.sh $host $port
        echo "curl localhost:5000/add -d 'ip=$host&port=$port'"
    done
done