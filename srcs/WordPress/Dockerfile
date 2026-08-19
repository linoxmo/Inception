FROM debian:buster

RUN apt update && apt install -y \
    php7.3 \
    php7.3-fpm \
    php7.3-mysql \
    php7.3-curl \
    php7.3-gd \
    php7.3-intl \
    php7.3-mbstring \
    php7.3-xml \
    php7.3-zip \
    wget \
    mariadb-client \
    && rm -rf /var/lib/apt/lists/*

COPY ./wordpress.sh /

RUN chmod +x /wordpress.sh

CMD ["/wordpress.sh"]