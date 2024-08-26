#!/bin/bash

user1="root"
user2=$(whoami)

logins_for_user1=$(tail -n 40 /var/log/auth.log | grep 'opened' | grep "$user1" | wc -l)
logins_for_user2=$(tail -n 40 /var/log/auth.log | grep 'opened' | grep "$user2" | wc -l)

if [ "$logins_for_user1" -gt "$logins_for_user2" ]; then
    top_user=$user1
    top_count=$logins_for_user1
elif [ "$logins_for_user2" -gt "$logins_for_user1" ]; then
    top_user=$user2
    top_count=$logins_for_user2
else
    top_user="Both $user1 and $user2"
    top_count="$logins_for_user1 (equal logins)"
fi

echo "In the last 40 lines of /var/log/auth.log:"
echo "most logins:  $top_user "
