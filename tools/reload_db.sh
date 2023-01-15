#!/bin/bash 

docker exec postgres sh -c "./db_dump/restore_db.sh"