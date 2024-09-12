
### Services

- **flask-app**: A simple Python Flask application that increments a counter in Redis.
- **redis**: A Redis database used by the Flask app.
- **nginx-proxy**: Nginx configured as a reverse proxy that forwards requests to the Flask app.
- **static-nginx**: Nginx configured to serve static content.

## Steps to Run the Application

### 1. Build and Start Services

Make sure Docker and Docker Compose are installed on your machine. Run the following command to build and start the services:

```bash
docker-compose up --build

**Directory Struture:**

├── docker-compose.yml
├── flask-app
│   ├── app.py
│   └── Dockerfile
├── nginx
│   ├── nginx.conf
│   └── Dockerfile
├── static-nginx
│   └── Dockerfile
└── README.md




