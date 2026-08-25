FROM debian:trixie

RUN apt update && apt install -y \
    mariadb-server \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /var/lib/mysql/*

COPY ./mariadb.sh /mariadb.sh

RUN chmod +x /mariadb.sh

CMD ["/mariadb.sh"]