#!/bin/bash
set -e

echo "Deployment started ......."

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
# cd /var/www/social_media
npm run prod

# Run database migrations
php artisan migrate --force

# Exit maintenance mode
php artisan up

echo "Deployment Complete!"