FROM debian:bookworm

RUN apt update && apt install -y \
    php8.2 \
    php8.2-fpm \
    php8.2-mysql \
    php8.2-curl \
    php8.2-gd \
    php8.2-intl \
    php8.2-mbstring \
    php8.2-xml \
    php8.2-zip \
    wget \
    mariadb-client \
    && rm -rf /var/lib/apt/lists/*

RUN  wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

COPY ./wordpress.sh /

RUN chmod +x /wordpress.sh

CMD ["/wordpress.sh"]
