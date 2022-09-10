#!/bin/bash

# create new user ubuntu with password Ubuntu@123
sudo mysql -e "CREATE USER 'ubuntu'@'%' IDENTIFIED WITH mysql_native_password BY 'Ubuntu@123'"

# Grant all privileges to the new user
sudo mysql -e "GRANT ALL PRIVILEGES on *.* TO 'ubuntu'@'%' WITH GRANT OPTION"

# Create new Database "shop_inventory"
sudo mysql -e "CREATE DATABASE shop_inventory"
