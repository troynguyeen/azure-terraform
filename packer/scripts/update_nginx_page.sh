#!/bin/bash

sudo rm /var/www/html/index.nginx-debian.html

sudo tar -xf /tmp/nginx-html.tar -C /var/www/html

#sudo sed -i -e "s|\(<h1>\).*\(<\/h1>\)|$CONTENT|g" /var/www/html/index.nginx-debian.html