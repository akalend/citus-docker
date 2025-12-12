# citus-docker
создание отладочного кластера citus  на docker контейнерах

Папка citus - исходники citus 
Папка files - папка с внутренними файлами для контейнера


Два Dockerfile:

 -  Dockerfile.pg - базовый контейнер, который содержит утилиты и postgresql.
 -  Dockerfile  контейнер со сборкой citus
 -  cmd файл с полезными командами и шаблонами


Создание base образа:

    docker build -f Dockerfile.base -t postgres .

Создание рабочего образа первичного узла :

    docker build  -t citus .

Запуск контейнеров :

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
    
    