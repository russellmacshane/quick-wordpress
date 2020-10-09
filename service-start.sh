#!/bin/bash

sudo service mysql restart
/usr/sbin/apache2ctl -D FOREGROUND
