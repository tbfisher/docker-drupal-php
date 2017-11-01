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

# Xdebug
ENV XDEBUG_VERSION='2_4_1'
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
COPY conf/php/conf.d/docker-php-ext-xdebug.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

ENV PHPFPM_LISTEN="127.0.0.1:9000" \
    PHPFPM_PM_MAX_CHILDREN=50 \
    PHPFPM_PM_START_SERVERS=2 \
    PHPFPM_PM_MIN_SPARE_SERVERS=1 \
    PHPFPM_PM_MAX_SPARE_SERVERS=3 \
    SSMTP_MAILHUB="mail:1025" \
    PHP_MAX_EXECUTION_TIME=600 \
    PHP_MEMORY_LIMIT=256M \
    PHP_REALPATH_CACHE_SIZE=4096k \
    PHP_REALPATH_CACHE_TTL=3600 \
    PHP_MAX_INPUT_VARS=2048 \
    PHP_POST_MAX_SIZE=64M \
    PHP_UPLOAD_MAX_FILESIZE=64M \
    PHP_SENDMAIL_PATH="/usr/sbin/ssmtp -t" \
    PHP_CLI_MAX_EXECUTION_TIME=0 \
    PHP_CLI_MEMORY_LIMIT=-1 \
    PHP_CLI_REALPATH_CACHE_SIZE=4096k \
    PHP_CLI_REALPATH_CACHE_TTL=3600 \
    PHP_CLI_SENDMAIL_PATH="/usr/sbin/ssmtp -t"
COPY docker-php-entrypoint /usr/local/bin/docker-php-entrypoint

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
