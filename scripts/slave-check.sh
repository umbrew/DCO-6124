#!/bin/bash

while true
do
  psql -c 'SELECT id, COUNT(*) FROM data GROUP BY id HAVING COUNT(*) > 1' | grep '0 rows' || exit
  sleep 1
done
