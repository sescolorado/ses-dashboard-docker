#!/bin/bash

docker run -t -i --volumes-from ses_mysql --name "ses_mysql_shell" ses_mysql /bin/bash
docker rm ses_mysql_shell
