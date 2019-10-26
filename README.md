# Quick WordPress
Quick WordPress Installation using Vagrant

The goal of this project is to create a quick virtual machine setup with a WordPress installation for testing purposes. The following technologies are automatically installed for you:
* Ubuntu Bionic (18.04)
* Apache
* MariaDB
* PHP
* phpMyAdmin
* WPCli
* WordPress

## Pre-Installation
1. Install [Vagrant](https://www.vagrantup.com/)
2. Install [Virtual Box](https://www.virtualbox.org/)

## Installation Instructions
1. Find a directory on your computer that you'd like to install this repo
2. `$ git clone git@github.com:russellmacshane/quick-wordpress.git` or `git clone https://github.com/russellmacshane/quick-wordpress.git` if you don't have your [ssh keys setup](https://help.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
3. `$ cd quick-wordpress`
4. Your are strongly encouraged to modify the default passwords and WordPress setup information in the [config](./config) file
5. `$ vagrant up`
6. Grab some ☕️ coffee, it'll take a bit to install all the necessary dependencies

## Usage
1. Make sure the vagrant process is completed and your virtual machine is ready
2. Point your web browser over to http://192.168.33.10/ to view your WordPress site
3. You can also get to phpMyAdmin by going to http://192.168.33.10/phpmyadmin/
4. If you'd like to login into your virtual machine - `$ vagrant ssh` 
5. WordPress files are located in `/var/www/html` and you can run WPCli commands from there
6. This repo is mirrored from your local machine over to `/quick-wordpress` on your vm

## Backup and Restores
1. In order to do backup and restores login to your virtual machine - `$ vagrant ssh` 
2. `$ cd /quick-wordpress`
3. `$ ./backup.sh` and follow the on screen instructions
4. Backups are saved in the `/quick-wordpress/backups` directory 
5. If you'd like to restore from a previous backup - `$ ./restore.sh` and follow the on screen instructions

## Cleanup
1. If you are ready to delete your WordPress VM from you local machine - `$ vagrant destroy -f`

## Project Roadmap
* ~~LAMP Stack installed on Virtual Machine with WordPress using Vagrant~~
* ~~Plugin installations on initial WordPress install~~
* ~~Site Backups~~
* ~~Site Restores~~
* Web Application instead of bash scripts for WordPress install, backup, and restore
* Modifications to WP details in order to give a working WordPress backup to a host
