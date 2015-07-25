#!/bin/bash

CONF_FILE_LOCATION="/etc/php5/fpm/pool.d/www.conf"

# Function to update the fpm configuration to make the service environment variables available
function setEnvironmentVariable() {

    if [ -z "$2" ]; then
        echo "Environment variable '$1' not set."
        return
    fi

    # Check whether variable already exists
    if grep -q "env\[$1\]" "$CONF_FILE_LOCATION"; then
        # Reset variable
        sed -i 's/^env\[$1].*/c\env[$1] = "$2"/g' "$CONF_FILE_LOCATION"
    else
        # Add variable
        echo "env[$1] = $2" >> "$CONF_FILE_LOCATION"
    fi
}

# Grep for variables that look like docker set them (_PORT_)
for _curVar in `env | grep _PORT | awk -F = '{print $1}'`;do
    # awk has split them by the equals sign
    # Pass the name and value to our function
    setEnvironmentVariable ${_curVar} ${!_curVar}
done

# Log something to the supervisord log so we know this script as run
echo "DONE"

# Now start php-fpm
/usr/sbin/php5-fpm -c /etc/php5/fpm
