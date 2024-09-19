# Question
How can you tell whether or not the ubuntu:16.4 image is signed for content trust?

# Answer
To determine whether the `ubuntu:16.04` image is signed for content trust, you can use Docker's built-in content trust feature. Docker Content Trust (DCT) allows you to verify the integrity and publisher of Docker images.

### Steps to Check Content Trust:

1. **Enable Content Trust:**
   To check for image signatures, you first need to enable Docker Content Trust by setting the `DOCKER_CONTENT_TRUST` environment variable to `1`:

   ```bash
   export DOCKER_CONTENT_TRUST=1
   ```

2. **Pull the Image:**
   Attempt to pull the `ubuntu:16.04` image:

   ```bash
   docker pull ubuntu:16.04
   ```

3. **Check for Errors:**
   If the image is signed and trusted, the pull will succeed without any issues. If it is not signed, you will receive an error indicating that the image cannot be pulled due to a lack of signature.

### Example Output:

- If the image is signed, you will see a message indicating a successful pull:

  ```
  Using default tag: latest
  latest: Pulling from library/ubuntu
  ...
  Status: Downloaded newer image for ubuntu:16.04
  ```

- If the image is not signed, you might see an error message similar to:

  ```
  Error: remote trust data not available
  ```

### Conclusion:

By enabling Docker Content Trust and attempting to pull the image, you can determine whether the `ubuntu:16.04` image is signed for content trust.
