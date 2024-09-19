#!/bin/bash
# Configure WordPress database credentials
sudo cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php

# Edit wp-config.php
# sudo bash -c 'cat <<EOF > /var/www/html/wp-config.php
# define('DB_NAME', 'wordpress_db');
# define('DB_USER', 'wordpress_user');
# define('DB_PASSWORD', 'your_password');
# define('DB_HOST', 'localhost');
# EOF'

sudo -u www-data sed -i 's/database_name_here/wordpress/' /var/www/html/wp-config.php
sudo -u www-data sed -i 's/username_here/wordpress/' /var/www/html/wp-config.php
sudo -u www-data sed -i 's/password_here/<your-password>/' /var/www/html/wp-config.php