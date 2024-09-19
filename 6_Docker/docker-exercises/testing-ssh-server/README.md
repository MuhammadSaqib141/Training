# TESTING PURPOSE NOT PART OF ASSIGNMENT
# Setting Up and Testing SSH Servers in Docker Containers (Same Network) 

## Description

This setup includes two Ubuntu containers (`ubuntu1` and `ubuntu2`), each running SSH servers, connected to the **same Docker network** (`shared_network`). The goal is to test SSH connectivity between the containers and from the host machine.

### Docker Compose Configuration

Both services are connected to the same `shared_network` network, enabling seamless communication between them. The updated `docker-compose.yml` reflects this change.

---

## How to Use This Setup

### 1. Create the Docker Compose File

Save the updated configuration to a file named `docker-compose.yml`.

### 2. Start the Containers

Run the following command to start both services:

```bash
docker-compose up -d
```

### 3. Access the SSH Servers

- **Accessing `ubuntu1`:**
  To connect to the SSH server running in `ubuntu1`, use the following command:

  ```bash
  ssh root@localhost -p 2222
  ```

  The password is `root`.

- **Accessing `ubuntu2`:**
  To connect to the SSH server running in `ubuntu2`, use the following command:

  ```bash
  ssh root@localhost -p 2223
  ```

  The password is `root`.

### 4. Testing SSH Connectivity Within the Same Network

Since both containers are on the same network (`shared_network`), they can communicate directly using their container names.

- **Access SSH from `ubuntu1` to `ubuntu2`:**
  
  1. Access `ubuntu1` via an interactive shell:

     ```bash
     docker exec -it ubuntu1 bash
     ```

  2. SSH into `ubuntu2` using its container name:

     ```bash
     ssh root@ubuntu2
     ```

     The password is `root`.

- **Access SSH from `ubuntu2` to `ubuntu1`:**

  Similarly, you can access `ubuntu2` and SSH into `ubuntu1`:

  ```bash
  docker exec -it ubuntu2 bash
  ssh root@ubuntu1
  ```

### 5. Stopping the Containers

To stop and remove the containers and the shared network, run:

```bash
docker-compose down
```

---

### Conclusion

With both containers in the same network, they can communicate directly using container names without needing to expose ports externally. This setup is ideal for scenarios where inter-container communication is needed within the same network.

---

This updated `README.md` reflects the changes made in the network configuration, including instructions for testing the SSH servers within the same network.
