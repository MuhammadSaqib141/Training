#!/bin/bash

BOOKS_FILE="data/books.txt"
STUDENTS_FILE="data/students.txt"
ISSUED_BOOKS_FILE="data/issued_books.txt"

# View all books
view_all_books() {
    if [ -f "$BOOKS_FILE" ] && [ -s "$BOOKS_FILE" ]; then
        echo "Books in the library:"
        cat "$BOOKS_FILE"
    else
        echo "No books found."
    fi
}

# View all students
view_all_students() {
    if [ -f "$STUDENTS_FILE" ] && [ -s "$STUDENTS_FILE" ]; then
        echo "Students in the system:"
        cat "$STUDENTS_FILE"
    else
        echo "No students found."
    fi
}


# View issued books
view_issued_books() {
    echo "Issued Books:"
    while IFS=: read -r book_id student_id issue_date
    do
        book_info=$(grep "^$book_id:" "$BOOKS_FILE")
        student_info=$(grep "^$student_id:" "$STUDENTS_FILE")
        
        book_title=$(echo "$book_info" | cut -d':' -f2)
        book_author=$(echo "$book_info" | cut -d':' -f3)
        student_name=$(echo "$student_info" | cut -d':' -f2)
        
        echo "Book ID: $book_id | Title: $book_title | Author: $book_author | Issued to: $student_name | Issue Date: $issue_date"
    done < "$ISSUED_BOOKS_FILE"
}

# View students with issued books
view_students_with_books() {
    echo "Students and their issued books:"
    while IFS=: read -r book_id student_id issue_date
    do
        student_info=$(grep "^$student_id:" "$STUDENTS_FILE")
        book_info=$(grep "^$book_id:" "$BOOKS_FILE")
        
        student_name=$(echo "$student_info" | cut -d':' -f2)
        book_title=$(echo "$book_info" | cut -d':' -f2)
        
        echo "Student Name: $student_name | Book Title: $book_title | Issue Date: $issue_date"
    done < "$ISSUED_BOOKS_FILE"
}

# Main control flow based on the first command-line argument
case $1 in
    view_issued_books)
        view_issued_books
        ;;
    view_students_with_books)
        view_students_with_books
        ;;
    view_all_books)
        view_all_books
        ;;
    view_all_students)
        view_all_students
        ;;
    *)
        echo "Usage: $0 {view_all_books|view_issued_books|view_students_with_books}"
        exit 1
        ;;
esac
