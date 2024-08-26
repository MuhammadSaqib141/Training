#!/bin/bash

temp_dir="/home/muhammad/trash"
mkdir -p "$temp_dir"

for filename in "$@"; do

    if [ -e "$filename" ]; then

            echo "Attempting to compress '$filename'..."

            compressed_file="$filename.gz"

	    gzip -c "$filename" > "$compressed_file"

	    if [ -e "$compressed_file" ]; then

                echo "$compressed_file" "$temp_dir/"

                echo "Compressed '$filename' and moved to '$temp_dir/'."

            else

                echo "Error: Compression failed for '$filename'."

	    fi

    else

        echo "File '$filename' does not exist."

    fi

done
