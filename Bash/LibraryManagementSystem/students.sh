#!/bin/bash

STUDENTS_FILE="data/students.txt"

# Generate a unique Student Roll Number
generate_student_roll_number() {
    if [ ! -f "$STUDENTS_FILE" ] || [ ! -s "$STUDENTS_FILE" ]; then
        echo 1
    else
        last_roll_number=$(tail -n 1 "$STUDENTS_FILE" | cut -d':' -f1)
        echo $((last_roll_number + 1))
    fi
}

# Add a new student
add_student() {
    roll_number=$(generate_student_roll_number)
    echo "Enter Student Name:"
    read student_name
    echo "$roll_number:$student_name" >> "$STUDENTS_FILE"
    echo "Student added successfully with Roll Number $roll_number!"
}

# Remove a student
remove_student() {
    echo "Enter Student Roll Number to remove:"
    read roll_number
    
    # Check if the student roll number exists
    if grep -q "^$roll_number:" "$STUDENTS_FILE"; then
        sed -i "/^$roll_number:/d" "$STUDENTS_FILE"
        echo "Student removed successfully!"
    else
        echo "Student Roll Number $roll_number not found."
    fi
}

# Update a student's information
update_student() {
    echo "Enter Student Roll Number to update:"
    read roll_number
    if grep -q "^$roll_number:" "$STUDENTS_FILE"; then
        echo "Enter new name:"
        read new_name
        sed -i "s/^$roll_number:.*/$roll_number:$new_name/" "$STUDENTS_FILE"
        echo "Student information updated successfully!"
    else
        echo "Student not found!"
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

# Main control flow based on the first command-line argument
case $1 in
    add_student)
        add_student
        ;;
    remove_student)
        remove_student
        ;;
    update_student)
        update_student
        ;;
    view_all_students)
        view_all_students
        ;;
    *)
        echo "Usage: $0 {add_student|remove_student|update_student|view_all_students}"
        exit 1
        ;;
esac
