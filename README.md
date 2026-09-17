# Docker Compose Project

## Overview

This project demonstrates a multi-container Docker Compose environment consisting of:

- Nginx
- PHP-FPM (Custom Image)
- MariaDB
- Redis
- Worker

The PHP service uses a custom Docker image based on the official `php:8.3-fpm` image, with multiple PHP extensions compiled and enabled, plus Composer installed.

The custom PHP image is built and published to **GitHub Container Registry (GHCR)**, and `docker-compose.yml` pulls it from there instead of building it locally.

## Architecture

```text
                    Docker Compose
                         |
        +----------------+----------------+
        |                |                |
      Nginx             PHP            MariaDB
        |                |                |
        |                +------->-------+
        |                |
        |                +-------> Redis
        |                            ^
        |                            |
        +------------------------ Worker
```

PHP image: `ghcr.io/zainmajeedch/docker-compose-project:latest`

## Project Structure

```text
docker/
├── app/
├── nginx/
├── worker/
├── Dockerfile
├── docker-compose.yml
└── README.md
```

## Services

### Nginx
- Serves the PHP application.
- Forwards PHP requests to the PHP-FPM container.
- Uses the custom Nginx configuration in `nginx/default.conf`.
- Exposes the application on port `8080`.

### PHP-FPM
- Uses a custom Docker image based on the official `php:8.3-fpm` image.
- Installs and enables additional PHP extensions.
- Composer is installed inside the image.
- The image is published to GitHub Container Registry.
- GHCR image: `ghcr.io/zainmajeedch/docker-compose-project:latest`

### MariaDB
- Database server.
- Uses a persistent Docker volume for database data.

### Redis
- In-memory data store.
- Uses a persistent Docker volume.

### Worker
- Uses the official `php:8.3-cli` image.
- Executes background PHP worker processes.
- Depends on Redis.

## GitHub Container Registry (GHCR)

The custom PHP Docker image is built and published to GitHub Container Registry.

**Image:**
```text
ghcr.io/zainmajeedch/docker-compose-project:latest
```

**Pull the image:**
```bash
docker pull ghcr.io/zainmajeedch/docker-compose-project:latest
```

**Docker login**

The package is currently private, so authentication is required before pulling the image.

```bash
echo 'YOUR_GITHUB_TOKEN' | docker login ghcr.io -u zainmajeedch --password-stdin
```

Use a GitHub Personal Access Token (classic) with `read:packages` scope. Do not commit or expose the token in the repository.

### Publishing Workflow

The custom PHP image was:

1. Built locally using the `Dockerfile`.
2. Tagged with the GHCR image name.
3. Pushed to GitHub Container Registry.
4. Pulled back from GHCR to verify the published image.
5. Referenced in `docker-compose.yml` using the `image:` directive instead of `build:`.

The image is referenced in Docker Compose as:

```yaml
php:
  image: ghcr.io/zainmajeedch/docker-compose-project:latest
```

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

## Dockerfile

The custom PHP image is defined in `Dockerfile`. It:

- Uses `php:8.3-fpm` as the base image.
- Installs required system libraries.
- Compiles and enables PHP extensions.
- Installs the Redis PHP extension using PECL.
- Installs Composer using the official Composer installer.
- Starts PHP-FPM.

### Listing Available PHP Extensions

To list all PHP extensions available in the official `php:8.3-fpm` source tree:

```bash
docker run --rm php:8.3-fpm bash -c '
docker-php-source extract
find /usr/src/php/ext -mindepth 1 -maxdepth 1 -type d -printf "%f\n" | sort
'
```

This command lists all extension source directories included with the official PHP image.

## Run the Project

**1. Pull the PHP image**
```bash
docker pull ghcr.io/zainmajeedch/docker-compose-project:latest
```

**2. Start the containers**
```bash
docker compose up -d
```

**3. Check running containers**
```bash
docker compose ps
```

**4. Access the application**

The application is available at:
```text
http://localhost:8080
```

### Verify Installed PHP Extensions
```bash
docker compose exec php php -m
```

### Verify PHP Version
```bash
docker compose exec php php -v
```

### Verify Composer
```bash
docker compose exec php composer --version
```

## Composer Support

Composer is installed manually inside the custom PHP Docker image using the official Composer installer.

**Features**
- Composer installed in the custom PHP Docker image.
- Dependency management using `composer.json` and `composer.lock`.
- `vendor/` directory generated for project dependencies.
- Example packages installed:
  - `monolog/monolog`
  - `nesbot/carbon`

**Install project dependencies**
```bash
docker compose exec php composer install
```

**List installed packages**
```bash
docker compose exec php composer show
```

## Network

All containers communicate using Docker Compose's default bridge network. Services reach each other using their Compose service names.

For example, Nginx forwards PHP requests to:
```text
php:9000
```

Redis is available to the worker using:
```text
redis
```

## Volumes

The project uses Docker volumes for persistent or shared data:

- `app_data` — shared application data
- `nginx_config` — Nginx configuration
- `mariadb_data` — MariaDB database data
- `redis_data` — Redis data
- `worker_data` — Worker application data

MariaDB and Redis data are stored in persistent Docker volumes.

## Technologies Used

- Docker
- Docker Compose
- GitHub Container Registry (GHCR)
- Nginx
- PHP 8.3 FPM
- MariaDB
- Redis
- Composer

## Author

**Muhammad Zain Majeed**
