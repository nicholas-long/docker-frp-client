#!/bin/bash

docker-compose down -v
docker-compose build
docker-compose up --scale sub=5 