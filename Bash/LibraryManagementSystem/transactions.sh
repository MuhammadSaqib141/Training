#!/bin/bash

BOOKS_FILE="data/books.txt"
ISSUED_BOOKS_FILE="data/issued_books.txt"
LOG_FILE="data/transactions.log"

# Issue a book to a student
issue_book() {
    echo "Enter Book ID:"
    read book_id
    echo "Enter Student ID:"
    read student_id
    
    if grep -q "^$book_id:.*:available$" $BOOKS_FILE; then
        sed -i "s/^$book_id:.*/&:issued:$student_id/" $BOOKS_FILE
        echo "$book_id:$student_id:$(date)" >> $ISSUED_BOOKS_FILE
        log_transaction "Issued Book ID $book_id to Student ID $student_id"
        echo "Book issued successfully!"
    else
        echo "Book is not available!"
    fi
}

# Return a book
return_book() {
    echo "Enter Book ID:"
    read book_id
    grep -q "^$book_id:.*:issued:" $BOOKS_FILE
    if [ $? -eq 0 ]; then
        sed -i "s/^$book_id:.*:issued:.*$/$book_id:available/" $BOOKS_FILE
        sed -i "/^$book_id:/d" $ISSUED_BOOKS_FILE
        log_transaction "Returned Book ID $book_id"
        echo "Book returned successfully!"
    else
        echo "This book was not issued!"
    fi
}

# Log a transaction
log_transaction() {
    echo "$(date) - $1" >> $LOG_FILE
}

# Main case statement to handle input arguments
case $1 in
    issue)
        issue_book
        ;;
    return)
        return_book
        ;;
    *)
        echo "Usage: $0 {issue|return}"
        exit 1
        ;;
esac
