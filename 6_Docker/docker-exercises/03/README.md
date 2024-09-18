# Docker Environment Variable Exercise

## Description

This exercise involves working with Docker environment variables and understanding how to properly use `ARG` and `ENV` in a Dockerfile. The goal is to diagnose an issue with the Dockerfile provided and correct it.

### What Happens When You Run This

You might run the following commands to build and run the Docker image:

```bash
docker build -t testenv1 .
docker run --rm -e ITEM=5 testenv1
```

Here is the provided Dockerfile:

```dockerfile
FROM ubuntu:latest

ARG APP_VERSION=1.0

ENV APP_VERSION=${APP_VERSION}

RUN echo "App version is $APP_VERSION"

CMD ["bash"]
```

### What Is Wrong

The provided Dockerfile has a minor issue with the `ARG` and `ENV` usage:

1. **Misuse of `ARG` and `ENV`:** The `ARG` instruction is used to define a build-time variable, while the `ENV` instruction sets environment variables that are available during runtime. In this Dockerfile, `ARG` is used correctly, but `ENV` is not leveraging the argument properly.

2. **Behavior of `ARG` and `ENV`:** The `ARG` value is only available during the build process. The `ENV` instruction is used to set an environment variable for the container runtime. However, in this setup, the value of `APP_VERSION` will be set to `1.0` because the `ARG` variable isn't used correctly in the `ENV` statement.

### How to Fix It

To ensure the Dockerfile works as intended and the `APP_VERSION` environment variable reflects the build-time value, you should:

1. **Use the `ARG` in `ENV`:** Update the `ENV` instruction to correctly utilize the `ARG` value.

2. **Confirm Correct Output:** Ensure the value of `APP_VERSION` is set properly during both build and runtime.

### Fixed Dockerfile

Here's the corrected Dockerfile:

```dockerfile
FROM ubuntu:latest

# Define the build-time argument
ARG APP_VERSION=1.0

# Set the environment variable to the argument's value
ENV APP_VERSION=$APP_VERSION

# Display the value of the environment variable
RUN echo "App version is $APP_VERSION"

# Default command to run bash
CMD ["bash"]
```

## Build Instructions

1. **Build the Docker Image:**

   Build the Docker image using the following command:

   ```bash
   docker build -t testenv1 .
   ```

   This command will create an image tagged `testenv1` from the Dockerfile in the current directory.

## Run Instructions

2. **Run the Docker Container:**

   Run the Docker container with the following command:

   ```bash
   docker run --rm -e ITEM=5 testenv1
   ```

   This command sets the `ITEM` environment variable but does not affect `APP_VERSION`. The output should display:

   ```
   App version is 1.0
   ```

   The value of `APP_VERSION` is fixed at build time, so the `ITEM` environment variable does not change the output.

