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
tor --controlport 9051&

echo socat TCP4-LISTEN:8000,fork SOCKS4A:localhost:$SERVER_IP:$SERVER_PORT,socksport=9050
socat TCP4-LISTEN:8000,fork SOCKS4A:localhost:$SERVER_IP:$SERVER_PORT,socksport=9050&

sleep 10

for x in $(seq 1 10)
do
    echo running frpc
    rm frpc-output.log
    /opt/frp/bin/frpc | tee frpc-output.log
    grep 'start proxy success' frpc-output.log
    if [ $? -eq 0 ]
    then
        echo found one!
    else
        python3 reset-tor.py
    fi
done

