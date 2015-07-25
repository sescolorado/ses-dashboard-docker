# MySQL Instance for SES Dashboard

FROM ubuntu:14.04_updated

MAINTAINER dan@asdsoftwaredesign.com

###############################################################################
# install required packages

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y upgrade
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-server mysql-client supervisor pwgen

###############################################################################
# Fix up configuration files

RUN sed -i '/key_buffer/c\key_buffer_size         = 16M' /etc/mysql/my.cnf
RUN sed -i '/myisam-recover/c\myisam-recover-options   = BACKUP' /etc/mysql/my.cnf

ADD ./mysql/my.cnf /etc/mysql/conf.d/my.cnf
ADD ./supervisor/supervisord.conf /etc/supervisor/supervisord.conf

###############################################################################
# Setup MySQL

RUN rm -rf /var/lib/mysql/*

ADD ./mysql/setup.sh /root/setup.sh
RUN chmod 755 /root/setup.sh
RUN /root/setup.sh

###############################################################################
# Shared volumes

VOLUME ["/etc/mysql", "/var/lib/mysql", "/var/log/mysql"]

###############################################################################
# Expose ports

EXPOSE 3306

###############################################################################
# Start the Supervisior

CMD ["supervisord", "--nodaemon", "-c", "/etc/supervisor/supervisord.conf"]
USER root
