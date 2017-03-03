# PHP for Drupal

[PHP](https://hub.docker.com/_/php/) configured for [Drupal](https://www.drupal.org/) development.

*Note that depricated versions are available for development purposes, use at your own risk.*

Three builds of each minor version are provided:

-   dev -- with xdebug enabled, for development in protected environments. Xdebug will attempt to connect back to any request for a debugging session.
-   stage -- same as dev except no xdebug, suitable for staging sites.
-   prod -- suitable for production sites.
