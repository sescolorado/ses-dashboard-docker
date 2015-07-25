#!/bin/bash

docker run -d -p 127.0.0.1:3306:3306 --name "ses_mysql" ses_mysql supervisord --nodaemon -c /etc/supervisor/supervisord.conf
