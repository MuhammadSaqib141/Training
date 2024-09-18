# Description
Run a Fluent container and then run various other containers sending their log output to the Fluent container.


## Run instructions


docker build -t my-fluentd .
docker run -d --name fluentd -p 24224:24224 my-fluentd
