#!/bin/bash

read args
echo processing $args
# export SERVER_IP=$(echo "$args" | cut -d ' ' -f 1)
# export SERVER_PORT=$(echo "$args" | cut -d ' ' -f 2)
# export REMOTE_PORT=8999
# export LOCAL_PORT=80
rm output 2>/dev/null
timeout 15 /opt/run-frpc.sh $args 8999 80 | tee output
# timeout 55 /opt/exec-target.sh > output

# cat output
grep 'start proxy success' output
if [ $? -eq 0 ]
then
    echo success
    host=$(echo $args | cut -d ' ' -f 1)
    port=$(echo $args | cut -d ' ' -f 2)
    mysql -h mysql -u mysql -pmysql -D frpsscan -e "insert into targets (ip, port, valid) values ('$host', $port, 1);"
    python3 /opt/worker/push.py
fi
# grep 'dial tcp 127.0.0.1:8000: connect: connection refused' output
# if [ $? -eq 0 ]
# then
#     ps -ef | grep tor | grep -v grep | awk '{print $2}' | xargs kill
#     ps -ef | grep amqp-consume | grep -v grep | awk '{print $2}' | xargs kill
#     exit 1
# fi