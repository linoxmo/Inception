FROM debian:trixie

RUN apt update
RUN apt -y install nginx openssl gettext-base

COPY ./nginx.sh /
COPY ./conf/nginx.conf /etc/nginx/conf.d/default.conf

RUN chmod +x /nginx.sh

CMD ["./nginx.sh"]