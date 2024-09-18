# Description

We want to prevent a container from being able to fork other processes/services in the same container.

What ways can you think of to do this?

# Answer

docker run --rm -it --pids-limit=5 ubuntu bash
sleep && 

cat /sys/fs/cgroup/pids/pids.max //check number of process allowed

docker run --security-opt seccomp=/path/to/seccomp-profile.json <image>

sudo journalctl -u docker.service --since "10 minutes ago"
