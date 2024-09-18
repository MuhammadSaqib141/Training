# Description
What command will most quickly tell you what is contained in an Alpine Linux /etc/hosts file?

## Run instructions
ls or cat

docker run -d --name my-alpine alpine sleep 1000
docker exec my-alpine cat /etc/hosts
