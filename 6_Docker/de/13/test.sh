#!/bin/bash

PORT=9000
HOST=localhost

receive_and_respond() {
    echo "Listening on port $PORT..."
    REQUEST=$(nc -l -p $PORT)
    echo "Received: $REQUEST"
    if [ "$REQUEST" == "PING" ]; then
        echo "PONG" | nc $HOST $PORT
        echo "Sent: PONG"
    fi
}

# Function to send a message and wait for a response
send_and_receive() {
    echo "PING" | timeout 1 nc $HOST $PORT
    echo "Sent: PING"

    RESPONSE=$(timeout 1 nc -l -p $PORT)
    echo "Received: $RESPONSE"
}

# Start listening and responding in the background
receive_and_respond &

# Give the listener some time to start
sleep 1

# Send a message and receive the response
send_and_receive
