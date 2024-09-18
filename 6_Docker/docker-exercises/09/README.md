# QUESTION Description
Run a Fluent container and then run various other containers sending their log output to the Fluent container.


# SOLUTION Fluentd Logging Setup with Docker

## Overview

This guide demonstrates how to set up a Fluentd container to collect and manage log output from various other Docker containers. We use Docker Compose to orchestrate the containers, including Fluentd and two example applications that produce logs.

## Docker Compose Configuration

The provided `docker-compose.yml` file sets up the Fluentd container alongside two example application containers: `http-myapp` and `file-myapp`. Fluentd is configured to read log files from a specified directory and write them to another directory.


## Fluentd Configuration

Fluentd is configured to tail log files and output them to a specified path. The configuration files should be placed in the `./configs` directory.


## Instructions

1. **Prepare Directories and Files:**

   Ensure you have the following directory structure:
   - `./files` for log files from `file-myapp`
   - `./http` for application scripts used by `http-myapp`
   - `./configs` for Fluentd configuration files
   - `./logs` for storing collected logs

   Create a sample log file in `./files` directory for testing:
   
   ```bash
   echo '{"message": "This is a log message"}' > ./files/example-log.log
   ```

2. **Start the Containers:**

   Use Docker Compose to start the containers:
   
   ```bash
   docker-compose up
   ```

3. **Verify Fluentd Operation:**

   - Ensure that Fluentd is running and has started tailing the log files.
   - Check the logs collected by Fluentd in the `./logs` directory.

   For example, view the collected logs:

   ```bash
   cat ./logs/file-myapp.log
   ```

4. **Stop the Containers:**

   To stop and remove the containers, use:

   ```bash
   docker-compose down
   ```
