# PHP for Drupal

## Build

```bash
maj=5
min=4
pat=45

./bin/build ${maj} ${min} ${pat}
```

inspect

```bash
docker run -i -t --rm drupal-php:${maj}.${min}.${pat}-fpm /bin/bash
```

push

```bash
git commit -m "${maj}.${min}.${pat}"
git tag -f "${maj}.${min}.${pat}"
git push --tags
```
