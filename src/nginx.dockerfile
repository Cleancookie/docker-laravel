FROM nginx:1.9-alpine

RUN apk update \
    && apk add bash \
    && apk add openssl

RUN mkdir -p /var/www/vhosts \
    && mkdir -p /etc/ssl/sites
    