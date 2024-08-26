#!/bin/bash

echo "i am going to making tar file"

find ~/test/ -mtime -1 -print | tar cvzf tarall.tar.gz -T -

echo "tar created successfully"
