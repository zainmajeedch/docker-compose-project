# Docker Compose Project

## Overview

This project demonstrates a multi-container Docker Compose environment consisting of:

- Nginx
- PHP-FPM (Custom Image)
- MariaDB
- Redis
- Worker

The PHP service uses a custom Docker image built from the official `php:8.3-fpm` image with multiple PHP extensions compiled and enabled.

## Project Structure

```text
docker/
├── app/
├── nginx/
├── worker/
├── Dockerfile
└── docker-compose.yml
```

## Services

### Nginx
- Serves the PHP application.
- Forwards PHP requests to the PHP-FPM container.

### PHP-FPM
- Built from the official `php:8.3-fpm` image.
- Uses a custom `Dockerfile`.
- Installs and enables additional PHP extensions.

### MariaDB
- Database server.

### Redis
- In-memory data store.

### Worker
- Executes background PHP worker processes.

## Installed PHP Extensions

The custom Docker image installs and enables the following extensions:

- bcmath
- bz2
- calendar
- enchant
- exif
- ftp
- gd
- gettext
- gmp
- intl
- ldap
- mysqli
- opcache
- pcntl
- pdo_mysql
- pdo_pgsql
- pgsql
- pspell
- redis (PECL)
- shmop
- snmp
- soap
- sockets
- sysvmsg
- sysvsem
- sysvshm
- tidy
- xsl
- zip

## Listing Available PHP Extensions

To list all PHP extensions available in the official `php:8.3-fpm` source tree:

```bash
docker run --rm php:8.3-fpm bash -c '
docker-php-source extract
find /usr/src/php/ext -mindepth 1 -maxdepth 1 -type d -printf "%f\n" | sort
'
```

This command lists all extension source directories included with the official PHP image.

## Build

```bash
docker compose build
```

## Run

```bash
docker compose up -d
```

## Verify Installed Extensions

```bash
docker compose exec php php -m
```

## Network

All containers communicate using Docker Compose's default bridge network.

## Volume

MariaDB stores its data in a persistent Docker volume.

## Technologies Used

- Docker
- Docker Compose
- Nginx
- PHP 8.3 FPM
- MariaDB
- Redis

## Author

**Muhammad Zain Majeed**
