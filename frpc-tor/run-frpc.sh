#!/bin/bash

if [ "$#" -ne 4 ]; then
    echo "USAGE: docker run frpc [SERVER_IP] [SERVER_PORT] [REMOTE_PORT] [LOCAL_PORT]"
else
    export SERVER_IP=$1
    export SERVER_PORT=$2
    export REMOTE_PORT=$3
    export LOCAL_PORT=$4
fi

tor --controlport 9051&
sleep 10


./exec-target.sh
