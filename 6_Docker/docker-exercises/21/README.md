# Creating an Image Using Only the Scratch Base Image

## Description

Can you create an image using only the `scratch` base image? 

The `scratch` image is a special, empty image in Docker, used as a starting point for creating minimal container images. Since it's completely empty, without any operating system or utilities, simply using `FROM scratch` in a `Dockerfile` will not generate a working image unless additional content is added.

## Run Instructions

### Step 1: Create a `Dockerfile`

Create a `Dockerfile` containing the following:

```Dockerfile
FROM scratch
```

This is the simplest possible Dockerfile, starting from the `scratch` base image.

### Step 2: Build the Image

Attempt to build the image using the following command:

```bash
docker build -t scratch-test .
```

### Step 3: Verify the Output

You will notice that no functional image is generated, as `scratch` is empty and no additional instructions are provided to build the image.

- The output will likely indicate that nothing was built.
  
  Example:

  ```
  Successfully built <image-id>
  ```

- The image will have no content, and there won't be a valid filesystem or application to run.
