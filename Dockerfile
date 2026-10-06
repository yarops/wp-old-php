FROM php:5.6-apache

RUN docker-php-ext-install mysqli pdo pdo_mysql \
    && a2enmod rewrite \
    && sed -ri 's/AllowOverride None/AllowOverride All/g' /etc/apache2/apache2.conf

ARG UID=1000
ARG GID=1000

# подгоняем www-data под хостового юзера, чтобы Apache писал файлы с правильным владельцем
RUN groupmod -g $GID www-data \
    && usermod -u $UID -g $GID www-data
