# Description
Did you know that you can include docker containers in pipelines?

Using a pipeline, echo the string "change this word to" from a docker container into sed in another container and replace "this" with "that".

The echo command looks like this:

    echo "change this word to"

The sed command looks like this:

    sed -n 's/this/that/p'

## Run instructions


docker build -f Dockerfile-echo -t echo-container .
docker build -f Dockerfile-sed -t sed-container .


docker run --rm echo-container | docker run --rm -i sed-container