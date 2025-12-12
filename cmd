cat .git/`cat .git/HEAD | awk '{print $2}'`  # хеш текущего коммита
export commit=$(cat .git/`cat .git/HEAD | awk '{print $2}'` | cut -c 1-7)
cat .git/HEAD | awk '{print $2}' | cut -d '/' -f 3-5


 docker images | grep none | awk '{print $3}' | xargs docker rmi

 docker ps -a | awk '{print $1}' | xargs docker rm


CREATE OR REPLACE FUNCTION citus_health()
RETURNS TEXT AS 'citus', 'citus_health' LANGUAGE C;

CREATE OR REPLACE FUNCTION citus_health_reconf(propagete BOOL DEFAULT TRUE )
RETURNS BOOL AS 'citus', 'citus_health_reconf' LANGUAGE C;


pg_basebackup -p 5532  -D data11 -Fp -Xs -P -R


 docker ps -a | grep Exited |awk '{print $1}' | xargs docker rm

docker run -d --name coord citus
docker run -d --name worker1 citus
docker run -d --name worker2 citus

export IP_COORD=`docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' coord`
export IP_W1=`docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' worker1`
export IP_W2=`docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' worker2`


docker run -d --name scoord  -e MASTER_IP=$IP_COORD citus
docker run -d --name sworker1 -e MASTER_IP=$IP_W1 citus
docker run -d --name sworker2 -e MASTER_IP=$IP_W2 citus


export IP_SCOORD=`docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' scoord`
export IP_SW1=`docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' sworker1`
export IP_SW2=`docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' sworker2`


psql -h $IP_COORD -U postgres -c "SELECT citus_set_coordinator_host('$IP_COORD', 5432)"
psql -h $IP_COORD -U postgres -c "SELECT citus_add_node('$IP_W1', 5432)"
psql -h $IP_COORD -U postgres -c "SELECT citus_add_node('$IP_2', 5432)"

psql -h $IP_COORD -U postgres -c "SELECT citus_add_secondary_node('$IP_SCOORD', 5432,'$IP_COORD', 5432)"
psql -h $IP_COORD -U postgres -c "SELECT citus_add_secondary_node('$IP_SW1', 5432,'$IP_W1', 5432)"
psql -h $IP_COORD -U postgres -c "SELECT citus_add_secondary_node('$IP_SW2', 5432,'$IP_W2', 5432)"


psql -h $IP_COORD -U postgres -c "SELECT citus_health()"
psql -h $IP_SCOORD -U postgres -c "SELECT citus_health()"

psql -h $IP_W1 -U postgres -c "SELECT citus_health()"
psql -h $IP_W2 -U postgres -c "SELECT citus_health()"
psql -h $IP_SW2 -U postgres -c "SELECT citus_health()"
psql -h $IP_SW1 -U postgres -c "SELECT citus_health()"






docker inspect $(docker ps -q) --format='{{printf "%-30s" .Name}} {{range .NetworkSettings.Networks}}{{.IPAddress}} {{end}}' | sed 's/\///'


sudo -u postgres pg_basebackup -h <primary_ip> -p 5432 -U replicator -D /var/lib/postgresql/16/main/ -Fp -Xs -P -R

select pg_is_in_recovery();
SELECT groupid, nodeport,nodename,noderole FROM pg_dist_node  ;
select pid,application_name,backend_type from pg_stat_activity;
SELECT * from pg_stat_replication;


