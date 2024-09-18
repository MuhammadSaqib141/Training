# # Use the Alpine base image
# FROM alpine:latest

# # Install Docker CLI
# RUN apk add --no-cache docker-cli

# # Set the entrypoint to a shell (you can modify this based on your needs)
# ENTRYPOINT ["/bin/sh"]



FROM alpine:latest
RUN apk add --no-cache aws-cli
ENTRYPOINT ["aws"]
CMD ["--version"]
