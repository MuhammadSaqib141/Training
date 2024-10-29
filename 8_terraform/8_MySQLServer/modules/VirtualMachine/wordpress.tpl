#cloud-config
package_upgrade: true
packages:
  - apache2
  - ghostscript
  - libapache2-mod-php
  - mysql-server
  - php
  - php-bcmath
  - php-curl
  - php-imagick
  - php-intl
  - php-json
  - php-mbstring
  - php-mysql
  - php-xml
  - php-zip
  - php-gd
  - php-xmlrpc
  - curl

runcmd:
  - apt-get update || exit 1
  - systemctl start mysql || exit 1
  - while ! systemctl is-active --quiet mysql; do sleep 2; done
  - mysql -e "CREATE DATABASE IF NOT EXISTS ${database_name};" || exit 1
  - mysql -e "CREATE USER IF NOT EXISTS '${database_user}'@'${database_host}' IDENTIFIED BY '${database_password}';" || exit 1
  - mysql -e "GRANT ALL PRIVILEGES ON ${database_name}.* TO '${database_user}'@'${database_host}' WITH GRANT OPTION;" || exit 1
  - mysql -e "FLUSH PRIVILEGES;" || exit 1
  - mkdir -p /srv/www || exit 1
  - curl -s https://wordpress.org/latest.tar.gz | tar zx -C /srv/www || exit 1
  - cp /srv/www/wordpress/wp-config-sample.php /srv/www/wordpress/wp-config.php || exit 1
  - sed -i "s/database_name_here/${database_name}/" /srv/www/wordpress/wp-config.php || exit 1
  - sed -i "s/username_here/${database_user}/" /srv/www/wordpress/wp-config.php || exit 1
  - sed -i "s/password_here/${database_password}/" /srv/www/wordpress/wp-config.php || exit 1
  - sed -i "s/localhost/${database_host}/" /srv/www/wordpress/wp-config.php || exit 1

  - find /srv/www -type d -exec chmod 755 {} \; || exit 1
  - find /srv/www -type f -exec chmod 644 {} \; || exit 1
  - chown -R www-data:www-data /srv/www || exit 1
  - |
      cat <<EOF > /etc/apache2/sites-available/wordpress.conf
      <VirtualHost *:80>
          DocumentRoot /srv/www/wordpress
          <Directory /srv/www/wordpress>
              Options FollowSymLinks
              AllowOverride Limit Options FileInfo
              DirectoryIndex index.php
              Require all granted
          </Directory>
          <Directory /srv/www/wordpress/wp-content>
              Options FollowSymLinks
              Require all granted
          </Directory>
      </VirtualHost>
      EOF
  - a2ensite wordpress.conf || exit 1
  - a2enmod rewrite || exit 1
  - a2dissite 000-default || exit 1
  - systemctl restart apache2 || exit 1

final_message: "WordPress has been installed successfully!"
