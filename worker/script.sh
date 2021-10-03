#!/bin/bash

read args
echo processing $args
timeout 10 /opt/run-frpc.sh $args 8999 80 > output
cat output
grep 'start proxy success' output
if [ $? -eq 0 ]
then
    echo success
    host=$(echo $args | cut -d ' ' -f 1)
    port=$(echo $args | cut -d ' ' -f 2)
    mysql -h mysql -u mysql -pmysql -D frpsscan -e "insert into targets (ip, port, valid) values ('$host', $port, 1);"
    python3 /opt/worker/push.py
fi
