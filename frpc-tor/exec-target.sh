#!/bin/bash

/opt/gen-ini.sh > /opt/frpc.ini

echo Clearing socat
ps -ef | grep socat | grep -v grep
ps -ef | grep socat | grep -v grep | awk '{print $2}' | xargs kill 2>/dev/null
ps -ef | grep socat | grep -v grep | awk '{print $2}' | xargs kill 2>/dev/null
ps -ef | grep socat | grep -v grep | awk '{print $2}' | xargs kill 2>/dev/null
sleep 3
echo Done
echo socat TCP4-LISTEN:8000,fork SOCKS4A:localhost:$SERVER_IP:$SERVER_PORT,socksport=9050
socat TCP4-LISTEN:8000,fork SOCKS4A:localhost:$SERVER_IP:$SERVER_PORT,socksport=9050&
socat TCP4-LISTEN:8000,fork SOCKS4A:localhost:$SERVER_IP:$SERVER_PORT,socksport=9050 2>/dev/null&


for x in $(seq 1 10)
do
    echo running frpc
    rm frpc-output.log 2>/dev/null
    /opt/frp/bin/frpc | tee frpc-output.log
    grep 'start proxy success' frpc-output.log
    if [ $? -eq 0 ]
    then
        echo found one!
    else
        python3 reset-tor.py
    fi
done