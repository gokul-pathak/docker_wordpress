# Dockerized Nginx and WordPress Setup

## Overview

This repository provides a Docker Compose configuration and Nginx settings to establish a local development environment. It utilizes Docker for containerization and Nginx as a reverse proxy for WordPress.

## What is Docker?

[Docker](https://www.docker.com/) is a platform for developing, shipping, and running applications in containers. Containers allow you to package an application and its dependencies into a single unit, ensuring consistency across different environments.

## How to Use Docker

1. **Install Docker:**
   - [Docker Installation Guide](https://docs.docker.com/get-docker/)

2. **Install Docker Compose:**
   - [Docker Compose Installation Guide](https://docs.docker.com/compose/install/)

3. **Clone the Repository:**
   ```bash
   git clone https://github.com/your-username/your-repository.git
   cd your-repository
# Dockerized Nginx and WordPress Setup

## `docker-compose.yml`

The `docker-compose.yml` file defines services using Docker Compose. In this setup, it configures three services: Nginx, WordPress, and MySQL.

```yaml
version: '3'

services:
  nginx:
    image: nginx:latest
    ports:
      - "80:80"
    volumes:
      - ./nginx-conf:/etc/nginx/conf.d
    networks:
      - my_network

  wordpress:
    image: wordpress:latest
    environment:
      WORDPRESS_DB_HOST: db
      WORDPRESS_DB_USER: wordpress
      WORDPRESS_DB_PASSWORD: wordpress
      WORDPRESS_DB_NAME: wordpress
    ports:
      - "8080:80"
    depends_on:
      - db
    networks:
      - my_network

  db:
    image: mysql:latest
    environment:
      MYSQL_ROOT_PASSWORD: root
      MYSQL_DATABASE: wordpress
      MYSQL_USER: wordpress
      MYSQL_PASSWORD: wordpress
    networks:
      - my_network

networks:
  my_network:
```

# Nginx Configuration (`nginx.conf`)

The `nginx.conf` file is the Nginx configuration specifying how incoming requests should be handled. It directs traffic to the WordPress service.

```nginx
server {
    listen 80;
    server_name localhost;

    location / {
        proxy_pass http://wordpress:80;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```
# Running on Another Computer

## How to Run

1. **Install Docker and Docker Compose on the target machine.**
2. **Clone the repository:**
   ```bash
   git clone https://github.com/gokul-pathak/docker_wordpress
   cd docker_wordpress
# How it Works

This setup leverages Docker to containerize Nginx, WordPress, and MySQL, providing an isolated and reproducible development environment. Here's a breakdown of how the components interact:

1. **Nginx as Reverse Proxy:**
   - The Nginx service, defined in the `docker-compose.yml` file, acts as a reverse proxy.
   - It listens on port 80 and directs incoming traffic to the WordPress service.

2. **WordPress Service:**
   - The WordPress service is a containerized instance of the WordPress application.
   - It is configured to connect to the MySQL service as its database.

3. **MySQL Database:**
   - The MySQL service provides a containerized MySQL database for the WordPress application.
   - The WordPress service communicates with this MySQL container to store and retrieve data.

4. **Docker Compose:**
   - Docker Compose coordinates the setup, ensuring that all services are configured and run together.
   - The `docker-compose.yml` file defines the services, their configurations, and their dependencies.
<!--
## Running the Setup:

- After cloning the repository, the `.env` file is created to set the MySQL root password.
- Running `docker-compose up -d` launches the containers in the background.
- Nginx directs web traffic to the WordPress container on port 8080.
-->
This containerized setup enhances portability, ease of deployment, and consistency across different environments.

