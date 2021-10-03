#!/bin/bash

if [ "$#" -ne 4 ]; then
    echo "USAGE: docker run frpc [SERVER_IP] [SERVER_PORT] [REMOTE_PORT] [LOCAL_PORT]"
else
    export SERVER_IP=$1
    export SERVER_PORT=$2
    export REMOTE_PORT=$3
    export LOCAL_PORT=$4
fi

/opt/gen-ini.sh > /opt/frpc.ini

echo "server_addr = $SERVER_IP"
echo "server_port = $SERVER_PORT"
echo "local_port = $LOCAL_PORT"
echo "remote_port = $REMOTE_PORT"

/opt/frp/frpc
