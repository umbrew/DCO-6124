#!/bin/bash

counter=-1;
while true
do
  echo "Writing to PostgreSQL (you have to manually abort)"
  counter=$((counter+1))
  psql -c "INSERT INTO data VALUES (${counter}, 'test')"
  sleep 0.1
done
