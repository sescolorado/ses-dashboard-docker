#!/bin/bash

if [ $# -lt 3 ]; then
	echo "Usage $0 <user> <password> <backup_prefix>"
	exit 1
fi

WORKINGDIR=`pwd`

mkdir /tmp/mysql_backup
cd /tmp/mysql_backup

mysqldump -u $1 -p"$2" -h127.0.0.1 ses_dashboard | bzip2 - > ses_dashboard.sql.bz

CURRENTDATE=`date +%Y%m%d_%H%M%S`

tar -cvf "$3_$CURRENTDATE.tar" ses_dashboard.sql.bz

mv "$3_$CURRENTDATE.tar" $WORKINGDIR

cd $WORKINGDIR

rm -rf /tmp/mysql_backup
