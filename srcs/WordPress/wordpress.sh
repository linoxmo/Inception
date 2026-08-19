#!/bin/bash

set -e

mkdir -p /var/www/html

cd /var/www/html

if [ ! -f wp-config.php ]; then

    wget https://wordpress.org/latest.tar.gz

    tar -xzf latest.tar.gz --strip-components=1

    rm latest.tar.gz

    cp wp-config-sample.php wp-config.php

    sed -i "s/database_name_here/${MYSQL_DATABASE}/" wp-config.php
    sed -i "s/username_here/${MYSQL_USER}/" wp-config.php
    sed -i "s/password_here/${MYSQL_PASSWORD}/" wp-config.php
    sed -i "s/localhost/${MYSQL_HOST}/" wp-config.php

fi

chown -R www-data:www-data /var/www/html

sed -i 's|^listen = .*|listen = 9000|' /etc/php/7.3/fpm/pool.d/www.conf

exec php-fpm7.3 -F