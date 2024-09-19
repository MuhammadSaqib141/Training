Here’s the `README.md` that describes how to prevent a Docker container from forking other processes:

---

# Preventing a Docker Container from Forking Processes

## Description

To restrict a container from being able to fork other processes or services, there are several methods that can be employed. This can enhance security and resource management in containerized environments.

### Methods to Prevent Forking

#### 1. Using PID Limits

You can limit the number of processes that can be created within a container by setting a PID limit. This can be done using the `--pids-limit` option when running the container.

```bash
docker run --rm -it --pids-limit=5 ubuntu bash //implemented successfully
```

After starting the container, you can check the maximum number of processes allowed by examining the relevant cgroup file:

```bash
cat /sys/fs/cgroup/pids/pids.max  # Check the number of processes allowed
```

#### 2. Using Seccomp Profiles

Another way to restrict process forking is to use a custom Seccomp profile. Seccomp (Secure Computing Mode) allows you to filter system calls that a container can make. By specifying a Seccomp profile that restricts forking-related system calls (like `clone`, `fork`, `vfork`), you can effectively prevent the container from forking new processes.

To run a container with a custom Seccomp profile, use the following command:

```bash
docker run --security-opt seccomp=/path/to/seccomp-profile.json <image> // i tried but failed to implement
```

You will need to create a Seccomp profile that denies the necessary syscalls for forking.

#### 3. Monitoring Docker Events

To monitor the activity of your Docker containers and see if there are any unauthorized forking attempts, you can check the Docker service logs:

```bash
sudo journalctl -u docker.service --since "10 minutes ago"
```

### Conclusion

By utilizing PID limits and custom Seccomp profiles, you can effectively prevent a Docker container from forking other processes, enhancing the security and stability of your containerized applications.
