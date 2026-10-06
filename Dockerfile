FROM php:5.6-apache

RUN echo "deb [trusted=yes] http://archive.debian.org/debian/ stretch main" > /etc/apt/sources.list \
    && echo "deb [trusted=yes] http://archive.debian.org/debian-security/ stretch/updates main" >> /etc/apt/sources.list \
    && printf 'Acquire::Check-Valid-Until "false";\nAcquire::AllowInsecureRepositories "true";\nAPT::Get::AllowUnauthenticated "true";\n' > /etc/apt/apt.conf.d/99fix

RUN apt-get update && apt-get install -y --allow-unauthenticated \
        zlib1g-dev \
        libpng-dev \
        libjpeg62-turbo-dev \
        libfreetype6-dev \
        libzip-dev \
        libicu-dev \
        zip \
        unzip \
    && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-configure gd --with-freetype-dir=/usr --with-jpeg-dir=/usr \
    && docker-php-ext-install mysqli pdo pdo_mysql gd zip exif intl \
    && a2enmod rewrite \
    && sed -ri 's/AllowOverride None/AllowOverride All/g' /etc/apache2/apache2.conf

ARG UID=1000
ARG GID=1000

# подгоняем www-data под хостового юзера, чтобы Apache писал файлы с правильным владельцем
RUN groupmod -g $GID www-data \
    && usermod -u $UID -g $GID www-data
