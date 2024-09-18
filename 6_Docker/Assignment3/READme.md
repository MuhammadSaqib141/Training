# Project README

## Overview

This project uses Docker Compose to set up a multi-container application. The setup includes a Flask application, Redis, and Nginx (both static and proxy servers) to serve and manage your application. The architecture is defined using Docker Compose, version 3.8.

## Directory Structure

The project has the following directory structure:

```
/project-root
│
├── flask-app/
│   ├── Dockerfile
│   └── ... (other Flask application files)
│
├── nginx-static/
│   ├── Dockerfile
│   └── ... (static Nginx configuration and content files)
│
├── nginx-proxy/
│   ├── Dockerfile
│   └── ... (proxy Nginx configuration files)
│
├── docker-compose.yml
└── README.md
```

## Services

### Flask App

- **Service Name:** `flask-app`
- **Build Context:** `./flask-app`
- **Dockerfile:** `Dockerfile` in `./flask-app`
- **Description:** Contains the Flask application.

### Redis

- **Service Name:** `redis`
- **Image:** `redis:latest`
- **Description:** A Redis server for caching or other data storage needs.

### Nginx Static

- **Service Name:** `nginx-static`
- **Build Context:** `./nginx-static`
- **Dockerfile:** `Dockerfile` in `./nginx-static`
- **Description:** Nginx server serving static content.

### Nginx Proxy

- **Service Name:** `nginx-proxy`
- **Build Context:** `./nginx-proxy`
- **Dockerfile:** `Dockerfile` in `./nginx-proxy`
- **Ports:** `80:80`
- **Description:** Nginx server acting as a reverse proxy to route traffic.

## Networking

All services are connected to the `app-network` which uses the `bridge` driver. This allows services to communicate with each other within the Docker network.

## Getting Started

To get started with this project, follow these steps:

1. **Clone the Repository:**

   ```bash
   git clone <repository-url>
   cd <repository-directory>
   ```

2. **Build and Start Containers:**

   Ensure you are in the project root directory where `docker-compose.yml` is located, then run:

   ```bash
   docker-compose up --build
   ```

   This will build the Docker images for your services and start the containers.

3. **Accessing Services:**

   - **Flask App:** The Flask application can be accessed through the Nginx proxy at `http://localhost`.
   - **Redis:** Accessible internally within the Docker network.
   - **Nginx Static:** Serves static files, accessible through the Nginx proxy.
   - **Nginx Proxy:** Listens on port `80` and routes requests to the appropriate services.

4. **Stopping Containers:**

   To stop the running containers, use:

   ```bash
   docker-compose down
   ```
