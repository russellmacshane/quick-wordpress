# Quick WordPress
Quick WordPress Installation using Docker

The goal of this project is to create a quick virtual machine setup with a WordPress installation for testing purposes. The following technologies are automatically installed for you:
* Ubuntu 
* Apache
* MariaDB
* PHP
* phpMyAdmin
* WPCli
* WordPress

## Pre-Installation
1. Install [Docker](https://docs.docker.com/get-docker/)
2. Install [Docker Compose](https://docs.docker.com/compose/install/)

## Installation Instructions
1. Find a directory on your computer that you'd like to install this repo
2. `$ git clone git@github.com:russellmacshane/quick-wordpress.git` or `git clone https://github.com/russellmacshane/quick-wordpress.git` if you don't have your [ssh keys setup](https://help.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
3. `$ cd quick-wordpress`
4. Your are strongly encouraged to modify the default passwords and WordPress setup information in the [config](./config) file
5. `$ docker-compose up -d`
6. Grab some ☕️ coffee, it'll take a bit to install all the necessary dependencies

## Usage
1. Make sure the container is up and running with `$ docker-compose ps`
2. Point your web browser over to http://localhost/ to view your WordPress site
3. You can also get to phpMyAdmin by going to http://localhost/phpmyadmin/
4. If you'd like to login into the container - `$ docker-compose exec qwp /bin/bash` 
5. WordPress files are located in `/var/www/html` and you can run WPCli commands from there
6. This repo is mirrored from your local machine over to `/home/docker/quick-wordpress` on your container

## Backup and Restores
1. In order to do backup and restores:
2. `$ docker-compose exec qwp qwcli backup` and follow the on screen instructions
3. If you'd like to restore from a previous backup - `$ docker-compose exec qwp qwcli restore` and follow the on screen instructions

## Start and Stopping
1. `$ docker-compose stop` to stop the container
2. `$ docker-compose start` to bring it back up again

## Cleanup
1. If you are ready to delete your WordPress Container - `$ docker-compose down `
