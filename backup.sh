#!/bin/bash

source /quick-wordpress/config

echo "***************************** Backup Database ****************************"
sudo mysqldump $wp_db > $wp_db-datadump.sql
# mysql db_name < backup-file.sql (restore)
# https://mariadb.com/kb/en/library/mysqldump/

echo "***************************** Backups Files ******************************"
mkdir -p /quick-wordpress/backup
tar -cjvf /quick-wordpress/backup/$(date '+%F_%s').tar.bz2 /var/www/html $wp_db-datadump.sql
# https://www.howtogeek.com/248780/how-to-compress-and-extract-files-using-the-tar-command-on-linux/

echo "***************************** Cleanup ************************************"
rm $wp_db-datadump.sql
