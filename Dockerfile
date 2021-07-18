ARG PHP_VERSION

FROM php:${PHP_VERSION}-apache

RUN pecl install xdebug \
    && docker-php-ext-enable xdebug
