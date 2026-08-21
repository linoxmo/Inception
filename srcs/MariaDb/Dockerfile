FROM debian:trixie

RUN apt update && apt install -y \
    mariadb-server mysql-server\
    && rm -rf /var/lib/apt/lists/
    *

COPY ./mariadb.sh /

RUN chmod +x /mariadb.sh

CMD ["/mariadb.sh"]