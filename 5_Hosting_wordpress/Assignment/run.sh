#!/bin/bash

# Make sure all the scripts are executable
chmod +x configure_apache_for_wordpress.sh
chmod +x db_setup.sh
chmod +x install_prereq.sh
chmod +x install_wordpress.sh
chmod +x wordpress_setup.sh

# Run the scripts in the correct order

echo "Step 1: Installing prerequisites (Apache, PHP, MySQL)..."
./install_prereq.sh
if [ $? -ne 0 ]; then
    echo "Error: Failed to install prerequisites."
    exit 1
fi

echo "Step 2: Installing WordPress..."
./install_wordpress.sh
if [ $? -ne 0 ]; then
    echo "Error: Failed to install WordPress."
    exit 1
fi

echo "Step 3: Configuring Apache for WordPress..."
./configure_apache_for_wordpress.sh
if [ $? -ne 0 ]; then
    echo "Error: Failed to configure Apache for WordPress."
    exit 1
fi

echo "Step 4: Setting up the MySQL database for WordPress..."
./db_setup.sh
if [ $? -ne 0 ]; then
    echo "Error: Failed to set up MySQL database."
    exit 1
fi

echo "Step 5: Configuring WordPress to connect to the database..."
./wordpress_setup.sh
if [ $? -ne 0 ]; then
    echo "Error: Failed to configure WordPress."
    exit 1
fi

echo "WordPress installation and configuration completed successfully!"
