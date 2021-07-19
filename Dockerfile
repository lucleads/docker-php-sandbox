ARG PHP_VERSION

# Base image
FROM php:${PHP_VERSION}-apache

# Install PHP extensions
RUN pecl install xdebug \
    && docker-php-ext-enable xdebug

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install Git
RUN apt-get -y update
RUN apt-get -y install git \
    zip \
    unzip

# Aliases
RUN echo 'alias com="composer"' >> ~/.bashrc
