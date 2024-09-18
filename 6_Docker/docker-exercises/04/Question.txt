# Description

Example of printing the argument array using NodeJS.

When you run this you should get an error.

What is wrong and how do you fix it? 
//by providing server.js  && attaching volume  " docker run -it --rm -v $(pwd)/server.js:/root/server.js --workdir=/root node:6.9.1 node server.js abc"

## Run instructions

    docker run -it --rm --workdir=/root node:6.9.1 node server.js abc 

When you run this you should get the following output

    0: /usr/local/bin/node
    1: /root/server.js
    2: abc

