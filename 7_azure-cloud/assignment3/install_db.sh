#!/bin/bash

# Update and install MySQL server
sudo apt update -y
sudo apt install mysql-server -y

# Allow remote access by modifying MySQL configuration
sudo sed -i "s/bind-address.*$/bind-address = 0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf
sudo systemctl restart mysql

# Create database and user
DB_NAME='wordpress_db'
DB_USER='wordpress_user'
DB_PASSWORD='Saqib@1122'

sudo mysql <<EOF
CREATE DATABASE IF NOT EXISTS $DB_NAME;
CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';
GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%';
FLUSH PRIVILEGES;
