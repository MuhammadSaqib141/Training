#!/bin/bash

SEARCH_DIR="/home/muhammad"
LOGFILE="/home/muhammad/deleted_files.log"
declare -a files

# Function to find and list files larger than 100K
list_files() {
    file_list=$(find "$SEARCH_DIR" -type f -size +100k)
    counter=1

    echo "Listing files larger than 100K:"
    while IFS= read -r file; do
        echo "$counter: $file"
        files[$counter]="$file"
        ((counter++))
    done <<< "$file_list"

    echo "List completed."
}

# Function to delete a selected file
delete_file() {
    local selected_file="$1"
    rm "$selected_file"
    echo "Deleted: $selected_file at $(date)" >> "$LOGFILE"
    echo "File deleted."
}

# Function to compress a selected file
compress_file() {
    local selected_file="$1"
    gzip -c "$selected_file" > "$selected_file.gz"
    echo "File compressed to $selected_file.gz."
}

# Main loop for user interaction
main_loop() {
    while true; do
        read -p "Enter the number of the file on which you want to perform action (or press 'q' to quit): " file_number

        if [[ "$file_number" == "q" || "$file_number" == "Q" ]]; then
            echo "Exiting."
            exit 0
        fi

        if [[ ! "$file_number" =~ ^[0-9]+$ ]] || (( file_number < 1 || file_number >= counter )); then
            echo "Invalid file number provided. No such file."
            continue
        fi

        selected_file="${files[$file_number]}"

        echo "Press 1 to delete the file."
        echo "Press 2 to compress the file."

        read -p "Enter your choice: " option

        case $option in
            1)
                delete_file "$selected_file"
                ;;
            2)
                compress_file "$selected_file"
                ;;
            *)
                echo "Invalid choice. Please select 1 to delete, 2 to compress, or 'q' to quit."
                ;;
        esac
    done
}

# Execute the functions
list_files
main_loop
