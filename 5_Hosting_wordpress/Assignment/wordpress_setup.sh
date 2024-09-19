#!/bin/bash

# Variables for database credentials (adjust as needed)
DB_NAME="wordpress"
DB_USER="wordpress"
DB_PASS="<your-password>"

# Path to the WordPress directory
WORDPRESS_DIR="/srv/www/wordpress"

# Check if wp-config-sample.php exists
if [ ! -f "$WORDPRESS_DIR/wp-config-sample.php" ]; then
    echo "Error: wp-config-sample.php not found in $WORDPRESS_DIR."
    exit 1
fi

# Copy the sample configuration file to wp-config.php
echo "Copying wp-config-sample.php to wp-config.php..."
sudo -u www-data cp "$WORDPRESS_DIR/wp-config-sample.php" "$WORDPRESS_DIR/wp-config.php"

# Replace placeholders in wp-config.php with actual database credentials
echo "Configuring wp-config.php with database credentials..."
sudo -u www-data sed -i "s/database_name_here/$DB_NAME/" "$WORDPRESS_DIR/wp-config.php"
sudo -u www-data sed -i "s/username_here/$DB_USER/" "$WORDPRESS_DIR/wp-config.php"
sudo -u www-data sed -i "s/password_here/$DB_PASS/" "$WORDPRESS_DIR/wp-config.php"

# Open the configuration file in nano for any further manual edits
echo "Opening wp-config.php for review..."
sudo -u www-data nano "$WORDPRESS_DIR/wp-config.php"

echo "WordPress configuration completed!"
