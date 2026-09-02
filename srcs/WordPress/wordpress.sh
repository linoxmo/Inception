#!/bin/bash
set -e
mkdir -p /var/www/html
cd /var/www/html

MYSQL_PASSWORD=$(cat /run/secrets/db_password)
WP_ADMIN_PASSWORD=$(cat /run/secrets/wp_admin_password)
WP_USER_PASSWORD=$(cat /run/secrets/wp_user_password)

if [ ! -f wp-config.php ]; then
    wget https://wordpress.org/latest.tar.gz
    tar -xzf latest.tar.gz --strip-components=1
    rm latest.tar.gz
    cp wp-config-sample.php wp-config.php
    sed -i "/DB_HOST/a define('WP_HOME', 'https://${DOMAIN_NAME}');" wp-config.php
    sed -i "/DB_HOST/a define('WP_SITEURL', 'https://${DOMAIN_NAME}');" wp-config.php
    sed -i "s/database_name_here/${MYSQL_DATABASE}/" wp-config.php
    sed -i "s/username_here/${MYSQL_USER}/" wp-config.php
    sed -i "s/password_here/${MYSQL_PASSWORD}/" wp-config.php
    sed -i "s/localhost/${MYSQL_HOST}/" wp-config.php

    # Attendre que mariadb soit prête avant d'installer
    until mysqladmin ping -h"${MYSQL_HOST}" -u"${MYSQL_USER}" -p"${MYSQL_PASSWORD}" --silent; do
        sleep 1
    done

    wp core install \
        --path=/var/www/html \
        --url="https://${DOMAIN_NAME}" \
        --title="${WP_TITLE}" \
        --admin_user="${WP_ADMIN_USER}" \
        --admin_password="${WP_ADMIN_PASSWORD}" \
        --admin_email="${WP_ADMIN_EMAIL}" \
        --allow-root

    wp user create "${WP_USER}" "${WP_USER_EMAIL}" \
        --path=/var/www/html \
        --role=editor \
        --user_pass="${WP_USER_PASSWORD}" \
        --allow-root
fi

chown -R www-data:www-data /var/www/html
sed -i 's|^listen = .*|listen = 9000|' /etc/php/8.2/fpm/pool.d/www.conf
exec php-fpm8.2 -F
