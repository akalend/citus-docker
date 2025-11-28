FROM postgres

WORKDIR /home/citus

USER root
ENV PATH=$PATH:/usr/local/pgsql/bin
COPY citus citus

RUN cd citus && bash autogen.sh && ./configure && make && sudo make install 
RUN locale-gen ru_RU.UTF-8


WORKDIR /usr/local/pgsql/

COPY files/autoexec.sh .
COPY files/postgresql.conf .
COPY files/pg_hba.conf .

ENV PGPORT=5432
ENV PGDATA=/usr/local/pgsql/data
USER postgres
CMD autoexec.sh
ENTRYPOINT bash /usr/local/pgsql/autoexec.sh