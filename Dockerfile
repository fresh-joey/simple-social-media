# Use the official PHP image
FROM php:8.0-apache

# Set the working directory in the container
WORKDIR /var/www/html

# Copy composer files and install dependencies
# COPY composer.* ./
RUN apt-get update && apt-get install curl
# RUN apt-get install -y docker-php-ext-install pdo_mysql
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && composer install --no-interaction --no-dev --optimize-autoloader

# Copy the rest of the application code
COPY . .

# Expose port 80
EXPOSE 80

# Start the Apache web server
CMD ["apache2-foreground"]
