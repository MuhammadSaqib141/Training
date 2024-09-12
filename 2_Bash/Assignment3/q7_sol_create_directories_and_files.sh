#!/bin/bash

if [ -z "$1" ] || [ -z "$2" ]; then
    echo "plz procide complete args"
    exit 1
fi

if ! [[ "$1" =~ ^[0-9]+$ ]] || ! [[ "$2" =~ ^[0-9]+$ ]]; then
    echo "positive integers chahiye hain"
    exit 1
fi

I=$1
J=$2
FILE=$3


if [ -n "$FILE" ]; then
	if [ ! -f "$FILE" ]; then
        echo " $FILE does not exist."
        exit 1
    fi
fi

echo "$I and $J"

for ((i=1; i<=I; i++)); do
    dir_name="dir_$i"
    mkdir "$dir_name"
    cd "$dir_name" 

    for ((j=1; j<=J; j++)); do
        file_name="$j.txt"
        if [ -n "$FILE" ]; then
            if [ -e "$file_name" ]; then
                echo "$file_name already exists in $dir_name."
                cd .. 
                exit 1
            else
                cp "$FILE" "$file_name"
            fi
        else
            if [ -e "$file_name" ]; then
                echo " $file_name already exists in $dir_name."
                cd .. 
                exit 1
            else
                touch "$file_name"
            fi
        fi
    done

    cd .. 
done

echo "Directories and files created successfully."
