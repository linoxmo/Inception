FROM debian:trixie

RUN apt update && apt install -y \
    php8.4 \
    php8.4-fpm \
    php8.4-mysql \
    php8.4-curl \
    php8.4-gd \
    php8.4-intl \
    php8.4-mbstring \
    php8.4-xml \
    php8.4-zip \
    wget \
    mariadb-client \
    && rm -rf /var/lib/apt/lists/*

COPY ./wordpress.sh /

RUN chmod +x /wordpress.sh

CMD ["/wordpress.sh"]