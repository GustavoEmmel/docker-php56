Docker PHP-5.6
==============

Image contains:

* ubuntu 16.04
* nginx (latest)
* php 5.6
* php-fpm
* pear

php modules installed:

* interbase
* mysql
* pgsql
* mongo
* redis
* curl
* json
* mbstring
* gd
* xml
* zip
* igbinary

Usage
-----

Run a container with:

    $ docker run -d -p 8081:80 atnurgaliev/php56

This image can be used as base image for php projects. 

License
-------

BSD
