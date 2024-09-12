#!/bin/bash

echo "i am going to making tar file"

find ~/test/ -mtime -1 -print | tar cvzf tarall1.tar.gz  -

echo "tar created successfully"
