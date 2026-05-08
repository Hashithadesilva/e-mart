# ─── Stage 1: Build frontend assets ─────────────────────────────────
FROM node:20-alpine AS node-builder

WORKDIR /app

COPY package.json package-lock.json* ./
RUN npm ci

COPY . .
RUN npm run build


# ─── Stage 2: PHP application ────────────────────────────────────────
FROM php:8.2-fpm-alpine

# Install system dependencies + nginx + supervisor
RUN apk add --no-cache \
    nginx \
    supervisor \
    libpng-dev \
    libzip-dev \
    libxml2-dev \
    oniguruma-dev \
    zip \
    unzip \
    curl \
    bash

# Install required PHP extensions
RUN docker-php-ext-install \
    pdo_mysql \
    mbstring \
    exif \
    pcntl \
    bcmath \
    gd \
    zip \
    opcache \
    xml

# Opcache settings for production
RUN echo "opcache.enable=1" >> /usr/local/etc/php/conf.d/opcache.ini \
 && echo "opcache.memory_consumption=128" >> /usr/local/etc/php/conf.d/opcache.ini \
 && echo "opcache.max_accelerated_files=10000" >> /usr/local/etc/php/conf.d/opcache.ini \
 && echo "opcache.validate_timestamps=0" >> /usr/local/etc/php/conf.d/opcache.ini

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

# Copy composer files first to cache the layer
COPY composer.json composer.lock ./
RUN composer install \
    --no-dev \
    --no-scripts \
    --no-autoloader \
    --prefer-dist \
    --optimize-autoloader

# Copy full application source
COPY . .

# Copy built Vite assets from stage 1
COPY --from=node-builder /app/public/build ./public/build

# Complete autoloader generation
RUN composer dump-autoload --optimize

# Copy Docker config files
COPY docker/nginx.conf        /etc/nginx/nginx.conf
COPY docker/supervisord.conf  /etc/supervisor/conf.d/supervisord.conf
COPY docker/entrypoint.sh     /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Fix storage + cache permissions
RUN mkdir -p storage/framework/{sessions,views,cache} storage/logs bootstrap/cache \
 && chown -R www-data:www-data storage bootstrap/cache \
 && chmod -R 775 storage bootstrap/cache

# Fly.io expects port 8080
EXPOSE 8080

ENTRYPOINT ["/entrypoint.sh"]
