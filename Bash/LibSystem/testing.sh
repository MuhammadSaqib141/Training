#!/bin/bash

read -p "enter your name: " name

if [[ $name =~ ^[a-zA-Z]+[a-zA-Z\ ]*[a-zA-Z]+$ ]]; then
    echo "name is ok"
else
    echo "invalid input"
fi

