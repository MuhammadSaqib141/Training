# Dockerized NodeJS Application with MongoDB

## Overview

This project demonstrates how to Dockerize a NodeJS application that connects to a MongoDB database and exposes a ReST API on port 3000. The setup uses Docker Compose to manage multiple containers, including MongoDB, the NodeJS application, and a curl container for testing.

## Directory Structure

```
/project-root
│
├── server.js
├── package.json
├── docker-compose.yml
└── README.md
```

## Services

### MongoDB

- **Service Name:** `mongodb`
- **Image:** `mongo:3`
- **Container Name:** `mongodb`
- **Ports:** `27017:27017`
- **Volumes:** `mongo-data:/data/db`
- **Description:** MongoDB database for the NodeJS application.

### NodeJS Application

- **Service Name:** `nodeapp`
- **Image:** `node:6.9.1`
- **Container Name:** `nodeapp`
- **Ports:** `3000:3000`
- **Depends On:** `mongodb`
- **Volumes:** `.:/usr/src/app`
- **Working Directory:** `/usr/src/app`
- **Environment Variables:** 
  - `MONGO_IP` set to `mongodb`
- **Command:** `npm start`
- **Description:** NodeJS application that connects to MongoDB and exposes a ReST API.

### Curl Test

- **Service Name:** `curltest`
- **Image:** `curlimages/curl:latest`
- **Container Name:** `curltest`
- **Depends On:** `nodeapp`
- **Entry Point:** `/bin/sh`
- **Command:** `-c "sleep 10 && curl http://nodeapp:3000"`
- **Description:** Tests the NodeJS application endpoint by sending a curl request.

## Getting Started

To get started with this project, follow these steps:

1. **Install NodeJS Modules:**

   Ensure you have NodeJS modules installed for the application by running:

   ```bash
   docker run -it --rm -w /work -v $(pwd):/work node:6.9.1 npm install
   ```

   This command mounts the current directory into a NodeJS container and installs the necessary modules as defined in `package.json`.

2. **Start Containers:**

   Run Docker Compose to start all containers:

   ```bash
   docker-compose up
   ```

   This command will start MongoDB, the NodeJS application, and the curl container. It also sets up the necessary network and volumes.

3. **Testing the Application:**

   After the containers are up, the `curltest` container will automatically perform a test by sending a request to the NodeJS application. If everything is working correctly, you should see `Hello World` output from the curl command.

4. **Stopping Containers:**

   To stop and remove the containers, use:

   ```bash
   docker-compose down
   ```

## Customizing

- **NodeJS Application:** Modify `server.js` to adjust the application logic or API endpoints.
- **MongoDB Configuration:** Customize MongoDB settings by adjusting the volume or environment variables as needed.
