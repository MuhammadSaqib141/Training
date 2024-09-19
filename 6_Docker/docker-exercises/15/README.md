# Inspecting Exit Status of Failed Containers

## Description

This guide walks through running several containers, some of which will fail and exit with an error status. You will then use the `docker inspect` command to show the exit status of only the failed containers. Conditional formatting can be used to filter out failed containers.

## Run Instructions

1. **Run the Following Containers:**

   ```bash
   docker run ubuntu date
   docker run ubuntu date1
   docker run ubuntu date2
   docker run ubuntu date
   ```

   - The first and last commands (`date`) will run successfully.
   - The middle two commands (`date1` and `date2`) will fail and exit with an error status because those commands don't exist.

2. **List Exited Containers:**

   You can list all containers that have exited using the following command:

   ```bash
   docker ps -a --filter "status=exited" --format "{{.ID}}"
   ```

   This will list the IDs of all containers that have exited, regardless of their exit status.

3. **Inspect Exit Status of Failed Containers:**

   To show the exit status for specific failed containers, you can use `docker inspect`:

   ```bash
   docker inspect --format '{{.Id}} : {{.State.ExitCode}}' <container_id>
   ```

   For example, to check the exit status of `date1` (which failed):

   ```bash
   docker inspect --format '{{.Id}} : {{.State.ExitCode}}' <container_id_for_date1>
   ```

   Replace `<container_id_for_date1>` with the actual container ID.

