#!/bin/bash
# Create Apache configuration for WordPress
sudo bash -c 'cat <<EOF > /etc/apache2/sites-available/wordpress.conf
<VirtualHost *:80>
    ServerAdmin admin@yourdomain.com
    DocumentRoot /var/www/html
    ServerName yourdomain.com
    ServerAlias www.yourdomain.com

    <Directory /var/www/html/>
        Options FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF'

# Enable site and rewrite module
sudo a2ensite wordpress.conf
sudo a2enmod rewrite
sudo a2dissite 000-default
sudo service apache2 reload

