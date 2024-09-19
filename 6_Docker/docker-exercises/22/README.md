Here’s the `README.md` that describes how to set up and run Docker containers in a pipeline to modify a string:

---

# Using Docker Containers in a Pipeline

## Description

Did you know that you can include Docker containers in pipelines? In this exercise, we'll demonstrate how to pass the output of one Docker container to another using a pipeline. The goal is to echo the string "change this word to" from one container and pass it to another container that replaces the word "this" with "that" using `sed`.

### Components:

- **Dockerfile-echo:** This container echoes the string "change this word to".
- **Dockerfile-sed:** This container runs `sed` to replace the word "this" with "that".

## Run Instructions

### Step 1: Build the Containers

1. **Build the echo container:**

   ```bash
   docker build -f Dockerfile-echo -t echo-container .
   ```

2. **Build the sed container:**

   ```bash
   docker build -f Dockerfile-sed -t sed-container .
   ```

### Step 2: Run the Containers in a Pipeline

Run the following command to pass the output of the `echo-container` to the `sed-container`:

```bash
docker run --rm echo-container | docker run --rm -i sed-container
```

### Expected Output:

```
change that word to
```

In this pipeline, the output from `echo-container` is piped into `sed-container`, which processes the string and replaces "this" with "that".


