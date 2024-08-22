#!/bin/bash

reverseValue=""
value=""
length=0

reverse() {
    reverseValue=""
    for ((i=length-1; i>=0; i--)); do
        reverseValue+="${value:$i:1}"
    done
}

isvalid() {
    if [ "$length" -gt 1 ]; then
        return 0  # Valid input
    else
        return 1  # Invalid input
    fi
}

while true; do
    read -p "Enter string to check for palindrome: " value
    length=${#value}  # Update length after new input

    if isvalid; then
        break
    else
        echo " Please enter again valid input."
    fi
done

echo "Length is $length"

reverse

if [ "$value" == "$reverseValue" ]; then
    echo "Palindrome"
else
    echo "Not palindrome"
fi
