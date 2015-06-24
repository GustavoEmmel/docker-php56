#!/bin/bash

#NGINX vhost
echo "Nginx setup..."
rm /etc/nginx/sites-enabled/*
cp /docker/nginx/nginx_vhost /etc/nginx/sites-available/
ln -s /etc/nginx/sites-available/nginx_vhost \
    /etc/nginx/sites-enabled/nginx_vhost

#PHP modules and FPM config
echo "PHP setup..."
dpkg -i /docker/modules/php5-igbinary_1.2.1-1_amd64.deb
dpkg -i /docker/modules/php5-yaml_1.2.0-1_amd64.deb
dpkg -i /docker/modules/php-twig_1.18.2-1_all.deb
dpkg -i /docker/modules/php5-ctwig_1.18.2-1_amd64.deb

echo "cgi.fix_pathinfo=0" >> /etc/php5/fpm/php.ini
cp /docker/fpm/www.conf /etc/php5/fpm/pool.d/www.conf

#Test page
echo "Creating test page..."
rm -R /var/www/*
mkdir -p -m 0755 /var/www/html && chown www-data:www-data /var/www/html
cp /docker/index.php /var/www/html/index.php
