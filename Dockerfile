FROM composer:latest as build
WORKDIR /var/www/
COPY . /var/www/

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

FROM php:8.2-apache
RUN docker-php-ext-install pdo pdo_mysql

EXPOSE 8080
COPY --from=build /var/www/ /var/www/
COPY 000-default.conf /etc/apache2/sites-available/000-default.conf
COPY .env.example /var/www/.env
RUN chown -R www-data:www-data /var/www/storage &&\
    chown -R www-data:www-data /var/www/bootstrap/cache &&\
    chmod -R 775 /var/www/storage &&\
    chmod 664 /var/www/storage/logs/laravel.log &&\
    chmod -R 755 /var/www/bootstrap/cache &&\
    echo "Listen 8080" >> /etc/apache2/ports.conf && \
    a2enmod rewrite

