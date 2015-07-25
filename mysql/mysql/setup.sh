#!/bin/bash

MYSQL_ADMIN_USER="ses_admin"

MYSQL_USER="ses"
MYSQL_USER_TEST="ses_testing"

MYSQL_DATABASE="ses_dashboard"
MYSQL_DATABASE_TEST="ses_dashboard_testing"

mysql_install_db > /dev/null 2>&1

/usr/bin/mysqld_safe > /dev/null 2>&1 &

RET=1
while [[ RET -ne 0 ]]; do
    echo "=> Waiting for confirmation of MySQL service startup"
    sleep 1
    mysql -uroot -e "status" > /dev/null 2>&1
    RET=$?
done

echo "=> Creating MySQL $MYSQL_USER user with random password"

PASS_USER=`pwgen -s 12 1`
mysql -uroot -e "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$PASS_USER'"
mysql -uroot -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' WITH GRANT OPTION"
mysql -uroot -e "CREATE DATABASE $MYSQL_DATABASE"

PASS_USER_TEST=`pwgen -s 12 1`
mysql -uroot -e "CREATE USER '$MYSQL_USER_TEST'@'%' IDENTIFIED BY '$PASS_USER_TEST'"
mysql -uroot -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE_TEST.* TO '$MYSQL_USER_TEST'@'%' WITH GRANT OPTION"
mysql -uroot -e "CREATE DATABASE $MYSQL_DATABASE_TEST"

PASS_ADMIN_USER=`pwgen -s 12 1`
mysql -uroot -e "CREATE USER '$MYSQL_ADMIN_USER'@'%' IDENTIFIED BY '$PASS_ADMIN_USER'"
mysql -uroot -e "GRANT ALL PRIVILEGES ON *.* TO '$MYSQL_ADMIN_USER'@'%' WITH GRANT OPTION"

echo "=> Done!"

echo "========================================================================"
echo "You can now connect to this MySQL Server using:"
echo ""
echo " mysql -u$MYSQL_ADMIN_USER -p$PASS_ADMIN_USER -h127.0.0.1"
echo " mysql -u$MYSQL_USER -p$PASS_USER -h127.0.0.1"
echo " mysql -u$MYSQL_USER_TEST -p$PASS_USER_TEST -h127.0.0.1"
echo ""
echo "Please remember to change the above password as soon as possible!"
echo "MySQL user 'root' has no password but only allows local connections"
echo "========================================================================"

echo "$MYSQL_ADMIN_USER : $PASS_ADMIN_USER" >> /root/mysql_passwords.txt
echo "$MYSQL_USER : $PASS_USER" >> /root/mysql_passwords.txt
echo "$MYSQL_USER_TEST : $PASS_USER_TEST" >> /root/mysql_passwords.txt


mysqladmin -uroot shutdown

RET=0
while [[ RET -eq 0 ]]; do
    echo "=> Waiting for confirmation of MySQL service shutdown"
    sleep 1
    mysql -uroot -e "status" > /dev/null 2>&1
    RET=$?
done

chown -R mysql:mysql /var/lib/mysql
chown -R mysql:mysql /var/log/mysql
