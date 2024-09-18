#!/bin/bash
IMAGE_NAME="ubuntu"
CONTAINER_NAME="my_single_container"

CONTAINERS=$(docker ps --filter "ancestor=$IMAGE_NAME" -q)

CONTAINER_COUNT=$(echo "$CONTAINERS" | wc -l)

if [ "$CONTAINER_COUNT" -gt 1 ]; then
    echo "More than one container found. Stopping and removing all containers."
    docker rm -f $(echo "$CONTAINERS")
fi

if [ "$CONTAINER_COUNT" -eq 0 ]; then
    echo "No containers running. Starting a new one."
    docker run -d --name $CONTAINER_NAME $IMAGE_NAME sleep infinity
else
    echo "Exactly one container is already running from image '$IMAGE_NAME'."
fi
