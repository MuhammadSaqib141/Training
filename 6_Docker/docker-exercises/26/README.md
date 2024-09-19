# Using Docker Events to Check Recent Container Activity

## Description

To determine what containers ran in the last 20 minutes, you can utilize the `docker events` command. This command provides a live stream of events occurring in the Docker daemon, allowing you to see what containers have started or exited recently.

### Using Docker Events

You can use the following command to listen to Docker events and filter for relevant activities:

```bash
docker events --since 20m
```

### Explanation:

- **`docker events`:** This command outputs a stream of events that have occurred in the Docker environment.
- **`--since 20m`:** This option filters the events to show only those that have occurred in the last 20 minutes.

### Steps to Determine Recent Activity:

1. Run the command above in your terminal to monitor events from the last 20 minutes.
2. Look for events related to container creation and termination to identify which containers ran during that time.

This method provides a more dynamic view of container activities, allowing you to track real-time events as they happen.

---

This README now highlights the use of `docker events` as a better approach to monitoring container activity over the last 20 minutes.

