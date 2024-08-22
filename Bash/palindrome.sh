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

read -p "Enter string to check for palindrome: " value

length=${#value}

echo "Length is $length"

reverse

if [ "$value" == "$reverseValue" ]; then
    echo "Palindrome"
else
    echo "Not palindrome"
fi
