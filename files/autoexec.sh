#!/bin/bash
# export PGPORT=5432
# export PGDATA=/usr/local/pgsql/data
# export PATH=$PATH:/usr/local/pgsql/bin
sudo chown postgres *.conf
sudo mkdir data
sudo chown postgres data
chmod 0700 data
# replication 

if [ -z "$MASTER_IP" ]; then
	echo "Мастер сервер"
	initdb
	cp *.conf data
else
  echo "Режим репликации."
  pg_basebackup --port=5432  --host=$MASTER_IP -D data    -Fp -Xs -P -R
fi
# master
pg_ctl start
psql -c 'CREATE EXTENSION citus'
pg_ctl stop
postgres
