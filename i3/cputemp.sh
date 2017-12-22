#!/bin/sh
#sensors|grep Physical|cut -c18-26|awk '{printf "%.0f\n", $1}'

#desktop=/sys/devices/platform/coretemp.0/hwmon/hwmon0/temp1_input
#laptop=/sys/devices/platform/coretemp.0/hwmon/hwmon2/temp1_input

#if [ -f $desktop ]; then
#  cat $desktop | cut -c-2
#fi

#if [ -f $laptop ]; then
#  cat $laptop | cut -c-2
#fi

find /sys/devices/platform/coretemp.0 -name temp1_input -exec cat {} \; | cut -c-2

