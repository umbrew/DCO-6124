#!/bin/bash

setup() {
  SQL_SETUP_FILE="/tmp/setup.sql"
  cat > ${SQL_SETUP_FILE} << EOL
BEGIN;
CREATE TABLE IF NOT EXISTS data (id INTEGER PRIMARY KEY, comment VARCHAR(100));
TRUNCATE TABLE data;
COMMIT;
EOL
  psql -f ${SQL_SETUP_FILE}
}

before() {
  SQL_INSERT_FILE="/tmp/insert.sql"
  echo "BEGIN;" > ${SQL_INSERT_FILE}
  for ((i = 1; i <= ${MAX_ID}; i++))
  do
     echo "INSERT INTO data VALUES (${i}, null);" >> ${SQL_INSERT_FILE}
  done
  echo "COMMIT;" >> ${SQL_INSERT_FILE}
  psql -f ${SQL_INSERT_FILE}
}

deleteAndReinsert() {
  SQL_DELETE_FILE="/tmp/delete.sql"
  SQL_REINSERT_FILE="/tmp/reinsert.sql"
  while true
  do
    echo "BEGIN;" > ${SQL_DELETE_FILE}
    echo "BEGIN;" > ${SQL_REINSERT_FILE}
    IDS=`shuf -i1-${MAX_ID} -n ${OPERATIONS_PER_TRANSACTION}`
    for i in ${IDS}
    do
      echo "DELETE FROM data WHERE id = ${i};" >> ${SQL_DELETE_FILE}
      echo "INSERT INTO data VALUES(${i}, 'reinserted');" >> ${SQL_REINSERT_FILE}
    done
    echo "COMMIT;" >> ${SQL_DELETE_FILE}
    echo "COMMIT;" >> ${SQL_REINSERT_FILE}
    psql -f ${SQL_DELETE_FILE}
    psql -f ${SQL_REINSERT_FILE}
  done
}

run() {
  MAX_ID=50000
  OPERATIONS_PER_TRANSACTION=50
  setup
  before
  deleteAndReinsert
}

run
