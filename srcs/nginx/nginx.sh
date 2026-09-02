#!/bin/bash
set -e

envsubst '${DOMAIN_NAME}' < /etc/nginx/conf.d/default.conf > /tmp/default.conf.tmp
mv /tmp/default.conf.tmp /etc/nginx/conf.d/default.conf

if [ ! -f /etc/nginx/ssl/nginx.crt ]; then
    mkdir -p /etc/nginx/ssl
    openssl req -x509 -nodes -days 365 \
        -newkey rsa:2048 \
        -keyout /etc/nginx/ssl/nginx.key \
        -out /etc/nginx/ssl/nginx.crt \
        -subj "/C=FR/ST=IDF/L=Paris/O=42/CN=${DOMAIN_NAME}"
fi

exec nginx -g "daemon off;"
