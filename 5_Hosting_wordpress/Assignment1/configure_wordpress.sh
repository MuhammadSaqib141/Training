#!/bin/bash
# Configure WordPress database credentials
sudo cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php

# Edit wp-config.php
sudo bash -c 'cat <<EOF > /var/www/html/wp-config.php
define('DB_NAME', 'wordpress_db');
define('DB_USER', 'wordpress_user');
define('DB_PASSWORD', 'your_password');
define('DB_HOST', 'localhost');
EOF'
