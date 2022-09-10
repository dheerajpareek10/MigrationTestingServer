
# Install apache server
sudo apt update && sudo apt install apache2 -y

# Allow ports 80 for application, 3306 for mysql and 22 for SSH connection
sudo ufw app list
sudo ufw allow in "Apache"
sudo ufw allow 3306
sudo ufw allow in "OpenSSH"
sudo ufw status
echo "y" | sudo ufw enable
sudo ufw status

# Install MySQL Server
sudo apt install mysql-server -y
sudo chmod +x secureMySQL.sh
sh secureMySQL.sh

# Install PHP 
sudo apt install php libapache2-mod-php php-mysql -y
php -v
sudo a2enmod rewrite
sudo systemctl restart apache2

# Allow access for apache and mysql from remote
sudo chmod 777 -R /etc/apache2/apache2.conf
sudo mv /etc/apache2/apache2.conf /etc/apache2/apache2_old.conf
sudo cp apache2.conf /etc/apache2/apache2.conf
sudo rm /etc/apache2/apache2_old.conf
sudo systemctl restart apache2

sudo chmod 777 -R /etc/mysql/mysql.conf.d/mysqld.cnf
sudo mv /etc/mysql/mysql.conf.d/mysqld.cnf /etc/mysql/mysql.conf.d/mysqld_old.cnf
sudo cp mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf
sudo rm /etc/mysql/mysql.conf.d/mysqld_old.cnf
sudo systemctl restart mysql

# Place the code in the server html folder
sudo chmod 777 -R /var/www/html
sudo mv IMS /var/www/html

# Create ubuntu user in mysql, give privileges and create shop_inventory database
sh createUser.sh

# Dump data in shop_inventory db
sudo mysql -u ubuntu -pUbuntu@123 shop_inventory < updateDB.sql
