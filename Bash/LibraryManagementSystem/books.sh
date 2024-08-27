#!/bin/bash

BOOKS_FILE="data/books.txt"

# Generate a unique Book ID
generate_book_id() {
    if [ ! -f "$BOOKS_FILE" ] || [ ! -s "$BOOKS_FILE" ]; then
        echo 1
    else
        last_id=$(tail -n 1 "$BOOKS_FILE" | cut -d':' -f1)
        echo $((last_id + 1))
    fi
}

# Add a new book
add_book() {
    book_id=$(generate_book_id)
    echo "Enter Book Title:"
    read book_title
    echo "Enter Author:"
    read book_author
    echo "$book_id:$book_title:$book_author:available" >> $BOOKS_FILE
    echo "Book added successfully!"
}

# Remove a book
remove_book() {
    echo "Enter Book ID to remove:"
    read book_id
    
    # Check if the book ID exists
    if grep -q "^$book_id:" "$BOOKS_FILE"; then
        sed -i "/^$book_id:/d" "$BOOKS_FILE"
        echo "Book removed successfully!"
    else
        echo "Book ID $book_id not found."
    fi
}


# Update a book's information
update_book() {
    echo "Enter Book ID to update:"
    read book_id
    if grep -q "^$book_id:" "$BOOKS_FILE"; then
        echo "Enter new title:"
        read new_title
        echo "Enter new author:"
        read new_author
        sed -i "s/^$book_id:.*/$book_id:$new_title:$new_author:available/" "$BOOKS_FILE"
        echo "Book information updated successfully!"
    else
        echo "Book not found!"
    fi
}

# Main control flow based on the first command-line argument
case $1 in
    add_book)
        add_book
        ;;
    remove_book)
        remove_book
        ;;
    update_book)
        update_book
        ;;
    *)
        echo "Usage: $0 {add_book|remove_book|update_book}"
        exit 1
        ;;
esac