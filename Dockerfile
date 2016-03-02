FROM ubuntu:14.04

MAINTAINER Alexey Nurgaliev <atnurgaliev@gmail.com>

ENV LANG=C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y software-properties-common libyaml-0-2 && \
    add-apt-repository -y ppa:ondrej/php5-5.6 && \
    add-apt-repository -y ppa:nginx/stable && \
    apt-get update && \
    apt-get install -y nginx \
      php5 php5-interbase php5-mongo php5-pgsql php5-fpm \
      php5-curl php5-apcu php5-cgi php-pear &&\
    apt-get purge -y --auto-remove software-properties-common

ADD docker /docker

RUN rm /etc/nginx/sites-enabled/* &&\
    cp /docker/nginx/nginx_vhost \
       /etc/nginx/sites-available/ &&\
    ln -s /etc/nginx/sites-available/nginx_vhost \
        /etc/nginx/sites-enabled/nginx_vhost &&\

    dpkg -i /docker/modules/php5-igbinary_1.2.1-1_amd64.deb &&\
    dpkg -i /docker/modules/php5-yaml_1.2.0-1_amd64.deb &&\
    dpkg -i /docker/modules/php-twig_1.18.2-1_all.deb &&\
    dpkg -i /docker/modules/php5-ctwig_1.18.2-1_amd64.deb &&\
    cp /docker/fpm/www.conf /etc/php5/fpm/pool.d/www.conf &&\

    rm -R /var/www/* &&\
    mkdir -p -m 0755 /var/www/html &&\
    chown www-data:www-data /var/www/html &&\
    cp /docker/index.php /var/www/html/index.php &&\

    rm -R /docker

VOLUME ["/var/www/html/", "/var/lib/php5/sessions"]

EXPOSE 80

CMD php5-fpm --allow-to-run-as-root --nodaemonize \
             --fpm-config /etc/php5/fpm/php-fpm.conf & \
    nginx -g "daemon off;"
