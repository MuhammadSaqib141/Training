#!/bin/bash

declare -A books
declare -A students
declare -A bookings

book_counter=1
student_counter=1

get_id() {
    local type=$1
    if [[ $type == "book" ]]; then
        echo $book_counter
    elif [[ $type == "student" ]]; then
        echo $student_counter
    fi
}

add_book() {
    local book_id=$(get_id "book")
    read -p "Enter book name: " book_name
    if [[ $book_name =~ ^[a-zA-Z]+( [a-zA-Z]+)*$ ]]; then
        books[$book_id]="$book_name"
        bookings[$book_id]="available"
        book_counter=$((book_counter + 1))
        echo "$book_name with the ID $book_id is added."
    else 
        echo "Name is invalid."
    fi
}

add_student() {
    local student_id=$(get_id "student")
    read -p "Enter student name: " student_name
    if [[ $student_name =~ ^[a-zA-Z]+( [a-zA-Z]+)*$ ]]; then
        students[$student_id]=$student_name
        student_counter=$((student_counter + 1))
        echo "$student_name with the ID $student_id is added."
    else
        echo "Name is invalid."
    fi
}

display_books() {
    if [ ${#books[@]} -eq 0 ]; then
        echo "No books available."
    else
        echo ""
        echo "Books in the library:"
        for ((book_id=1; book_id<book_counter; book_id++)); do
                echo "ID: ${book_id}, Name: ${books[$book_id]}"
        done
        echo ""
    fi
}


display_students() {
    if [ ${#students[@]} -gt 0 ]; then
        echo ""
        echo "Students in the library:"
        for ((student_id=1; student_id<student_counter; student_id++)); do
            echo "Student ID: $student_id, Name: ${students[$student_id]}"
        done
        echo ""
    else
        echo "No students available."
    fi
}

issue_book() {

    display_books
    display_students

    read -p "Enter book ID: " book_id
    read -p "Enter student ID: " student_id

    if [[ "${bookings[$book_id]}" == booked*  || -z "${bookings[$book_id]}" ]]; then
        echo "Book not present"
    else
        if [[ -z "${students[$student_id]}" ]]; then
            echo "Invalid student ID."
        else
            bookings[$book_id]="booked by student with ID $student_id"
            echo "Book ${books[$book_id]} reserved successfully by : ${students[$student_id]}." 
            echo ""
            
        fi
    fi
}

get_assigned_book(){
    if [ ${#bookings[@]} -gt 0 ]; then
        echo ""
        echo "Assigned books are :"
        for ((book_id=1; book_id<book_counter; book_id++)); do
            if [[ ${bookings[$book_id]} =~ booked* ]]; then
                echo "ID: ${book_id}, Name: ${books[$book_id]}"
            fi
        done
        echo ""
    else
        echo "No students available."
    fi

}

return_book() {
    echo ""
    echo "Here is report of assigined books and students:"
    get_assigned_book
    read -p "Just enter book ID to get book back: " book_id

    if [[ "${bookings[$book_id]}" == booked* ]]; then
        bookings[$book_id]="available"
        echo "Book ID $book_id is now free."
    else
        echo "Book not present with this Id"
    fi
}

report() {
    if [[ ${#bookings[@]} -gt 0  ]]; then
        echo "Books currently booked:"
        for book_id in "${!bookings[@]}"; do
            if [[ ${bookings[$book_id]} == booked* ]]; then
                local book_name=${books[$book_id]}
                local student_id=$(echo ${bookings[$book_id]} | grep -o '[0-9]*$')
                local student_name=${students[$student_id]}
                echo "Book ID: $book_id, Book Name: $book_name, Student ID: $student_id, Student Name: $student_name"
            fi
        done
    else
        echo "currentlty no book is booked by any student"
    fi
}

while true; do

    echo ""
    echo "--------------------------------"
    echo "Library Management System"
    echo "1. Add Book"
    echo "2. Add Student"
    echo "3. Lend Book"
    echo "4. Return Book"
    echo "5. Report"
    echo "0. Exit"
    echo "--------------------------------"
    read -p  "Enter your choice:" choice
    echo "--------------------------------"

    case $choice in
        1) add_book ;;  
        2) add_student ;;   
        3) issue_book ;;
        4) return_book ;;  
        5) report ;;
        0) exit 0 ;;    
        *) echo "Invalid choice, please try again." ;;
    esac
done