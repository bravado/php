# prosoma/php

Base Apache and PHP distribution.

Serves files under `APACHE_DOCUMENT_ROOT`.

Mail is sent using `ssmtp`

Available as mod_php or fpm

 * `php:x` Apache + mod_php
 * `php:x-fpm` Apache + php-fpm running as PHP_USER
 * `php:x-dev` Development branches

## Configuration

### Apache Variables

```
ENV APACHE_DOCUMENT_ROOT /var/www/html
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
```

### PHP Variables

```
ENV PHP_MEMORY_LIMIT 128M
ENV PHP_SESSION_SAVE_HANDLER files
ENV PHP_SESSION_SAVE_PATH /var/lib/php5/sessions
ENV PHP_UPLOAD_MAX_FILESIZE 50M
ENV PHP_POST_MAX_SIZE 50M
ENV PHP_SHORT_OPEN_TAG Off
ENV PHP_MAX_INPUT_VARS 1000
ENV PHP_MAX_EXECUTION_TIME 30
ENV APC_SHM_SIZE 128M
```

#### opcache variables

```
ENV OPCACHE_ENABLE 1
ENV OPCACHE_FAST_SHUTDOWN 0
ENV OPCACHE_MEMORY_COMSUPTION 64
ENV OPCACHE_REVALIDATE_PATH 1
ENV OPCACHE_MAX_ACCELERATED_FILES 7963
ENV OPCACHE_INTERNED_STRINGS_BUFFER 4
ENV OPCACHE_VALIDATE_TIMESTAMPS 1
ENV OPCACHE_REVALIDATE_FREQ 15
ENV OPCACHE_SAVE_COMMENTS 1
```

### SMTP server variables

```
ENV SMTP_SERVER mailout
ENV SMTP_USER ""
ENV SMTP_PASS ""
ENV SMTP_METHOD LOGIN
```
