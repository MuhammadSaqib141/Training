#!/bin/bash

temp_dir="/home/muhammad/trash"
mkdir -p "$temp_dir"

for filename in "$@"; do

    if [ -e "$filename" ]; then

            echo "Attempting to compress '$filename'..."

            compressed_file="$filename.gz"

	    gzip -c "$filename" > "$compressed_file"

	    if [ -e "$compressed_file" ]; then

                mv  "$compressed_file" "$temp_dir/"

                echo "Compressed '$filename' and moved to '$temp_dir/'."

            else

                echo "Error: Compression failed for '$filename'."

	    fi

    else

        echo "File '$filename' does not exist."

    fi

done


echo "Cleaning up files older than 48 hours in '$temp_dir'..."


old_files=$(find "$temp_dir" -type f -mtime +2)

if [ -n "$old_files" ]; then
    echo "Deleting the following files:"
    echo "$old_files"
    find "$temp_dir" -type f -mtime +2 -exec rm -f {} \;
    echo "Cleanup complete."
else
    echo "No files older than 48 hours found in '$temp_dir'."
fi
