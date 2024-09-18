# Dockerfile Image Analysis

## Description

This section provides information on analyzing the Docker image created from a Dockerfile. You will determine the image size, the size of the archive when exported to a tarball, and inspect the contents of the image.

### Steps to Analyze the Docker Image

1. **Build the Docker Image:**

   ```bash
   docker build -t myapp .
   ```

   This command builds the Docker image from the Dockerfile and tags it as `myapp`.

2. **Check the Size of the Docker Image:**

   ```bash
   docker images
   ```

   This command lists all Docker images on your system. Look for the `myapp` image and note the "SIZE" column, which indicates the size of the image.

3. **Export the Docker Image to a Tarball:**

   ```bash
   docker save -o myapp.tar myapp
   ```

   This command exports the Docker image to a tarball named `myapp.tar`.

4. **Check the Size of the Tarball:**

   ```bash
   ls -l myapp.tar
   ```

   This command lists the details of the `myapp.tar` file, including its size.

5. **Inspect the Contents of the Image:**

   To understand what is in the image, you might want to run a container and explore its contents. For example:

   ```bash
   docker run -it --rm myapp /bin/sh
   ```

   This command runs a container from the `myapp` image and opens an interactive shell, allowing you to explore the file system of the image.

### Sample Output
Sample output is present in same directory
