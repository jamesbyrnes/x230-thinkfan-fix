#!/bin/bash
#
# THINKFAN CHANGING HWMON FIX
#
# james byrnes, 2017

# First, let's check with systemd to see if thinkfan started successfully

THINKFAN_RESULT=$(systemctl show thinkfan.service | grep ^Result | cut -d "=" -f 2)

# If the result is succesful then let's quit out now.
if [[ $THINKFAN_RESULT = 'success' ]]; then
    exit 0
fi

# Else, we have to find out what the actual hwmon directory is.
# Keep in mind that this will likely be device specific!
ROOT_HWMON_DIR="/sys/devices/platform/coretemp.0/hwmon"
TARGET_FILENAME="temp1_input"
HWMONX_DIR=$(find $ROOT_HWMON_DIR -name $TARGET_FILENAME -printf "%h" | rev | cut -d "/" -f 1 | rev)

# Now we need to escape the characters in $ROOT_HWMON_DIR, whee...
ROOT_HWMON_DIR_ESC=$(echo $ROOT_HWMON_DIR | sed -e 's/\//\\\//g')

sed -i -e 's/\('"$ROOT_HWMON_DIR_ESC"'\/\)hwmon[0-9]/\1'"$HWMONX_DIR"'/g' /etc/thinkfan.conf

# Finally, let's try restarting the service...
systemctl restart thinkfan.service
