Here’s a README to guide users through the Docker environment variable exercise. This README will cover how to complete the `Dockerfile`, build the Docker image, and run the container with and without the environment variable.

---

# Environment Variable Exercise

## Description

This exercise demonstrates how to work with environment variables in Docker. You will complete an incomplete `Dockerfile` to correctly use an environment variable and produce different outputs based on whether the environment variable is set or not.

## Objective

Complete the `Dockerfile` to use an environment variable named `myhost`. The Docker image should be configured such that:
- When the `myhost` environment variable is set, the container outputs its value.
- When the `myhost` environment variable is not set, the container outputs a default value.

## Dockerfile

Here is the incomplete `Dockerfile`:

```dockerfile
FROM busybox

# TODO: Add the necessary instructions to use an environment variable
```

To complete the `Dockerfile`, add instructions to set a default value for the `myhost` environment variable and print it.

### Complete Dockerfile

```dockerfile
FROM busybox

# Set a default value for the environment variable
ENV myhost=testhost

# Print the value of the environment variable
RUN echo $myhost
```

## Build Instructions

1. **Build the Docker Image:**

   Run the following command to build the Docker image:

   ```bash
   docker build -t testimage .
   ```

   This command will build the Docker image with the tag `testimage` using the current directory's `Dockerfile`.

## Run Instructions

2. **Run the Docker Container with Environment Variable:**

   To run the container and set the environment variable `myhost`, use the following command:

   ```bash
   docker run -e myhost=host1 testimage
   ```

   This command sets the `myhost` environment variable to `host1`. You should see the output:

   ```
   host1
   ```

3. **Run the Docker Container Without Setting the Environment Variable:**

   To run the container without setting the environment variable, use:

   ```bash
   docker run testimage
   ```

   Without the `myhost` environment variable set, the container should output the default value defined in the `Dockerfile`:

   ```
   testhost
   ```

## Summary

- The `Dockerfile` is configured to use the `myhost` environment variable and defaults to `testhost` if not provided.
- Building and running the Docker container will demonstrate the behavior of environment variables in Docker.

## License

This project is licensed under the [MIT License](LICENSE).

---

Feel free to adjust or expand upon any sections based on additional details or specific instructions for your exercise!
