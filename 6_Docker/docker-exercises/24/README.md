# Description
What is the smallest data only container you can make?


## Run instructions

# Use the smallest base image
FROM alpine:latest

# Create a directory for data
RUN mkdir -p /data

# Set the default command to run when the container starts
CMD ["sh"]


docker build -t my-data-container .
docker run -it --name data-container my-data-container
