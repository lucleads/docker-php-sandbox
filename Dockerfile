FROM composer as dependency-manager

WORKDIR /app

COPY composer.json composer.lock /app
RUN composer install \
    --ignore-platform-reqs \
    --no-ansi \
    --no-dev \
    --no-interaction \
    --no-scripts

COPY . /app/
RUN composer dump-autoload --no-dev --optimize --classmap-authoritative

ARG PHP_VERSION

# Base image
FROM php:${PHP_VERSION}-apache

# Install PHP extensions
RUN pecl install xdebug \
    && docker-php-ext-enable xdebug \

# Copy installed dependencies
COPY php.ini /usr/local/etc/php/php.ini

# Aliases
RUN echo 'alias com="composer"' >> ~/.bashrc
