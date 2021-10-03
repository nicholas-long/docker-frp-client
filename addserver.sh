#!/bin/bash

IP=$1
PORT=$2
curl localhost:5000/add -d "ip=$IP&port=$PORT"
