#!/bin/bash

source /quick-wordpress/config

echo "***************************** WordPress Backup **************************"
run=true
while $run
do
 read -r -p "Would you like to name your backup? [Y/n] " input

 case $input in
     [yY][eE][sS]|[yY])
       read -p "Enter the filename of your backup: " file
       backup_file=$file.tar.bz2
       echo "Will name backup $backup_file"
       run=false
       ;;

     [nN][oO]|[nN])
      backup_file=$(date '+%F_%s').tar.bz2
      echo "Will name backup $backup_file"
      run=false
      ;;

     *)
      echo "Invalid input..."
      ;;
 esac
done

echo "***************************** Backup Database ****************************"
sudo mysqldump $wp_db > datadump.sql

echo "***************************** Backups Files ******************************"
mkdir -p /quick-wordpress/backup
tar -cjvf /quick-wordpress/backup/$backup_file /var/www/html datadump.sql

echo "***************************** Cleanup ************************************"
rm datadump.sql
