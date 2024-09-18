# QuestionDescription
What command will most quickly tell you what is contained in an Alpine Linux /etc/hosts file?

## Run instructions
# Checking `/etc/hosts` in Alpine Linux

## Description

To quickly view the contents of the `/etc/hosts` file in an Alpine Linux container, you can use the `cat` command.

## Run Instructions

1. **Start an Alpine Linux Container:**

   ```bash
   docker run -d --name my-alpine alpine sleep 1000
   ```

   This command starts a new Alpine Linux container named `my-alpine` and runs it in the background.

2. **View the Contents of `/etc/hosts`:**

   ```bash
   docker exec my-alpine cat /etc/hosts
   ```

   This command executes `cat /etc/hosts` inside the running container to display the contents of the `/etc/hosts` file.
