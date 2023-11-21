#!/bin/bash

HOSTNAME=$(hostname)
ACCOUNTNAME="thanhnc85"

sudo sed -i -e "s|#HOSTNAME|$HOSTNAME|g" /var/www/html/index.nginx-debian.html

sudo sed -i -e "s|#ACCOUNTNAME|$ACCOUNTNAME|g" /var/www/html/index.nginx-debian.html