#!/bin/bash

sudo service mysql start

# Variables for database credentials (you can modify these directly)
DB_NAME="wordpress"
DB_USER="wordpress"
DB_PASS="<your-password>"

# Log in to MySQL as root and create the database and user
echo "Creating MySQL database and user for WordPress..."

sudo mysql -u root <<EOF
-- Create the WordPress database
CREATE DATABASE IF NOT EXISTS $DB_NAME;

-- Create the WordPress user and set the password
CREATE USER IF NOT EXISTS '$DB_USER'@'localhost' IDENTIFIED BY '$DB_PASS';

-- Grant privileges to the WordPress user on the WordPress database
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, ALTER
ON $DB_NAME.*
TO '$DB_USER'@'localhost';

-- Apply the changes
FLUSH PRIVILEGES;

EXIT;
EOF

echo "Database '$DB_NAME' and user '$DB_USER' created successfully!"
