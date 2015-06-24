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
      php5-curl php5-apcu php5-cgi php-pear

ADD docker /docker
RUN chmod +x /docker/*.sh
RUN /docker/setup.sh

VOLUME ["/var/www/html/"]

EXPOSE 80

CMD ["/docker/run.sh"]
