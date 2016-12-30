# PHP for Drupal

Extended [PHP](https://hub.docker.com/_/php/) for [Drupal](https://www.drupal.org/) development.

## Build

```bash
maj=7
min=1
pat=0

./bin/build ${maj} ${min} ${pat}
```

inspect

```bash
docker run -i -t --rm drupal-php:${maj}.${min}.${pat}-fpm /bin/bash
```

push

```bash
git tag -f "${maj}.${min}.${pat}-fpm"
git push --tags
```
