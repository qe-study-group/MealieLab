#!/bin/bash 

echo "Stopping all services"
docker compose down

echo "Starting all services"
docker compose up
