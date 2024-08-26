#!/bin/bash

who | awk '{print $1,$4}' | while read name time ; do
    last_login=$(lastlog -u "$name" | awk 'NR==2 {print $4, $5, $6, $7, $8}')
    echo "User: $name"
    echo "Current Login: $time"
    echo "Last Login: $last_login"
done

