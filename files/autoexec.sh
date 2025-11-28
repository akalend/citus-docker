#!/bin/bash
# export PGPORT=5432
# export PGDATA=/usr/local/pgsql/data
# export PATH=$PATH:/usr/local/pgsql/bin
sudo chown postgres *.conf
sudo mkdir data
sudo chown postgres data
initdb
cp *.conf data
pg_ctl start
psql -c 'CREATE EXTENSION citus'
pg_ctl stop
postgres
