#!/bin/bash

tor --controlport 9051&
sleep 10

amqp-consume -u amqp://rabbit -q "test" -e "amq.topic" -r "worker1" /opt/worker/script.sh
