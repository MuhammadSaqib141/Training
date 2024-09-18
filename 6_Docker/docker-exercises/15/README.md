# Description
Run the following containers and note some containers failed and exited with an error status.
Use the `docker inspect` command to show the exit status of only the failed containers.

Did you know that you can include conditionals in format statements? //missing

## Run instructions

    docker run ubuntu date
    docker run ubuntu date1
    docker run ubuntu date2
    docker run ubuntu date


docker ps -a --filter "exited" --format "{{.ID}}"
docker inspect --format '{{.Id}} : {{.State.ExitCode}}' date1