#!/bin/bash

VOLUME_HOME="/var/lib/mysql"

if [[ ! -d $VOLUME_HOME/mysql ]]; then

    echo "=> An empty or uninitialized MySQL volume is detected in $VOLUME_HOME"
    echo "=> Installing MySQL ..."
    mysql_install_db > /dev/null 2>&1
    echo "=> Done!"
    /root/setup.sh
else
    echo "=> Using an existing volume of MySQL"
fi

supervisord --nodaemon -c /etc/supervisor/supervisord.conf
