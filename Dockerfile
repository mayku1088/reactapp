FROM php:8.2-fpm

WORKDIR /var/www/html

COPY ./backend .

COPY --from=composer:2.2 /usr/bin/composer /usr/bin/composer

RUN chown -R www-data:www-data storage bootstrap/cache

RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libzip-dev \
    libpq-dev \
    && docker-php-ext-install exif pcntl sockets zip pdo pdo_pgsql

CMD ["php-fpm"]