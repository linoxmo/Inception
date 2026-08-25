#!/bin/bash

set -e

mkdir -p /run/mysqld

chown -R mysql:mysql /run/mysqld
chown -R mysql:mysql /var/lib/mysql



mariadbd-safe --datadir=/var/lib/mysql &

until mysqladmin -h 127.0.0.1 ping --silent; do
    sleep 1
done

mariadb -u root << EOF
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF

mariadb-admin -u root -p "${MYSQL_ROOT_PASSWORD}" shutdown

exec mariadb --user=mysql --console