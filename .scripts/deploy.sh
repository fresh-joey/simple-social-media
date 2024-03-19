#!/bin/bash
set -e

echo "Deployment started ...."

# Enter maintenance mode or return true
# if already is in maintenance mode
(php artisan down) || true

# Pull the latest version of the app

git pull origin main


# Clear the old cache
# php artisan clear-compiled

# Recreate cache
# php artisan optimize

# Install Nodejs
curl -sL https://deb.nodesource.com/setup_21.x -o nodesource_setup.sh
sudo bash nodesource_setup.sh
sudo apt install nodejs
node -v
rm nodesource_setup.sh

# Compile npm assets
npm install
npm run dev
npm run prod

# Run database migrations
php artisan migrate --force

sudo chown -R $USER:www-data /var/www/social_media/storage
sudo chown -R $USER:www-data /var/www/social_media/bootstrap/cache
sudo chmod -R 775 /var/www/social_media/storage
sudo chmod -R 755 /var/www/social_media/bootstrap/cache

# Exit maintenance mode
php artisan up

echo "Deployment Complete!"