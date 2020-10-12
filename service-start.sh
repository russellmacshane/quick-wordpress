#!/bin/bash

sudo service mysql restart
sudo apache2ctl -D FOREGROUND
