FROM php:5.5.38-fpm

MAINTAINER Brian Fisher <tbfisher@gmail.com>

# Standard drupal install.
RUN apt-get update && \
    DEBIAN_FRONTEND="noninteractive" apt-get install -y \
        libpng12-dev \
        libjpeg-dev \
        libpq-dev \
        && \
    docker-php-ext-configure \
        gd --with-png-dir=/usr --with-jpeg-dir=/usr \
        && \
    docker-php-ext-install \
        gd \
        mbstring \
        opcache \
        pdo_mysql \
        pdo_pgsql \
        zip

# Some common optional extensions.
RUN apt-get update && \
    DEBIAN_FRONTEND="noninteractive" apt-get install -y \
        # imagick
        imagemagick \
        libmagickwand-dev \
        # mcrypt
        libmcrypt-dev \
        # tidy
        libtidy-dev \
        && \
    docker-php-ext-install \
        mcrypt \
        tidy \
        && \
    pecl install \
        imagick \
        redis \
        && \
    docker-php-ext-enable \
        imagick \
        redis

# Misc
RUN apt-get update && \
    DEBIAN_FRONTEND="noninteractive" apt-get install -y \
        # sSMTP
        ssmtp           \
        # for drush
        mysql-client    \
        sudo

# Configure
COPY conf/php/php.ini                   /usr/local/etc/php/php.ini
COPY conf/php/php-cli.ini               /usr/local/etc/php/php-cli.ini
RUN cp /usr/local/etc/php-fpm.d/www.conf /usr/local/etc/php-fpm.d/www.conf.bak
COPY conf/php-fpm.d/www.conf            /usr/local/etc/php-fpm.d/www.conf

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
