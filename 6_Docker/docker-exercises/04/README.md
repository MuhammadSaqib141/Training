# Node.js Docker Example

This example demonstrates how to print the argument array in a Node.js script using Docker. You will learn how to use Docker to run a Node.js script with arguments and understand common issues and their solutions.

## Description

The goal is to run a Node.js script (`server.js`) that prints the arguments passed to it. When you run the Docker command provided, you should get an error initially, but with the correct setup, you will see the expected output.

### Problem and Solution

The issue arises because the initial Docker command does not properly attach the `server.js` file to the container. To fix this, you need to mount the `server.js` file as a volume in the Docker container.

### `server.js` Example

Create a file named `server.js` with the following content is added in file named "server.js"

This script will print the arguments passed to the Node.js process.

### Docker Command to Run

1. **Initial Command (Will Cause an Error)**

   This command will not work because it does not mount the `server.js` file into the container:

   ```bash
   docker run -it --rm --workdir=/root node:6.9.1 node server.js abc
   ```

   Expected Error: The file `server.js` is not found inside the container.

2. **Correct Command**

   To fix this, you need to mount the `server.js` file into the container and set the working directory to where the file is mounted. Use the following command:

   ```bash
   docker run -it --rm -v $(pwd)/server.js:/root/server.js --workdir=/root node:6.9.1 node server.js abc
   ```

   This command mounts the `server.js` file from your current directory into the `/root` directory in the container and sets `/root` as the working directory. It then runs the `server.js` script with the argument `abc`.

### Expected Output

When you run the corrected Docker command, you should see the following output:

```
0: /usr/local/bin/node
1: /root/server.js
2: abc
```

This output shows the Node.js executable path, the script path, and the argument passed to the script.

## Summary

- **Create** `server.js` with the provided content.
- **Run** the Docker container using the corrected command to mount the file and see the expected output.

