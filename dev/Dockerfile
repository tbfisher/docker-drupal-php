FROM php:7.1.1-fpm

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

# Xdebug
ENV XDEBUG_VERSION='2_5_1'
RUN curl -fsSL https://github.com/xdebug/xdebug/archive/XDEBUG_${XDEBUG_VERSION}.tar.gz -o xdebug.tar.gz && \
    mkdir -p /usr/src/php/ext/xdebug && \
    tar -xf xdebug.tar.gz -C /usr/src/php/ext/xdebug --strip-components=1 && \
    rm xdebug.tar.gz && \
    docker-php-ext-configure xdebug && \
    docker-php-ext-install xdebug && \
    rm -r /usr/src/php/ext/xdebug

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
COPY conf/php-fpm.d/www.conf            /usr/local/etc/php-fpm.d/www.conf
# php module conf
COPY conf/php/conf.d/docker-php-ext-xdebug.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
