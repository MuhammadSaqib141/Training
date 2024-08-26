#!/bin/bash

logfile='./logfile.log'

while read line; do
	echo "$line"
        echo ""
	echo ""
done < "$logfile"
