# Description
How can you quickly and succinctly determine the image id and created date for an Alpine image?

## Run instructions

## 1. Checking `/etc/hosts` in Alpine Linux

### Description

To quickly view the contents of the `/etc/hosts` file in an Alpine Linux container, you can use the `cat` command.

### Run Instructions

1. **Start an Alpine Linux Container:**

   ```bash
   docker run -d --name my-alpine alpine sleep 1000
   ```

   This command starts a new Alpine Linux container named `my-alpine` and runs it in the background.

2. **View the Contents of `/etc/hosts`:**

   ```bash
   docker exec my-alpine cat /etc/hosts
   ```

   This command executes `cat /etc/hosts` inside the running container to display the contents of the `/etc/hosts` file.

## 2. Determining Alpine Image ID and Creation Date

### Description

To quickly and succinctly determine the image ID and creation date for an Alpine image, you can use the `docker images` command along with `awk` to format the output.

### Run Instructions

1. **Get the Image ID and Creation Date:**

   ```bash
   docker images alpine | awk '{print $3 ": " $4 " " $5}'
   ```

   This command lists Docker images filtered by `alpine`, and `awk` extracts and displays the image ID and creation date.
