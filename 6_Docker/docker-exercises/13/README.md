# Question
Write a couple of shell scripts that will ping pong back and forth with each other and run them as containers.


## Run instructions

## Shell Scripts Ping Pong Example

This section describes how to write and run shell scripts that ping pong back and forth with each other using Docker containers.

### Shell Scripts

1. **Create `ping.sh` Script**

2. **Create `pong.sh` Script**

### Dockerfiles

1. **Create `Dockerfile.ping`**

2. **Create `Dockerfile.pong`**

### Build and Run Containers

1. **Build Docker Images**

   Build the Docker images using the following commands:

   ```bash
   docker build -f Dockerfile.ping -t ping-image .
   docker build -f Dockerfile.pong -t pong-image .
   ```

2. **Run Containers**

   Start the `ping` container first:

   ```bash
   docker run -d --name ping-container ping-image
   ```

   Then start the `pong` container:

   ```bash
   docker run -d --name pong-container pong-image
   ```
