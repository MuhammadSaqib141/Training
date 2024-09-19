# Enforcing a Single Instance of a Docker Container

## Description

To ensure that only a single instance of a specific container runs on a host, we can utilize both a bash script and a Docker Compose file. This approach prevents multiple instances from running, regardless of the arguments used to run the container.

### Method 1: Using a Bash Script

The following script checks for existing instances of a specified container and either starts a new one or removes any existing instances if there are more than one.

#### Script: `script.sh`


### How to Use the Script

1. Save the script to a file named `script.sh`.
2. Make the script executable:

   ```bash
   chmod +x script.sh
   ```

3. Run the script:

   ```bash
   ./script.sh
   ```

### Method 2: Using Docker Compose

While Docker Compose is typically used for multi-container setups, you can define the desired state of your service using replicas. However, Docker Compose itself does not enforce a strict single instance at the application level. To illustrate the concept, here's a basic example:

#### Docker Compose File: `docker-compose.yml`

### How to Use the Docker Compose File

1. Save the content to a file named `docker-compose.yml`.
2. Run the following command to start the services:

   ```bash
   docker-compose up
   ```

### Conclusion

By using the provided bash script, you can enforce a single instance of a container regardless of the run arguments. The Docker Compose file offers a way to define the desired state of your services but may require additional checks to enforce a single instance strictly.
