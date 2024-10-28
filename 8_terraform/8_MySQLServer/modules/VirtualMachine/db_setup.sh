#!/bin/bash
# db_setup.sh
apt-get update
apt-get install -y mysql-server

systemctl start mysql

# Wait until MySQL is active
while ! systemctl is-active --quiet mysql; do sleep 2; done

# Create a database and user for WordPress
mysql -e "CREATE DATABASE IF NOT EXISTS wordpress_db;"
mysql -e "CREATE USER IF NOT EXISTS 'wordpress_user'@'%' IDENTIFIED BY 'Saqib@1122';"
mysql -e "GRANT ALL PRIVILEGES ON wordpress_db.* TO 'wordpress_user'@'%';"
mysql -e "FLUSH PRIVILEGES;"

# Allow MySQL to accept connections from the WordPress VM
echo "bind-address = 0.0.0.0" >> /etc/mysql/mysql.conf.d/mysqld.cnf
systemctl restart mysql

echo "Database setup completed."
