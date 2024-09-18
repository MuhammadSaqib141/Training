Here's the updated `README.md` file with additional details, including Docker commands for building and running Dockerfiles where applicable:

---

# Docker Advanced Exercises

This repository contains advanced Docker exercises designed to deepen your understanding of Docker by writing Dockerfiles, working with Docker registries, exploring Docker-in-Docker capabilities, and sharing Docker daemons.

## Exercise 1: Writing Your First Dockerfile

### Task:
Create a Dockerfile using the Alpine base image to install and configure `awscli`. The container should run `awscli` commands and exit. Use the `ENTRYPOINT` directive to provide the `awscli` command.

### Commands:
1. **Build the Docker image:**
   ```bash
   docker build -t my-awscli-image .
   ```

2. **Run the Docker container:**
   ```bash
   docker run --rm my-awscli-image --version
   ```

**Solution:** Dockerfile

---

## Exercise 2: Docker Registry

### Task:
Tag and push the Docker image you built to DockerHub. Make sure to log in to DockerHub first using `docker login`.

### Commands:
1. **Tag the Docker image:**
   ```bash
   docker tag my-awscli-image your-dockerhub-username/my-awscli-image:latest
   ```

2. **Push the Docker image to DockerHub:**
   ```bash
   docker push your-dockerhub-username/my-awscli-image:latest
   ```

**Solution:** [solution2.txt]

---

## Exercise 3: Docker-in-Docker

### Task:
Explore Docker-in-Docker capabilities by following the guide on [Docker-in-Docker by jpetazzo](https://github.com/jpetazzo/dind). After setting it up, test running Docker inside Docker.

### Commands:
1. **Run Docker-in-Docker:**
   ```bash
   docker run --privileged --name dind -d docker:dind
   ```

2. **Test Docker-in-Docker (inside the container):**
   ```bash
   docker exec -it dind docker run hello-world
   ```

**Solution:**  Performed

---

## Exercise 4: Sharing the Docker Daemon

### Task:
Create a Dockerfile based on the Alpine image that installs Docker. When running the container, share the Docker daemon using the `-v` option. This will allow you to start additional containers from within this container.


```

### Commands:
1. **Build the Docker image:**
   ```bash
   docker build -t alpine-docker .
   ```

2. **Run the Docker container sharing the Docker daemon:**
   ```bash
   docker run -it --rm -v /var/run/docker.sock:/var/run/docker.sock alpine-docker
   ```

3. **Run Docker commands inside the container:**
   ```bash
   docker exec -it <container_id> docker run hello-world
   ```

**Solution:** [solution4.txt]
