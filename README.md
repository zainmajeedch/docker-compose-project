# Docker Compose Project

## Overview

This project demonstrates a multi-container Docker Compose environment consisting of:

- Nginx
- PHP-FPM
- MariaDB
- Redis
- Worker

## Project Structure

docker/
├── app/
├── nginx/
├── worker/
└── docker-compose.yml

## Services

- Nginx
- PHP-FPM
- MariaDB
- Redis
- Worker

## Network

All containers communicate using Docker Compose's default bridge network.

## Volume

MariaDB uses a persistent Docker volume to store database data.

## Technologies Used

- Docker
- Docker Compose
- Nginx
- PHP
- MariaDB
- Redis

## Author

Muhammad Zain Majeed
