#!/bin/bash

# Configuration
HOST="ping"
PORT=9000

while true; do
    echo "Listening on port 9001 for Ping..."
    nc -l -p 9001 > /tmp/message.txt

    echo "Received message: $(cat /tmp/message.txt)"

    #sleep 1

    echo "Sending Pong to $HOST on port $PORT..."
    echo "Pong" | nc $HOST $PORT
done
