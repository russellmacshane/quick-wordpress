#!/bin/bash

DEBIAN_FRONTEND=noninteractive

source /home/docker/quick-wordpress/config

echo 'debconf debconf/frontend select Noninteractive' | sudo debconf-set-selections

echo "***************************** Install Apache *****************************"
sudo DEBIAN_FRONTEND=noninteractive apt install -y apache2
sudo service apache2 restart

echo "***************************** Modify Apache Docroot **********************"
cd /var/www
sudo -E chown -R $(whoami): html/
sudo -E chmod g+wx -R html/
sudo -E rm -f html/index.html

echo "***************************** Install MariaDB ****************************"
sudo -E debconf-set-selections <<< "mysql-server mysql-server/root_password password $mysql_root_password"
sudo -E debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $mysql_root_password"
sudo -E apt install -y mariadb-server
sudo service mysql restart

echo "***************************** Install PHP ********************************"
sudo -E apt install -y php libapache2-mod-php php-mysql

echo "***************************** Install PHP My Admin ***********************"
sudo -E debconf-set-selections <<< "phpmyadmin phpmyadmin/dbconfig-install boolean true"
sudo -E debconf-set-selections <<< "phpmyadmin phpmyadmin/app-password-confirm password $phpyadmin_password"
sudo -E debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/admin-pass password $mysql_root_password"
sudo -E debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/app-pass password $phpyadmin_password"
sudo -E debconf-set-selections <<< "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2"
sudo -E apt install -y phpmyadmin

echo "***************************** Restart Apache *****************************"
sudo -E service apache2 restart

echo "***************************** Create WP DB and User ***********************"
sudo -E mysql -u root -p$mysql_root_password -e "create database $wp_db;"
sudo -E mysql -u root -p$mysql_root_password -e "GRANT ALL PRIVILEGES ON $wp_db.* TO $wp_db_user@localhost IDENTIFIED BY '$wp_db_password'"
sudo -E mysql -u root -p$mysql_root_password -e "GRANT ALL PRIVILEGES ON $wp_db.* TO phpmyadmin@localhost IDENTIFIED BY '$phpyadmin_password'"

echo "***************************** Install QWCli *****************************"
sudo -E ln -s /home/docker/quick-wordpress/qwcli/qwcli.sh /usr/local/bin/qwcli

echo "***************************** Install WPCli *****************************"
cd /home/$(whoami)
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
sudo -E mv wp-cli.phar /usr/local/bin/wp

echo "***************************** Install WordPress **************************"
cd /var/www/html
wp core download --version=$wp_version
wp core config --dbhost=localhost --dbname=$wp_db --dbuser=$wp_db_user --dbpass=$wp_db_password
wp core install --url=localhost --title="$wp_site_title" --admin_name=$wp_admin_user --admin_password=$wp_admin_password --admin_email=$wp_admin_email

echo "***************************** Plugins ************************************"
wp plugin delete hello

for plugin in "${plugins[@]}"
do
    wp plugin install $plugin --activate
done

echo "***************************** Modify Apache Docroot **********************"
sudo -E usermod -a -G www-data $(whoami)
cd /var/www
sudo -E chown -R www-data: html/
sudo -E chmod g+wx -R html/
