#!/bin/sh

cd /var/www/html

echo "Create env file"
[[ -f .env ]] || cp .env.example .env

echo "Give permission"
chgrp -R www-data /var/www/html/storage /var/www/html/bootstrap/cache
chmod -R ug+rwx /var/www/html/storage /var/www/html/bootstrap/cache

echo "Generate key"
php artisan key:generate

echo "Create a storage link"
php artisan storage:link

echo "Migration database"
php artisan migrate --no-interaction

echo "Clear cache"
php artisan optimize:clear

exec "$@"