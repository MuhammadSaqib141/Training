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
                echo "Invalid choice. Please select 1 to delete, 2 to compress."
                ;;
        esac
    done
}
