#!/bin/bash


# Define WordPress document root directory
WORDPRESS_DIR="/srv/www/wordpress"

# Ensure the directory exists (you might have already downloaded WordPress)
if [ ! -d "$WORDPRESS_DIR" ]; then
    echo "Directory $WORDPRESS_DIR does not exist. Ensure WordPress is downloaded and extracted here."
    exit 1
fi

# Create Apache configuration file for WordPress
echo "Creating Apache virtual host configuration for WordPress..."
sudo bash -c "cat > /etc/apache2/sites-available/wordpress.conf" <<EOF
<VirtualHost *:80>
    DocumentRoot $WORDPRESS_DIR
    <Directory $WORDPRESS_DIR>
        Options FollowSymLinks
        AllowOverride Limit Options FileInfo
        DirectoryIndex index.php
        Require all granted
    </Directory>
    <Directory $WORDPRESS_DIR/wp-content>
        Options FollowSymLinks
        Require all granted
    </Directory>
</VirtualHost>
EOF

echo "Apache virtual host configuration created at /etc/apache2/sites-available/wordpress.conf"

# Enable the WordPress site
echo "Enabling WordPress site..."
sudo a2ensite wordpress

# Enable mod_rewrite for clean URLs
echo "Enabling Apache URL rewriting..."
sudo a2enmod rewrite

# Disable the default "It Works" site
echo "Disabling the default Apache site..."
sudo a2dissite 000-default

# Reload Apache to apply the changes
echo "Reloading Apache to apply changes..."
sudo service apache2 reload

echo "Apache has been configured for WordPress."
