#!/bin/bash

HOST="pong"
PORT=9001

echo "Waiting for 5 seconds before sending Ping..."
sleep 5

echo "Sending Ping to $HOST on port $PORT..."
# echo "Ping" | nc -w 1 $HOST $PORT
# echo "Ping" | nc $HOST $PORT
echo "Ping" | nc -q 0 $HOST $PORT



echo "Waiting for Pong on port 9000..."
nc -l -p 9000
