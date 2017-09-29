#!/bin/sh
set -e

# Configurable.
sed -i 's@%PHPFPM_LISTEN%@'"${PHPFPM_LISTEN}"'@' /usr/local/etc/php-fpm.conf

# https://github.com/docker-library/php/blob/master/7.1/docker-php-entrypoint

# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
    set -- php "$@"
fi

exec "$@"
