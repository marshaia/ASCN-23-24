#! /bin/bash

USER=$USER
IP=$(hostname -I | awk '{print $2}')
PASS=12345

sudo apt install -y mysql-server

# Create a database
sudo mysql -e "CREATE DATABASE IF NOT EXISTS laravel;"

# Create a user
sudo mysql -e "CREATE USER '$USER'@'192.168.56.101' IDENTIFIED BY '$PASS';"

# Grant privileges to the user on the 'swap' database
sudo mysql -e "GRANT ALL PRIVILEGES ON laravel.* TO '$USER'@'192.168.56.101' WITH GRANT OPTION;"

sudo sed -i 's/^bind-address\s*=\s*127.0.0.1/bind-address = 192.168.56.102/' /etc/mysql/mysql.conf.d/mysqld.cnf

sudo /etc/init.d/mysql restart