#!/bin/bash

# Configuration
DB_NAME='wordpress_db'
DB_USER='wordpress_user'
DB_PASSWORD='Saqib@1122'
DB_HOST='<YOUR_DB_VM_IP>'  # Replace with the actual IP of your database VM
WP_DIR='/srv/www'

install_packages() {
 echo "Updating package list..."
 sudo apt update -y
 echo "Installing necessary packages..."
 sudo apt install -y apache2 \
                 ghostscript \
                 libapache2-mod-php \
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

set_permissions() {
 echo "Setting permissions for WordPress directory..."
 sudo chown -R www-data:www-data $WP_DIR
 sudo chmod -R 755 $WP_DIR
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
 sudo sed -i "s/localhost/$DB_HOST/" $WP_DIR/wordpress/wp-config.php  # Set DB host
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
 install_wordpress
 configure_wp_config  
 set_permissions
 configure_apache
 restart_apache

 echo "WordPress has been installed successfully!"
}


install_wordpress_full
