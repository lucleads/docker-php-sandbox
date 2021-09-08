FROM composer as dependency-handler

WORKDIR /app

COPY . /app/
RUN composer install \
    --ignore-platform-reqs \
    --no-ansi \
    --no-dev \
    --no-interaction \
    --no-scripts

ARG PHP_VERSION

# Base image
FROM php:${PHP_VERSION}-apache

# Install PHP extensions
RUN pecl install xdebug \
    && docker-php-ext-enable xdebug

# Install Git
RUN apt-get -y update
RUN apt-get -y install git \
    zip \
    unzip

# Aliases
RUN echo 'alias com="composer"' >> ~/.bashrc
