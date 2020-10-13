FROM php:7.4-fpm-alpine

RUN apk update \
    && apk add imagemagick \
    && apk add libmcrypt \
    #Setup build environment. These should be removed after building
    && apk add $PHPIZE_DEPS \
    && apk add libmcrypt-dev \
    && apk add imagemagick-dev \
    && apk add libpng-dev \
    && apk add jpeg-dev \
    && apk add libxml2-dev \
    && docker-php-source extract \
    # Build PHP extensions
    && pecl install mcrypt-1.0.2 && docker-php-ext-enable mcrypt \
    && pecl install imagick && docker-php-ext-enable imagick \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install soap \
    && docker-php-ext-configure gd --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd \
    # Tear down build script dependencies
    && apk del $PHPIZE_DEPS \
    && apk del libmcrypt-dev \
    && apk del imagemagick-dev \
    && apk del libpng-dev \
    && apk del jpeg-dev \
    && apk del libxml2-dev \
    && docker-php-source delete

RUN mkdir -p /var/www/html

WORKDIR /var/www/html