# Description
in the docker-compose file add a delay before a service starts

## Run instructions
____________________________________________________________________________
version: '3.8'

services:
  web:
    image: nginx:alpine
    container_name: web
    ports:
      - "8080:80"
    depends_on:
      - wait

  wait:
    image: alpine:latest
    container_name: wait
    entrypoint: ["/bin/sh", "-c", "sleep 10 && echo 'Waited 10 seconds'"]
