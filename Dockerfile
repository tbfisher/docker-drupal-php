FROM php:7.1.0-fpm

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
        pdo \
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

# Xdebug
ENV XDEBUG_VERSION='2_5_0'
RUN curl -fsSL https://github.com/xdebug/xdebug/archive/XDEBUG_${XDEBUG_VERSION}.tar.gz -o xdebug.tar.gz && \
    mkdir -p /tmp/xdebug && \
    tar -xf xdebug.tar.gz -C /tmp/xdebug --strip-components=1 && \
    rm xdebug.tar.gz && \
    docker-php-ext-configure /tmp/xdebug --enable-xdebug && \
    docker-php-ext-install /tmp/xdebug && \
    rm -r /tmp/xdebug

# Misc
RUN apt-get update && \
    DEBIAN_FRONTEND="noninteractive" apt-get install -y \
        # sSMTP
        ssmtp           \
        # for drush
        mysql-client    \
        sudo

# Configure
COPY conf/php.ini-development /usr/local/etc/php/php.ini
COPY conf/php-cli.ini-development /usr/local/etc/php/php-cli.ini
COPY conf/php-fpm.d/www.conf-development /usr/local/etc/php-fpm.d/www.conf

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
