#!/bin/bash

shodan search "faithfully yours, frp" --limit 100 > output.txt 

for host in $(cat output.txt | awk '{print $1}')
do
    ports=$(shodan host $host | grep '/tcp' | cut -d '/' -f 1 | awk '{print $1}')
    for port in $ports
    do
        ./addserver.sh $host $port
    done
done