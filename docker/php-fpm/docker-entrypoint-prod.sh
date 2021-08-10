#!/bin/sh

cd /var/www/html

echo "Give permission"
chgrp -R www-data /var/www/html/storage /var/www/html/bootstrap/cache
chmod -R ug+rwx /var/www/html/storage /var/www/html/bootstrap/cache

echo "Create a storage link"
php artisan storage:link

echo "Migration database"
php artisan migrate --no-interaction

echo "Clear cache"
php artisan optimize:clear

exec "$@"