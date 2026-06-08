FROM composer:latest AS vendor

WORKDIR /app

COPY ./backend .

RUN composer install --no-dev


FROM php:8.2-fpm

WORKDIR /var/www/html

COPY ./backend .

COPY --from=vendor /app/vendor ./vendor

RUN chown -R www-data:www-data storage bootstrap/cache

RUN apt-get update && apt-get install -y libpq-dev \
    && docker-php-ext-install pdo pdo_pgsql

CMD ["php-fpm"]