#!/bin/bash

docker run -i -t --volumes-from ses_app --link ses_mysql:mysql --name "ses_app_shell" ses_app /bin/bash
docker rm ses_app_shell
