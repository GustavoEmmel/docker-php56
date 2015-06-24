Docker PHP-5.6
==============

Image contains:

* ubuntu 14.04
* nginx (latest)
* php 5.6
* php-fpm

php modules installed:

* pgsql
* mongo
* interbase
* curl
* apcu
* cgi
* igbinary
* yaml
* Twig and CTwig

php binary extensions were built using 
[this instructions](http://blog.remibergsma.com/2012/04/05/howto-create-php5-pecl-debian-packages/)

Usage
-----

Run a container with:

    $ docker run -d -p 8081:80 atnurgaliev/php56

This image can be used as base image for php projects. 

License
-------

BSD
