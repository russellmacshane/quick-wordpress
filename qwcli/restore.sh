#!/bin/bash

source /home/docker/quick-wordpress/config

echo "***************************** WordPress Restore **************************"
read -p "Enter the filename of the backup you would like to restore: " file

backup_dir=/home/docker/quick-wordpress/backup
backup_file=$backup_dir/$file

if [ ! -f $backup_file ]; then
    echo "$backup_file not found!" 1>&2
    echo ""
    echo "Available backups in $backup_dir"
    ls $backup_dir
    exit 1
fi

echo "***************************** Unpack Backup ******************************"
mkdir -p /tmp/wp-bkup
tar -xjvf $backup_file -C /tmp/wp-bkup

echo "***************************** Nuke WP Installation ***********************"
sudo rm -rf /var/www/html/*

echo "***************************** Restore Files ******************************"
sudo mv /tmp/wp-bkup/var/www/html/* /var/www/html/
sudo chown -R www-data: /var/www/html/

echo "***************************** Restore Database ***************************"
sudo mysql $wp_db < /tmp/wp-bkup/datadump.sql

echo "***************************** Cleanup ************************************"
rm -rf /tmp/wp-bkup
