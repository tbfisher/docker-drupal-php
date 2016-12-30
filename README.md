# PHP for Drupal

## Build

```bash
maj=5
min=6
pat=29

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
