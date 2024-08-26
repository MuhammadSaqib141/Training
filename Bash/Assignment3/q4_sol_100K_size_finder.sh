#!/bin/bash

SEARCH_DIR="/home/muhammad"
LOGFILE="/home/muhammad/deleted_files.log"
file_list=$(find "$SEARCH_DIR" -type f -size +100k)
counter=1
declare -a files

echo "Listing files larger than 100K:"
while IFS= read -r file; do
    echo "$counter: $file"
    files[$counter]="$file"
    ((counter++))
done <<< "$file_list"

echo "List completed."

while true; do
    read -p "Enter the number of the file on which you want to perform action (or press 'q' to quit): " file_number

    if [[ "$file_number" == "q" || "$file_number" == "Q" ]]; then
        echo "Exiting."
        exit 0
    fi

    if [[ (( file_number < 1 || file_number >= counter )); then
        echo "Invalid file number provided. No such file."
        continue
    fi

    selected_file="${files[$file_number]}"

    echo "Press 1 to delete the file."
    echo "Press 2 to compress the file."

    read -p "Enter your choice: " option

    case $option in
        1)
            rm "$selected_file"
            echo "Deleted: $selected_file at $(date)" >> "$LOGFILE"
            echo "File deleted."
            ;;
        2)
            gzip -c "$selected_file" > "$selected_file.gz"
            echo "File compressed to $selected_file.gz."
            ;;
        *)
            echo "Invalid choice. Please select 1 to delete, 2 to compress, or 'q' to quit."
            ;;
    esac
done

