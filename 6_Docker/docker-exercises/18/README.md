# Running Docker in a Container with Shared Image Cache

## Description

This guide shows how to run Docker inside a container while sharing the Docker image cache with the host system. By sharing resources like the Docker socket, the container can access the same images as the host, improving efficiency in size and speed.

## Run Instructions

### Step 1: Check Docker Images on the Host

Before running Docker in the container, check the images on your host machine:

```bash
docker images -a
```

This command lists all Docker images on your host system.

### Step 2: Run a Docker Container with Shared Docker Socket

Next, run a shell inside a Docker container while sharing the Docker socket between the host and the container. This allows the container to access the host’s Docker engine and images:

```bash
docker run -it --rm -v /var/run/docker.sock:/var/run/docker.sock docker sh
```

Explanation:
- `-it` starts an interactive shell in the container.
- `--rm` automatically removes the container when it exits.
- `-v /var/run/docker.sock:/var/run/docker.sock` mounts the Docker socket from the host into the container, enabling the container to interact with the host's Docker engine.

### Step 3: Check Docker Images Inside the Container

Once inside the container, check the Docker images:

```bash
docker images -a
```

You should see the same list of Docker images inside the container as you did on the host, demonstrating that the container shares the host’s Docker image cache.

---

This README provides instructions for running Docker inside a container while sharing the image cache with the host, allowing for improved efficiency and access to the host's Docker resources.
