#!/bin/bash

if [ $# -lt 1 ]; then
        echo "Usage $0 <ses-dashboard application directory>"
        exit 1
fi

if [ -d $1 ]; then
        echo "Using $1 as the ses-dashboard application directory"
else
        echo "No ses-dashboard application directory specified."
	exit 1
fi

docker run -d -p 0.0.0.0:80:80 --name "ses_app" --link ses_mysql:mysql -v "$1":/var/www ses_app supervisord --nodaemon -c /etc/supervisor/supervisord.conf
