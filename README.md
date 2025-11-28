# citus-docker
создание отладочного кластера citus  на docker контейнерах

Папка citus - исходники citus 
Папка files - папка с внутренними файлами для контейнера


Два Dockerfile:

 -  Dockerfile.pg - базовый контейнер, который содержит утилиты и postgresql.
 -  Dockerfile  контейнер со сборкой citus
 -  cmd файл с полезными командами и шаблонами
