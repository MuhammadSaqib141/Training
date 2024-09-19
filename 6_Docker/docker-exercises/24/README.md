# Creating the Smallest Data-Only Container

## Description

The goal of this exercise is to create the smallest possible Docker container that is primarily focused on storing data. Using `alpine:latest` as the base image, we can keep the container size minimal while providing a simple directory for data storage.

## Run Instructions

### Step 1: Create a Dockerfile

This Dockerfile in this directory uses `alpine:latest`, one of the smallest Linux distributions, and creates a simple directory for data storage.

### Step 2: Build the Docker Image

Build the image from the Dockerfile with the following command:

```bash
docker build -t my-data-container .
```

### Step 3: Run the Data-Only Container

Run the container with an interactive shell:

```bash
docker run -it --name data-container my-data-container
```

This starts a lightweight Alpine-based container that provides a `/data` directory for storing files or other data as needed. The container runs in interactive mode, allowing you to explore and use the data directory.

### File References:

- **Dockerfile**
