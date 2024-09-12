
### Volumes
- **List volumes**: `docker volume ls`
- **Inspect a volume**: `docker volume inspect <volume-name>`
- **Create a volume**: `docker volume create <volume-name>`
- **Remove a volume**: `docker volume rm <volume-name>`
- **Remove unused volumes**: `docker volume prune`

### Networks
- **List networks**: `docker network ls`
- **Inspect a network**: `docker network inspect <network-name>`
- **Create a network**: `docker network create <network-name>`
- **Remove a network**: `docker network rm <network-name>`
- **Connect a container to a network**: `docker network connect <network-name> <container-id>`
- **Disconnect a container from a network**: `docker network disconnect <network-name> <container-id>`

### Containers
- **Attach to a running container**: `docker attach <container-id>`
- **Start a container**: `docker start <container-id>`
- **Stop a container**: `docker stop <container-id>`
- **Restart a container**: `docker restart <container-id>`
- **Pause a container**: `docker pause <container-id>`
- **Unpause a container**: `docker unpause <container-id>`
- **Exec into a running container**: `docker exec -it <container-id> /bin/bash`
- **Logs from a container**: `docker logs <container-id>`

### Images
- **List images**: `docker images`
- **Remove an image**: `docker rmi <image-id>`
- **Build an image**: `docker build -t <image-name> .`

### System
- **System-wide information**: `docker info`
- **Check Docker daemon logs**: `journalctl -u docker.service`

### Compose (Docker Compose)
- **Build and start containers**: `docker-compose up --build`
- **Start containers in the background**: `docker-compose up -d`
- **Stop and remove containers**: `docker-compose down`
- **View logs**: `docker-compose logs`
- **Build images**: `docker-compose build`