# Library Management System

This project is a simple Library Management System implemented using Bash scripts. The system allows you to manage books, students, and transactions (issuing and returning books). It is designed to run in a Unix/Linux environment.

## Features

- **Book Management**: Add, update, remove, and view books.
- **Student Management**: Add, update, remove, and view students. Student management is restricted to the root user.
- **Transaction Management**: Issue and return books.
- **Display Options**: View all books, issued books, and students with issued books.
- **Logging**: Track all transactions in a log file.

## File Structure

- `books.sh`: Script to manage books in the library.
- `students.sh`: Script to manage student records (only executable by the root user).
- `transactions.sh`: Script to handle issuing and returning of books.
- `display.sh`: Script to display various data such as books, issued books, and students with issued books.
- `menu.sh`: Main menu script to navigate and interact with the system.
- `data/`: Directory containing data files.
  - `books.txt`: Stores information about the books.
  - `students.txt`: Stores information about the students.
  - `issued_books.txt`: Stores information about issued books.
  - `transactions.log`: Log file for tracking all transactions.

