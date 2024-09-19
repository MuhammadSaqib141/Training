#!/bin/bash

echo "Starting the uninstallation of WordPress and related components..."

# Stop Apache service
echo "Stopping Apache service..."
sudo systemctl stop apache2

# Remove Apache configuration for WordPress
if [ -f "/etc/apache2/sites-available/wordpress.conf" ]; then
    echo "Removing Apache virtual host configuration for WordPress..."
    sudo a2dissite wordpress
    sudo rm /etc/apache2/sites-available/wordpress.conf
fi

# Reload Apache to apply changes
echo "Reloading Apache..."
sudo systemctl reload apache2

# Remove WordPress files
WORDPRESS_DIR="/srv/www/wordpress"
if [ -d "$WORDPRESS_DIR" ]; then
    echo "Removing WordPress files from $WORDPRESS_DIR..."
    sudo rm -rf "$WORDPRESS_DIR"
else
    echo "WordPress files not found at $WORDPRESS_DIR."
fi

# Remove MySQL database and user for WordPress
echo "Removing MySQL database and user for WordPress..."
DB_NAME="wordpress"
DB_USER="wordpress"
sudo mysql -u root <<EOF
DROP DATABASE IF EXISTS $DB_NAME;
DROP USER IF EXISTS '$DB_USER'@'localhost';
FLUSH PRIVILEGES;
EXIT;
EOF

# Optionally remove PHP packages related to WordPress (if needed)
echo "Removing PHP packages..."
sudo apt remove --purge php-* -y

# Clean up remaining packages and dependencies
echo "Cleaning up unneeded packages and dependencies..."
sudo apt autoremove -y
sudo apt autoclean

# Final message
echo "Uninstallation complete. WordPress and related components have been removed."