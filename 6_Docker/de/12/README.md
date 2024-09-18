# Description
How can you quickly and succinctly determine the image id and created date for an Alpine image?

## Run instructions

docker images alpine | awk '{print $3 ": " $4 " " $5}'
