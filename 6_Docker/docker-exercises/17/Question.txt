# Description
Docker containers can be interesting to look around in.
You can save containers to a tar archive and then extract the layers and metadata files from them.
Note that exported containers look a little different from images that have been saved to an archive.

## Run instructions

Run an alpine container with an environment variable called tmpvar set to test.
Export that alpine container to an archive, extract the contents of the archive.
Do you see the same metadata files from the previous exercise?


____________________________________________________________________

docker run -d --name alpine_test -e tmpvar=test alpine sleep 3600
docker export alpine_test -o alpine_container.tar
tar tvf alpine_container.tar
tar xvf alpine_container.tar
________________________________________________________

