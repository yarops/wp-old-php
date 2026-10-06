# docker-wp-old.local

Docker-окружение под старый WP для dev.

## Стек

- PHP 5.6 (Apache, mod_rewrite, mysqli/pdo_mysql)
- MySQL 5.7
- phpMyAdmin

## Запуск

```bash
docker compose up -d --build
```

- Сайт: http://localhost:8080
- phpMyAdmin: http://localhost:8081
- MySQL снаружи: localhost:3307 (root/root, wordpress/wordpress)

## Структура

- `Dockerfile` — образ PHP, uid/gid `www-data` подогнаны под хостового пользователя (1000:1000), чтоб у скриптов не было проблем с записью.
- `php.ini` — дев-настройки PHP.
- `public_html/` — код сайта.
- `logs/` — логи Apache.
