#!/bin/bash

DEBIAN_FRONTEND=noninteractive

. /vagrant-fun/config

echo "***************************** Install Packages ***************************"
sudo -E apt-get update
sudo -E apt-get -y upgrade

echo "***************************** Install Apache *****************************"
sudo -E apt-get -y install apache2

echo "***************************** Modify Apache Docroot **********************"
cd /var/www
sudo -E chown -R $USER: html/
sudo -E chmod g+wx -R html/
sudo -E rm -f html/index.html

echo "***************************** Install MariaDB ****************************"
sudo -E debconf-set-selections <<< "mysql-server mysql-server/root_password password $mysql_root_password"
sudo -E debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $mysql_root_password"
sudo -E apt-get -y install mariadb-server

echo "***************************** Install PHP ********************************"
sudo -E apt-get -y install php libapache2-mod-php php-mysql

echo "***************************** Install PHP My Admin ***********************"
sudo -E debconf-set-selections <<< "phpmyadmin phpmyadmin/dbconfig-install boolean true"
sudo -E debconf-set-selections <<< "phpmyadmin phpmyadmin/app-password-confirm password $phpyadmin_password"
sudo -E debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/admin-pass password $mysql_root_password"
sudo -E debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/app-pass password $phpyadmin_password"
sudo -E debconf-set-selections <<< "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2"
sudo -E apt-get install -y phpmyadmin

echo "***************************** Restart Apache *****************************"
sudo -E service apache2 restart

echo "***************************** Create WP DB and User ***********************"
sudo -E mysql -u root -p$mysql_root_password -e "create database $wp_db;"
sudo -E mysql -u root -p$mysql_root_password -e "GRANT ALL PRIVILEGES ON $wp_db.* TO $wp_db_user@localhost IDENTIFIED BY '$wp_db_password'"
sudo -E mysql -u root -p$mysql_root_password -e "GRANT ALL PRIVILEGES ON $wp_db.* TO phpmyadmin@localhost IDENTIFIED BY '$phpyadmin_password'"

echo "***************************** Install WPCli *****************************"
cd /home/$USER
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
sudo -E mv wp-cli.phar /usr/local/bin/wp

echo "***************************** Install WordPress **************************"
cd /var/www/html
wp core download
wp core config --dbhost=localhost --dbname=$wp_db --dbuser=$wp_db_user --dbpass=$wp_db_password
wp core install --url=192.168.33.10 --title="$wp_site_title" --admin_name=$wp_admin_user --admin_password=$wp_admin_password --admin_email=$wp_admin_email

echo "***************************** Modify Apache Docroot **********************"
sudo -E usermod -a -G www-data $USER
cd /var/www
sudo -E chown -R www-data: html/
sudo -E chmod g+wx -R html/
