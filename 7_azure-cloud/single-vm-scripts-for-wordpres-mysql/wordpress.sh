#!/bin/bash

DB_NAME='wordpress_db'
DB_USER='wordpress_user'
DB_PASSWORD='Saqib@1122' 
WP_DIR='/srv/www'

install_packages() {
    echo "Updating package list..."
    sudo apt update -y
    echo "Installing necessary packages..."
    sudo apt install -y apache2 \
                    ghostscript \
                    libapache2-mod-php \
                    mysql-server \
                    php \
                    php-bcmath \
                    php-curl \
                    php-imagick \
                    php-intl \
                    php-json \
                    php-mbstring \
                    php-mysql \
                    php-xml \
                    php-zip
}

start_mysql() {
    if ! systemctl is-active --quiet mysql; then
        echo "Starting MySQL service..."
        sudo systemctl start mysql
    else
        echo "MySQL service is already running."
    fi
}

create_database_and_user() {
    echo "Creating MySQL database and user..."
    sudo mysql <<EOF
CREATE DATABASE IF NOT EXISTS $DB_NAME;
CREATE USER IF NOT EXISTS '$DB_USER'@'localhost' IDENTIFIED BY '$DB_PASSWORD';
GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EOF
}

install_wordpress() {
    echo "Starting WordPress installation..."
    sudo mkdir -p $WP_DIR
    sudo chown www-data: $WP_DIR
    curl -s https://wordpress.org/latest.tar.gz | sudo -u www-data tar zx -C $WP_DIR
}

configure_wp_config() {
    echo "Configuring WordPress settings..."
    sudo -u www-data cp $WP_DIR/wordpress/wp-config-sample.php $WP_DIR/wordpress/wp-config.php
    sudo sed -i "s/database_name_here/$DB_NAME/" $WP_DIR/wordpress/wp-config.php
    sudo sed -i "s/username_here/$DB_USER/" $WP_DIR/wordpress/wp-config.php
    sudo sed -i "s/password_here/$DB_PASSWORD/" $WP_DIR/wordpress/wp-config.php
}

set_permissions() {
    echo "Setting permissions for WordPress directory..."
    sudo chown -R www-data:www-data $WP_DIR
    sudo chmod -R 755 $WP_DIR
}

configure_apache() {
    echo "Configuring Apache for WordPress..."
    if [ ! -f /etc/apache2/sites-available/wordpress.conf ]; then
        echo "<VirtualHost *:80>
    DocumentRoot $WP_DIR/wordpress
    <Directory $WP_DIR/wordpress>
        Options FollowSymLinks
        AllowOverride Limit Options FileInfo
        DirectoryIndex index.php
        Require all granted
    </Directory>
    <Directory $WP_DIR/wordpress/wp-content>
        Options FollowSymLinks
        Require all granted
    </Directory>
</VirtualHost>" | sudo tee /etc/apache2/sites-available/wordpress.conf
    fi

    sudo a2ensite wordpress.conf
    sudo a2enmod rewrite
    sudo a2dissite 000-default
}

restart_apache() {
    echo "Restarting Apache service..."
    sudo systemctl restart apache2
}

# Merged installation function
install_wordpress_full() {
    install_packages
    start_mysql
    create_database_and_user
    install_wordpress
    configure_wp_config  
    set_permissions
    configure_apache
    restart_apache

    echo "WordPress has been installed successfully!"
}

uninstall_wordpress() {
    echo "Starting WordPress uninstallation..."

    if [ -d "$WP_DIR" ]; then
        sudo rm -rf $WP_DIR
    else
        echo "WordPress directory does not exist. Skipping removal."
    fi

    sudo mysql <<EOF
DROP DATABASE IF EXISTS $DB_NAME;
DROP USER IF EXISTS '$DB_USER'@'localhost';
EOF

    if [ -f /etc/apache2/sites-available/wordpress.conf ]; then
        sudo a2dissite wordpress.conf
        sudo rm -f /etc/apache2/sites-available/wordpress.conf
    else
        echo "Apache site configuration does not exist. Skipping removal."
    fi

    sudo systemctl restart apache2

    packages=(
        apache2
        ghostscript
        libapache2-mod-php
        mysql-server
        php
        php-bcmath
        php-curl
        php-imagick
        php-intl
        php-json
        php-mbstring
        php-mysql
        php-xml
        php-zip
    )

    # Uninstalling the packages
    for package in "${packages[@]}"; do
        if dpkg -l | grep -q $package; then
            echo "Removing $package..."
            sudo apt purge -y $package
        else
            echo "$package is not installed. Skipping."
        fi
    done

    # Clean up unused dependencies
    echo "Cleaning up unused dependencies..."
    sudo apt autoremove -y

    # Optional: Remove configuration files and cache
    echo "Cleaning configuration files and cache..."
    sudo apt clean

    echo "Uninstallation complete!"
}

if [ "$1" == "install" ]; then
    install_wordpress_full
elif [ "$1" == "uninstall" ]; then
    uninstall_wordpress
else
    echo "Usage: $0 {install|uninstall}"
    exit 1
fi
