#!/bin/bash 

echo "Stopping all services"
docker compose stop

echo "Starting all services"
docker compose up
