# PHP for Drupal

## Build

```bash
git checkout 7.1.x-fpm
./bin/build 7 1 0
git checkout 7.0.x-fpm
./bin/build 7 0 14
git checkout 5.6.x-fpm
./bin/build 5 6 29
git checkout 5.5.x-fpm
./bin/build 5 5 38
```

inspect

```bash
docker run -i -t --rm drupal-php:7.1.0-fpm /bin/bash
```
