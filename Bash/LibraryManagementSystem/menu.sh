#!/bin/bash

while true; do
    echo "Library Management System"
    echo "1. Add Book"
    echo "2. Remove Book"
    echo "3. Update Book Information"
    echo "4. View All Books"
    echo "5. Add Student"
    echo "6. Remove Student"
    echo "7. Update Student Information"
    echo "8. View All Students"
    echo "9. Issue Book"
    echo "10. Return Book"
    echo "11. View Issued Books"
    echo "12. Report"
    echo "0. Exit"
    echo "Enter your choice:"
    read choice

    case $choice in
        1) ./books.sh add_book ;;
        2) ./books.sh remove_book ;;
        3) ./books.sh update_book ;;
        4) ./books.sh view_all_books ;;
        5) ./students.sh add_student ;;
        6) ./students.sh remove_student ;;
        7) ./students.sh update_student ;;
        8) ./students.sh view_all_students ;;
        9) ./transactions.sh issue ;;
        10) ./transactions.sh return ;;
        11) ./display.sh view_issued_books ;;
        12) ./display.sh view_students_with_books ;;
        0) exit 0 ;;
        *) echo "Invalid choice, please try again." ;;
    esac
done