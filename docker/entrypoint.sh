#!/bin/sh
set -e

echo "==> Linking storage..."
php artisan storage:link --no-interaction 2>/dev/null || true

echo "==> Running migrations..."
php artisan migrate --force --no-interaction

echo "==> Caching config, routes and views..."
php artisan config:cache
php artisan route:cache
php artisan view:cache

echo "==> Starting services..."
exec supervisord -c /etc/supervisor/conf.d/supervisord.conf
