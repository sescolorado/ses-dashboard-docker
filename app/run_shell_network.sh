#!/bin/bash

docker run -i -t -p 127.0.0.1:80:80 --volumes-from ses_app --link ses_mysql:mysql --name "ses_app_shell" ses_app /bin/bash
docker rm ses_app_shell
