# Description

If you have a already running container that you need to pass a file to how can you send that file to it?

## Run instructions


docker run -it --name alpine-container alpine:latest /bin/sh
echo "Hello from the host!" > example.txt
docker cp example.txt alpine-container:/root/example.txt

