FROM php:8.1-fpm

WORKDIR /app

RUN apt update && \
    apt install -y \
    zip \
    libpq-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libzip-dev \
    curl \
    && rm -rf /var/lib/apt/lists/*

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN curl -sL https://deb.nodesource.com/setup_18.x | bash - && \
    apt install -y nodejs

RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd zip pdo pgsql pdo_pgsql \
    && docker-php-ext-enable pgsql pdo_pgsql

RUN pecl install openswoole \
    && docker-php-ext-enable openswoole \
    && docker-php-ext-install pcntl

COPY roll.ini /usr/local/etc/php/conf.d/

ENTRYPOINT [ "php-fpm" ]
