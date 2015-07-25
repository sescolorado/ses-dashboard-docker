#!/bin/bash

if [ $# -lt 3 ]; then
	echo "Usage $0 <user> <password> <backup_file>"
	exit 1
fi

WORKINGDIR=`pwd`

mkdir /tmp/mysql_backup

tar -C /tmp/mysql_backup -xvf "$3"

cd /tmp/mysql_backup

bunzip2 ses_dashboard.sql.bz

mysql -u $1 -p"$2" -h127.0.0.1 ses_dashboard < ses_dashboard.sql

cd $WORKINGDIR

rm -rf /tmp/mysql_backup
