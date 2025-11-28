cat .git/`cat .git/HEAD | awk '{print $2}'`  # хеш текущего коммита
export commit=$(cat .git/`cat .git/HEAD | awk '{print $2}'` | cut -c 1-7)
cat .git/HEAD | awk '{print $2}' | cut -d '/' -f 3-5


 docker images | grep none | awk '{print $3}' | xargs docker rmi

 docker ps -a | awk '{print $1}' | xargs docker rm


CREATE OR REPLACE FUNCTION citus_health()
RETURNS TEXT AS 'citus', 'citus_health' LANGUAGE C;