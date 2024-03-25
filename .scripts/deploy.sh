#!/bin/bash
set -e

echo "Deployment started ...."

# Enter maintenance mode or return true
# if already is in maintenance mode
(php artisan down --message "The Application is being update. Please try again in a minute")

# Pull the latest version of the app
git pull origin main

# Exit maintenance mode
php artisan up

echo "Deployment is complete"
