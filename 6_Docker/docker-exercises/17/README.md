# Exploring Docker Containers via Tar Archives

## Description

Docker containers can be exported to a tar archive, allowing you to examine their layers and metadata files. Exported containers differ slightly from images that have been saved as an archive, providing a unique view of the container's file system.

In this exercise, we will run an Alpine container with an environment variable `tmpvar` set to `test`, export that container to an archive, and then extract and inspect the contents.

## Run Instructions

### Step 1: Run an Alpine Container with an Environment Variable

Start an Alpine container in the background (`-d` flag) with an environment variable (`-e tmpvar=test`):

```bash
docker run -d --name alpine_test -e tmpvar=test alpine sleep 3600
```

### Step 2: Export the Running Container to a Tar Archive

Export the running container to a tar archive called `alpine_container.tar`:

```bash
docker export alpine_test -o alpine_container.tar
```

### Step 3: List the Contents of the Archive

You can list the files and structure inside the tar archive using the `tar` command:

```bash
tar tvf alpine_container.tar
```

### Step 4: Extract the Contents of the Archive

To fully inspect the contents, extract the archive:

```bash
tar xvf alpine_container.tar
```

### Observation:

- Compare the contents of the exported container to that of a saved image (as seen in previous exercises). 
- You should see differences in the file structure and metadata, as exported containers focus on the container's filesystem, while saved images include more image-related metadata and layers.
