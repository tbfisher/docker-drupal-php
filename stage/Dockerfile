FROM php:5.4.45-fpm

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
        pdo_mysql \
        pdo_pgsql \
        zip

# Some common optional extensions.
RUN apt-get update && \
    DEBIAN_FRONTEND="noninteractive" apt-get install -y \
        imagemagick \
        libmagickwand-dev \
        libmcrypt-dev \
        libtidy-dev \
        && \
    docker-php-ext-install \
        mcrypt \
        pcntl \
        tidy \
        && \
    pecl install \
        apc \
        imagick \
        redis \
        && \
    docker-php-ext-enable \
        apc \
        imagick \
        redis

# Misc
RUN apt-get update && \
    DEBIAN_FRONTEND="noninteractive" apt-get install -y \
        ssmtp           \
        mysql-client    \
        sudo

# Configure
COPY conf/php/php.ini                   /usr/local/etc/php/php.ini
COPY conf/php/php-cli.ini               /usr/local/etc/php/php-cli.ini
RUN cp /usr/local/etc/php-fpm.conf      /usr/local/etc/php-fpm.conf.bak
COPY conf/php-fpm.conf                  /usr/local/etc/php-fpm.conf
# php module conf
COPY conf/php/conf.d/docker-php-ext-apc.ini /usr/local/etc/php/conf.d/docker-php-ext-apc.ini

ENV PHPFPM_LISTEN="9000"
COPY conf/docker-entrypoint.sh /usr/local/bin/

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
