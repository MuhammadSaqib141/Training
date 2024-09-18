# Description
What size image does this Dockerfile create?
What size of archive does it create if you export it to a tarball?
What else is in the image that was built?

## Run instructions


docker build -t myapp .
docker images 
docker save -o myapp.tar myapp
ls -l myapp.tar
