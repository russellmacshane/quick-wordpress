#!/bin/bash

source /quick-wordpress/config

echo "***************************** Backup Database ****************************"
sudo mysqldump $wp_db > datadump.sql

echo "***************************** Backups Files ******************************"
mkdir -p /quick-wordpress/backup
tar -cjvf /quick-wordpress/backup/$(date '+%F_%s').tar.bz2 /var/www/html datadump.sql

echo "***************************** Cleanup ************************************"
rm datadump.sql
