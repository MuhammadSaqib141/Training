Here’s the `README.md` that describes why the first Docker command fails and the second one works:

---

# Understanding Docker Container Creation and Entry Points

## Description

This exercise demonstrates the difference between creating Docker containers with and without a defined entry point. When running the following commands, you’ll notice that the first command fails while the second one succeeds.

### Example 1 (Failing Command):

```bash
docker create -v /tmp --name data alpine
```

### Example 2 (Working Command):

```bash
docker create -v /tmp --name data ubuntu:14.04
```

### Explanation:

- **Why does the first one fail?**  
  The `alpine` image does not have a default entry point or command defined in this case. When you try to create the container, Docker doesn’t know what to run and thus throws an error: `Error response from daemon: No command specified`.
  
- **Why does the second one work?**  
  The `ubuntu:14.04` image, on the other hand, has a default command (`/bin/bash`) specified in its Dockerfile, so Docker knows what to run when the container starts, even though it isn't immediately executed during `docker create`.

### Solution:

To fix the first command, you need to provide a default command when creating the Alpine container. For example:

```bash
docker create -v /tmp --name data alpine sh
```

This tells Docker to use `sh` as the entry point for the Alpine container, allowing the container to be created successfully.

