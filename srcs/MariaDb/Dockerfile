FROM debian:buster

RUN apt update && apt install -y \
    mariadb-server \
    && rm -rf /var/lib/apt/lists/*

COPY ./mariadb.sh /

RUN chmod +x /mariadb.sh

CMD ["/mariadb.sh"]