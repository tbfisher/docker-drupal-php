FROM tbfisher/php:7.1.30-fpm

# Standard drupal install.
RUN apt-get update && \
    DEBIAN_FRONTEND="noninteractive" apt-get install -y \
        libpng-dev \
        libjpeg-dev \
        libpq-dev \
        libzip-dev \
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
        build-essential \
        imagemagick \
        libmagickwand-dev \
        libmemcached-dev \
        libmemcached11 \
        libmemcachedutil2 \
        libtidy-dev \
        libz-dev \
        && \
    docker-php-ext-install \
        pcntl \
        tidy \
        && \
    pecl install \
        imagick \
        memcached \
        redis \
        && \
    docker-php-ext-enable \
        imagick \
        memcached \
        redis

# Composer
RUN curl -sS https://getcomposer.org/installer | php --define memory_limit=-1 && \
    mv composer.phar /usr/local/bin/composer

# Misc
RUN apt-get update && \
    DEBIAN_FRONTEND="noninteractive" apt-get install -y \
        ssmtp           \
        mysql-client    \
        sudo

# Configure
COPY conf/etc/php/php.ini                           /usr/local/etc/php/php.ini
COPY conf/etc/php/php-cli.ini                       /usr/local/etc/php/php-cli.ini
COPY conf/etc/php-fpm.d/zz-docker.conf              /usr/local/etc/php-fpm.d/zz-docker.conf

ENV PHPFPM_LISTEN="[::]:9000" \
    PHPFPM_PM_MAX_CHILDREN=50 \
    PHPFPM_PM_START_SERVERS=2 \
    PHPFPM_PM_MIN_SPARE_SERVERS=1 \
    PHPFPM_PM_MAX_SPARE_SERVERS=3 \
    SSMTP_MAILHUB="mail:1025" \
    PHP_MAX_EXECUTION_TIME=30 \
    PHP_MEMORY_LIMIT=256M \
    PHP_REALPATH_CACHE_SIZE=4096k \
    PHP_REALPATH_CACHE_TTL=3600 \
    PHP_MAX_INPUT_VARS=2048 \
    PHP_POST_MAX_SIZE=64M \
    PHP_UPLOAD_MAX_FILESIZE=64M \
    PHP_MAX_FILE_UPLOADS=50 \
    PHP_SENDMAIL_PATH="/usr/sbin/ssmtp -t" \
    PHP_ALLOW_URL_FOPEN=Off \
    PHP_OPCACHE_ENABLE=1 \
    PHP_OPCACHE_MEMORY_CONSUMPTION=192 \
    PHP_OPCACHE_INTERNED_STRINGS_BUFFER=10 \
    PHP_OPCACHE_MAX_ACCELERATED_FILES=4096 \
    PHP_OPCACHE_VALIDATE_TIMESTAMPS=1 \
    PHP_OPCACHE_REVALIDATE_FREQ=0 \
    PHP_OPCACHE_FAST_SHUTDOWN=1 \
    PHP_CLI_OPCACHE_ENABLE_CLI=1 \
    PHP_CLI_MAX_EXECUTION_TIME=0 \
    PHP_CLI_MEMORY_LIMIT=-1 \
    PHP_CLI_REALPATH_CACHE_SIZE=4096k \
    PHP_CLI_REALPATH_CACHE_TTL=3600 \
    PHP_CLI_SENDMAIL_PATH="/usr/sbin/ssmtp -t"
COPY conf/bin/docker-php-entrypoint /usr/local/bin/docker-php-entrypoint

# Change docroot
RUN mkdir -p /var/www/web
WORKDIR /var/www/web

# Clean up
RUN apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /tmp/pear
