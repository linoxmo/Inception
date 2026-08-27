#!/bin/bash

set -e

mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld

if [ ! -d "/var/lib/mysql/mysql" ]; then

    mariadb-install-db \
        --user=mysql \
        --datadir=/var/lib/mysql \
        --skip-test-db

    mariadbd \
        --user=mysql \
        --datadir=/var/lib/mysql \
        --skip-networking &

    for i in $(seq 1 30); do
        if mariadb-admin \
            --socket=/run/mysqld/mysqld.sock \
            ping >/dev/null 2>&1
        then
            break
        fi
        sleep 1
    done

    mariadb \
        --socket=/run/mysqld/mysqld.sock \
        -u root << SQL

ALTER USER 'root'@'localhost'
IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';

CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};

CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%'
IDENTIFIED BY '${MYSQL_PASSWORD}';

GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.*
TO '${MYSQL_USER}'@'%';

FLUSH PRIVILEGES;

SQL

    mariadb-admin \
        --socket=/run/mysqld/mysqld.sock \
        -u root \
        -p"${MYSQL_ROOT_PASSWORD}" \
        shutdown
fi

exec mariadbd --user=mysql --console