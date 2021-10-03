#!/bin/bash
export DOCKER_HOST_IP=$(route -n | awk '/UG[ \t]/{print $2}')

echo "[common]"
echo "server_addr = 127.0.0.1"
echo "server_port = 8000"
echo ""
echo "[service]"
echo "type = tcp"
echo "local_ip = $DOCKER_HOST_IP"
echo "local_port = $LOCAL_PORT"
echo "remote_port = $REMOTE_PORT"