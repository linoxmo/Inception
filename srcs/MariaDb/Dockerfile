FROM debian:bookworm

RUN apt update && apt install -y \
    mariadb-server \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /var/lib/mysql/*

COPY 50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY ./mariadb.sh /mariadb.sh

RUN chmod +x /mariadb.sh

CMD ["/mariadb.sh"]
