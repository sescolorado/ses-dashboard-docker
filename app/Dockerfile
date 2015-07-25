# nginx with PHP5 for SES Dashboard

FROM ubuntu:14.04_updated

MAINTAINER dan@asdsoftwaredesign.com

###############################################################################
# install required packages

RUN apt-get update 
RUN DEBIAN_FRONTEND=noninteractive apt-get -y upgrade
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y software-properties-common
RUN add-apt-repository ppa:nginx/stable
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y git mysql-client nginx openssh-client php5-cli php5-fpm php5-mysql php5-json php5-mcrypt php5-xdebug supervisor wget

###############################################################################
# Fix up configuration files

RUN sed -i '/;cgi.fix_pathinfo=1/c\cgi.fix_pathinfo=0' /etc/php5/fpm/php.ini

RUN echo "daemon off;" >> /etc/nginx/nginx.conf

ADD ./nginx/default /etc/nginx/sites-enabled/default
ADD ./supervisor/supervisord.conf /etc/supervisor/supervisord.conf
ADD ./php-fpm/php-fpm.conf /etc/php5/fpm/php-fpm.conf
ADD ./php-fpm/run_php5-fpm.sh /root/run_php5-fpm.sh

RUN php5enmod json mcrypt mysql mysqli opcache pdo pdo_mysql xdebug

RUN chmod 775 /root/run_php5-fpm.sh

RUN mkdir /root/ftp_mirror

###############################################################################
# Get web application from gitlab

RUN mkdir -p /root/.ssh
ADD ./keys/id_rsa /root/.ssh/id_rsa
ADD ./keys/id_rsa.pub /root/.ssh/id_rsa.pub
RUN chmod 600 /root/.ssh/id_rsa
RUN ssh-keyscan -H gitlab.asdsoftwaredesign.com >> /root/.ssh/known_hosts
RUN rm -rf /var/www
RUN git -C /var clone git@gitlab.asdsoftwaredesign.com:sensible-energy-solutions/ses-dashboard.git www

ADD ./phpunit/phpunit.phar /var/www/phpunit
RUN chmod 775 /var/www/phpunit

RUN chown -R www-data:www-data /var/www
RUN chown -R www-data:www-data /var/log/nginx
RUN mkdir /var/log/php5-fpm
RUN chown -R www-data:www-data /var/log/php5-fpm

# Shared volume
VOLUME ["/etc/nginx", "/etc/php5", "/root/ftp_mirror", "/var/log/nginx", "/var/log/php5-fpm", "/var/www"]

###############################################################################
# Expose the proper ports

# Expose port 80 of the container
EXPOSE 80

###############################################################################
# Start the Supervisior

CMD ["supervisord", "--nodaemon", "-c", "/etc/supervisor/supervisord.conf"]
USER root
