# Docker Nginx Reverse Proxy Demo

This project demonstrates how to use Docker Compose to deploy a PHP application with Nginx, MariaDB, Redis, and worker containers, then place another standalone Nginx container in front of it as a reverse proxy.

## Project Structure

```
.
├── app
│   └── index.php
├── docker-compose.yml
├── nginx
│   └── default.conf
├── reverse-proxy
│   └── default.conf
├── worker
│   └── worker.php
└── README.md
```

---

## Services

| Service | Description |
|----------|-------------|
| Nginx | Main web server serving the PHP application |
| PHP-FPM | Executes PHP scripts |
| MariaDB | Database server |
| Redis | In-memory cache |
| Worker 1 | Background worker |
| Worker 2 | Background worker |
| Reverse Proxy | Standalone Nginx container forwarding requests to the main Nginx |

---

## Architecture

```
                           Browser
                              |
          +-------------------+-------------------+
          |                                       |
          | http://eclixtech.local:8080           |
          |                                       |
          v                                       |
    +----------------+                            |
    | Main Nginx     |<---------------------------+
    +----------------+                            |
            |                                    |
            v                                    |
       +-----------+                             |
       | PHP-FPM   |                             |
       +-----------+                             |
                                                 |
                                                 |
          http://eclixtech.local:8081            |
                      |                          |
                      v                          |
          +-----------------------+             |
          | Reverse Proxy Nginx   |-------------+
          +-----------------------+
                    |
                    | proxy_pass
                    v
              Main Nginx
```

---

## Prerequisites

- Docker
- Docker Compose
- Git

---

## Start the Compose Services

```bash
docker compose up -d
```

Verify:

```bash
docker ps
```

---

## Run the Reverse Proxy

Create the standalone reverse proxy container:

```bash
docker run -d \
  --name reverse-proxy \
  --network docker_default \
  -p 8081:80 \
  -v $(pwd)/reverse-proxy/default.conf:/etc/nginx/conf.d/default.conf:ro \
  nginx:latest
```

---

## Configure Local Domain

Edit the hosts file:

Linux:

```bash
sudo nano /etc/hosts
```

Add:

```
127.0.0.1 eclixtech.local
```

---

## Testing

### Access the application directly

```
http://eclixtech.local:8080
```

Expected:

- Main Nginx
- PHP Application

---

### Access through the Reverse Proxy

```
http://eclixtech.local:8081
```

Expected:

- Reverse Proxy Nginx
- Request forwarded to Main Nginx
- Same PHP application displayed

---

## Reverse Proxy Configuration

```nginx
server {
    listen 80;

    server_name eclixtech.local;

    location / {
        proxy_pass http://nginx:80;

        proxy_set_header Host $http_host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

---

## Verify Reverse Proxy

Direct access:

```bash
curl http://eclixtech.local:8080
```

Reverse proxy:

```bash
curl http://eclixtech.local:8081
```

Both requests should return the same PHP application.

---

## Repository

This project demonstrates:

- Docker Compose
- Docker Networking
- Standalone Docker Containers
- Nginx Reverse Proxy
- PHP-FPM
- MariaDB
- Redis
- Multiple Worker Containers
