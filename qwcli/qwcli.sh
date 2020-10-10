#!/bin/bash

# https://github.com/brotandgames/bagcli -- example location

cli_help() {
  cli_name=${0##*/}
  echo "
$cli_name
Quick WordPress CLI
Version: 1.0.0
https://github.com/russellmacshane/quick-wordpress

Usage: $cli_name [command]

Commands:
  backup    Backup
  list      List Backups
  restore   Restore
  *         Help
"
  exit 1
}

case "$1" in
  backup|b)
    /home/docker/quick-wordpress/qwcli/backup.sh
    ;;
  list|l)
    ls /home/docker/quick-wordpress/backup
    ;;
  restore|r)
    /home/docker/quick-wordpress/qwcli/restore.sh
    ;;
  *)
    cli_help
    ;;
esac
