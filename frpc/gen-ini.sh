#!/bin/bash
export DOCKER_HOST_IP=$(route -n | awk '/UG[ \t]/{print $2}')

echo "[common]"
echo "server_addr = $SERVER_IP"
echo "server_port = $SERVER_PORT"
echo ""
echo "[service]"
echo "type = tcp"
echo "local_ip = $DOCKER_HOST_IP"
echo "local_port = $LOCAL_PORT"
echo "remote_port = $REMOTE_PORT"