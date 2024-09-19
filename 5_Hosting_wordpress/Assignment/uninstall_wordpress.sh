#!/bin/bash

echo "Starting the uninstallation of WordPress, Apache, MySQL, and PHP..."

# Stop Apache and MySQL services
echo "Stopping Apache and MySQL services..."
sudo systemctl stop apache2
sudo systemctl stop mysql

# Remove Apache2, MySQL, PHP, and related packages
echo "Removing Apache, MySQL, PHP, and related packages..."
sudo apt remove --purge apache2 mysql-server php libapache2-mod-php php-* -y

# Clean up remaining packages and dependencies
echo "Cleaning up unneeded packages and dependencies..."
sudo apt autoremove -y
sudo apt autoclean

# Remove WordPress files
WORDPRESS_DIR="/srv/www/wordpress"
if [ -d "$WORDPRESS_DIR" ]; then
    echo "Removing WordPress files from $WORDPRESS_DIR..."
    sudo rm -rf "$WORDPRESS_DIR"
else
    echo "WordPress files not found at $WORDPRESS_DIR"
fi

# Remove Apache virtual host configuration for WordPress
if [ -f "/etc/apache2/sites-available/wordpress.conf" ]; then
    echo "Removing Apache virtual host configuration for WordPress..."
    sudo a2dissite wordpress
    sudo rm /etc/apache2/sites-available/wordpress.conf
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

# Reload Apache after removing the WordPress site configuration
echo "Reloading Apache..."
sudo systemctl reload apache2

# Remove Apache logs and configuration directories (optional, be careful)
APACHE_LOG_DIR="/var/log/apache2"
APACHE_CONF_DIR="/etc/apache2"
if [ -d "$APACHE_LOG_DIR" ]; then
    echo "Removing Apache log directory..."
    sudo rm -rf "$APACHE_LOG_DIR"
fi

# Optional: You may want to remove MySQL and Apache configurations entirely (be careful with this)
if [ -d "$APACHE_CONF_DIR" ]; then
    echo "Removing Apache configuration directory..."
    sudo rm -rf "$APACHE_CONF_DIR"
fi

# Final message
echo "Uninstallation complete. WordPress, Apache, MySQL, and PHP have been removed from the system."