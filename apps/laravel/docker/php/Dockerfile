# Set host user and group id for all stages
ARG HOST_USER_UID=1001
ARG HOST_USER_GID=1001

FROM composer:2.0.9 AS vendor
WORKDIR /app

FROM php:8.0.2-cli AS cli

# Retrieve the host user and group id
ARG HOST_USER_UID
ARG HOST_USER_GID

# Install the required dependencies for composer and laravel
RUN apt-get update && apt-get install -y \
    libzip-dev \
    libpng-dev \
    zip \
    unzip \
    libgpgme11-dev

RUN pecl install gnupg \
    && docker-php-ext-enable gnupg

RUN docker-php-ext-install zip \
    pdo \
    pdo_mysql \
    bcmath \
    sockets \
    pcntl \
    gd

COPY ./docker/php/php.ini /usr/local/etc/php/
RUN pear config-set php_ini /usr/local/etc/php/php.ini

# Add the user that will be expected, sharing a user and group id with the host
RUN addgroup --gid ${HOST_USER_GID} nginx
RUN adduser --system --no-create-home --uid $HOST_USER_UID --ingroup nginx webuser

# Copy the application files
COPY --chown=webuser:nginx ./. /app/

# Copy composer from the composer image
WORKDIR /app
COPY --from=vendor /usr/bin/composer /usr/bin/composer
RUN /usr/bin/composer install --no-interaction --no-dev --no-scripts --no-progress --prefer-dist --optimize-autoloader
