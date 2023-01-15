#!/bin/bash 

echo "Dropping DB..."
dropdb  -h localhost -U mealie --force mealie
echo "Creating db mealie" 
createdb  -h localhost -U mealie -T template0 mealie
echo "Restoring db mealie"
pg_restore -h localhost -U mealie -d mealie /db_dump/mealie_db.dump
