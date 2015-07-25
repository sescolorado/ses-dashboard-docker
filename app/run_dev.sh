#!/bin/bash

docker run -d -p 127.0.0.1:80:80 --name "ses_app" --link ses_mysql:mysql -v /www/ses-dashboard/:/var/www ses_app supervisord --nodaemon -c /etc/supervisor/supervisord.conf
