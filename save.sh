#!/bin/bash

CURRENTDATE=`date +%Y%m%d`

sudo docker save ses_app > ses-app.tar
sudo docker save ses_mysql > ses-mysql.tar

rm -rf ses-dashboard.tar.gz
tar -czvf ses-dashboard.tar.gz ses-dashboard

rm -rf ses-dashboard-docker.tar.gz
tar -czvf ses-dashboard-docker.tar.gz ses-dashboard-docker

tar -czvf ses-dashboard-install-files_$CURRENTDATE.tar.gz ses-app.tar ses-mysql.tar ses-dashboard.tar.gz ses-dashboard-docker.tar.gz

openssl aes-256-cbc -salt -in ses-dashboard-install-files_$CURRENTDATE.tar.gz -out ses-dashboard-install-files_$CURRENTDATE.tar.gz.enc -pass pass:rd5CHNn3hD6MV6Pw
